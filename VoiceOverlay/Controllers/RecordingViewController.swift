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
    var isRecording: Bool = false
    weak var delegate: VoiceOverlayDelegate?
    var speechTextHandler: SpeechTextHandler?
    var speechErrorHandler: SpeechErrorHandler?
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let closeView = CloseView()
    let recordingButton = RecordingButton()
    let tryAgainLabel = UILabel()
    
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
        
        recordingButton.addTarget(self, action: #selector(recordingButtonTapped(_:)), for: .touchUpInside)
        
        if VoiceUIConstants.RecordingScreen.instantStart {
            titleLabel.text = VoiceUIConstants.RecordingScreen.titleListening
            toogleRecording(recordingButton)
        }
    }
    
    @objc func recordingButtonTapped(_ recordingButton: RecordingButton) {
        toogleRecording(recordingButton)
    }
    
    @objc func closeButtonTapped(_ sender: UITapGestureRecognizer) {
        if speechController.isRecording() {
            toogleRecording(recordingButton)
        }
        
        dismissMe(animated: true)
    }
    
    func toogleRecording(_ recordingButton: RecordingButton, dismiss: Bool = true) {
        isRecording = !isRecording
        recordingButton.animate(isRecording)
        recordingButton.setimage(isRecording)
        
        if isRecording {
            titleLabel.text = VoiceUIConstants.RecordingScreen.titleListening
            subtitleLabel.text = VoiceUIConstants.RecordingScreen.subtitleInitial
            tryAgainLabel.text = ""
        }
        
        // TODO: Playing sound is crashing. probably because we re not stopping play, or interfering with speech controller, or setActive true/false in playSound
        //recordingButton.playSound(with: isRecording ? .startRecording : .endRecording)
        
        if !isRecording {
            speechController.stopRecording()
            if dismiss {
                dismissMe(animated: true)
            }
            return
        }
        
        speechController.startRecording(textHandler: {[weak self] (text, final) in
            self?.delegate?.recording(text: text, final: final, error: nil)
            self?.speechTextHandler?(text, final)
            self?.subtitleLabel.text = text
            
            if final {
                self?.toogleRecording(recordingButton)
                return
            }
            }, errorHandler: { [weak self] error in
                self?.delegate?.recording(text: nil, final: nil, error: error)
                self?.speechErrorHandler?(error)
                self?.handleVoiceError(error)
        })
    }
    
    func handleVoiceError(_ error: Error?) {
        titleLabel.text = VoiceUIConstants.RecordingScreen.titleError
        subtitleLabel.text = VoiceUIConstants.RecordingScreen.subtitleError
        tryAgainLabel.text = VoiceUIConstants.RecordingScreen.tryAgainText
        toogleRecording(recordingButton, dismiss: false)
    }
}
