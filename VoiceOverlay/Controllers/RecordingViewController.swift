//
//  ListeningViewController.swift
//  VoiceUI
//
//  Created by Guy Daher on 25/06/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import UIKit

class RecordingViewController: UIViewController {
  
  var speechController: SpeechController!
  
  var speechTextHandler: SpeechTextHandler?
  var speechErrorHandler: SpeechErrorHandler?
  weak var delegate: VoiceOverlayDelegate?
  
  let titleLabel = UILabel()
  let subtitleLabel = UILabel()
  let closeView = CloseView()
  let recordingButton = RecordingButton()
  let tryAgainLabel = UILabel()
  
  var isRecording: Bool = false
  var autoStopTimer: Timer = Timer()
  
  var speechText: String?
  var speechError: Error?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let margins = view.layoutMarginsGuide
    let subViews = [titleLabel, subtitleLabel, closeView, recordingButton, tryAgainLabel]
    
    ViewHelpers.translatesAutoresizingMaskIntoConstraintsFalse(for: subViews)
    ViewHelpers.addSubviews(for: subViews, in: view)
    
    view.backgroundColor = VoiceUIConstants.PermissionScreen.backgroundColor
    ViewHelpers.setConstraintsForTitleLabel(titleLabel, margins, VoiceUIConstants.RecordingScreen.titleInitial)
    ViewHelpers.setConstraintsForSubtitleLabel(subtitleLabel, titleLabel, margins, VoiceUIConstants.RecordingScreen.subtitleInitial)
    ViewHelpers.setConstraintsForCloseView(closeView, margins)
    ViewHelpers.setConstraintsForRecordingButton(recordingButton, margins)
    ViewHelpers.setConstraintsForTryAgainLabel(tryAgainLabel, recordingButton, margins, "")
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(self.closeButtonTapped(_:)))
    closeView.addGestureRecognizer(tap)
    
    recordingButton.addTarget(self, action: #selector(recordingButtonTapped), for: .touchUpInside)
    
    if VoiceUIConstants.RecordingScreen.autoStart {
      titleLabel.text = VoiceUIConstants.RecordingScreen.titleListening
      toggleRecording(recordingButton)
    }
  }
  
  @objc func recordingButtonTapped() {
    if isRecording {
      speechController.stopRecording()
    } else {
      toggleRecording(recordingButton)
    }
  }
  
  @objc func closeButtonTapped(_ sender: UITapGestureRecognizer) {
    self.delegate = nil
    self.speechTextHandler = nil
    self.speechErrorHandler = nil
    speechController.stopRecording()
    dismissMe(animated: true)
  }

  func toggleRecording(_ recordingButton: RecordingButton, dismiss: Bool = true) {
    isRecording = !isRecording
    recordingButton.animate(isRecording)
    recordingButton.setimage(isRecording)
    
    if isRecording {
      titleLabel.text = VoiceUIConstants.RecordingScreen.titleListening
      subtitleLabel.text = VoiceUIConstants.RecordingScreen.subtitleInitial
      tryAgainLabel.text = ""
    } else {
      speechController.stopRecording()
      self.delegate?.recording(text: self.speechText, final: true, error: self.speechError)
      
      if let speechText = self.speechText {
        self.speechTextHandler?(speechText, true)
      } else {
        self.speechErrorHandler?(self.speechError)
      }
      if dismiss {
        dismissMe(animated: true)
      }
      return
    }
    
    // TODO: Playing sound is crashing. probably because we re not stopping play, or interfering with speech controller, or setActive true/false in playSound
    //recordingButton.playSound(with: isRecording ? .startRecording : .endRecording)
    
    speechController.startRecording(textHandler: {[weak self] (text, final) in
      self?.speechText = text
      self?.speechError = nil
      self?.subtitleLabel.text = text
      
      if final {
        self?.autoStopTimer.invalidate()
        self?.toggleRecording(recordingButton)
        return
      } else {
        self?.delegate?.recording(text: text, final: final, error: nil)
        self?.speechTextHandler?(text, final)
      }
      
      if VoiceUIConstants.RecordingScreen.autoStop && !text.isEmpty {
        self?.autoStopTimer.invalidate()
        self?.autoStopTimer = Timer.scheduledTimer(withTimeInterval: VoiceUIConstants.RecordingScreen.autoStopTimeout, repeats: false, block: { (_) in
          self?.toggleRecording(recordingButton)
        })
      }
      
      }, errorHandler: { [weak self] error in
        self?.speechText = nil
        self?.speechError = error
        self?.delegate?.recording(text: nil, final: nil, error: error)
        self?.speechErrorHandler?(error)
        self?.handleVoiceError(error)
    })
  }
  
  func handleVoiceError(_ error: Error?) {
    titleLabel.text = VoiceUIConstants.RecordingScreen.titleError
    subtitleLabel.text = VoiceUIConstants.RecordingScreen.subtitleError
    tryAgainLabel.text = VoiceUIConstants.RecordingScreen.tryAgainText
    toggleRecording(recordingButton, dismiss: false)
  }
}
