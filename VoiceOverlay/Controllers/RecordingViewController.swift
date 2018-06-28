//
//  ListeningViewController.swift
//  VoiceUI
//
//  Created by Guy Daher on 25/06/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import UIKit

public typealias VoiceOverlayHandler = (_ text: String?, _ final: Bool?, _ error: Error?) -> Void

class RecordingViewController: UIViewController {

    var speechController: SpeechController!
    var isRecording: Bool = false
    var searchText: String = ""
    weak var delegate: VoiceOverlayDelegate?
    var voiceOverlayHandler: VoiceOverlayHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let margins = view.layoutMarginsGuide
        let titleLabel = UILabel()
        let subtitleLabel = UILabel()
        let closeView = CloseView()
        let recordingButton = RecordingButton()
        let tryAgainLabel = UILabel()
        
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
        
        recordingButton.addTarget(self, action: #selector(recordingButtobTapped(_:)), for: .touchUpInside)
    }
    
    @objc func recordingButtobTapped(_ recordingButton: RecordingButton) {
        toogleRecording(recordingButton)
    }
    
    @objc func closeButtonTapped(_ sender: UITapGestureRecognizer) {
        dismissMe(animated: true)
    }
    
    func toogleRecording(_ recordingButton: RecordingButton) {
        isRecording = !isRecording
        recordingButton.animate(isRecording)
        recordingButton.setimage(isRecording)
        
        // TODO: Playing sound is crashing. probably because we re not stopping play, or interfering with speech controller, or setActive true/false in playSound
        //recordingButton.playSound(with: isRecording ? .startRecording : .endRecording)
        
        if !isRecording {
            speechController.stopRecording()
            dismissMe(animated: true)
            return
        }
        
        speechController.startRecording(textHandler: {[weak self] (text, final) in
            self?.delegate?.recording(text: text, final: final, error: nil)
            self?.voiceOverlayHandler?(text, final, nil)
            self?.searchText = text
            
            if final {
                self?.toogleRecording(recordingButton)
                return
            }
            }, errorHandler: { [weak self] error in
                self?.delegate?.recording(text: nil, final: nil, error: error)
                self?.voiceOverlayHandler?(nil, nil, error)
                self?.handleVoiceError(error)
        })
    }
    
    func handleVoiceError(_ error: Error?) {
        
    }
}
