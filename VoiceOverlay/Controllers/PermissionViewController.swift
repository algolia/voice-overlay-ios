//
//  ViewController.swift
//  VoiceUI
//
//  Created by Guy Daher on 20/06/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import UIKit
import AVFoundation

public class PermissionViewController: UIViewController {
    
    var dismissHandler: (() -> ())? = nil
    var speechController: SpeechController!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let margins = view.layoutMarginsGuide
        let titleLabel = UILabel()
        let subtitleLabel = UILabel()
        let allowMicrophoneAccessButton = FirstPermissionButton(startColor: VoiceUIConstants.PermissionScreen.startGradientColor, endColor: VoiceUIConstants.PermissionScreen.endGradientColor)
        let rejectMicrophoneAccessButton = UIButton()
        let closeView = CloseView()
        
        let subViews = [titleLabel, subtitleLabel, allowMicrophoneAccessButton, rejectMicrophoneAccessButton, closeView]
        
        ViewHelpers.translatesAutoresizingMaskIntoConstraintsFalse(for: subViews)
        ViewHelpers.addSubviews(for: subViews, in: view)
        
        view.backgroundColor = VoiceUIConstants.PermissionScreen.backgroundColor
        ViewHelpers.setConstraintsForTitleLabel(titleLabel, margins, VoiceUIConstants.PermissionScreen.title)
        ViewHelpers.setConstraintsForSubtitleLabel(subtitleLabel, titleLabel, margins, VoiceUIConstants.PermissionScreen.subtitle)
        ViewHelpers.setConstraintsForCloseView(closeView, margins)
        ViewHelpers.setConstraintsForFirstButton(allowMicrophoneAccessButton, margins, VoiceUIConstants.PermissionScreen.allowMicrophoneAccessText)
        ViewHelpers.setConstraintsForSecondButton(rejectMicrophoneAccessButton, allowMicrophoneAccessButton, margins, VoiceUIConstants.PermissionScreen.rejectMicrophoneAccessText)
        
        allowMicrophoneAccessButton.addTarget(self, action: #selector(allowMicrophoneTapped), for: .touchUpInside)
        rejectMicrophoneAccessButton.addTarget(self, action: #selector(rejectMicrophoneTapped), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.closeButtonTapped(_:)))
        closeView.addGestureRecognizer(tap)
    }
    
    @objc func allowMicrophoneTapped() {
        
        speechController.requestAuthorization { _ in
            AVAudioSession.sharedInstance().requestRecordPermission({ (isGranted) in
                self.dismissMe(animated: true) {
                    self.dismissHandler?()
                }
            })
        }
    }
    
    @objc func rejectMicrophoneTapped() {
        dismissMe(animated: true)
    }
    
    @objc func closeButtonTapped(_ sender: UITapGestureRecognizer) {
        dismissMe(animated: true)
    }

}
