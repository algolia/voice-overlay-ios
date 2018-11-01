//
//  ViewController.swift
//  VoiceUI
//
//  Created by Guy Daher on 20/06/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import UIKit
import AVFoundation

@available(iOS 10.0, *)
class PermissionViewController: UIViewController {
    
    var dismissHandler: (() -> ())? = nil
    var speechController: Recordable!
  
    var constants: PermissionScreenConstants!
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let margins = view.layoutMarginsGuide

        let allowMicrophoneAccessButton = FirstPermissionButton(startColor: constants.startGradientColor, endColor: constants.endGradientColor)
        let rejectMicrophoneAccessButton = UIButton()
        let closeView = CloseView()
        
        let subViews = [titleLabel, subtitleLabel, allowMicrophoneAccessButton, rejectMicrophoneAccessButton, closeView]
        
        ViewHelpers.translatesAutoresizingMaskIntoConstraintsFalse(for: subViews)
        ViewHelpers.addSubviews(for: subViews, in: view)
        
        view.backgroundColor = constants.backgroundColor
        ViewHelpers.setConstraintsForTitleLabel(titleLabel, margins, constants.title, constants.textColor)
        ViewHelpers.setConstraintsForSubtitleLabel(subtitleLabel, titleLabel, margins, constants.subtitle, constants.textColor)
        ViewHelpers.setConstraintsForCloseView(closeView, margins, backgroundColor: constants.backgroundColor)
        ViewHelpers.setConstraintsForFirstButton(allowMicrophoneAccessButton, margins, constants.allowText, constants.textColor)
        ViewHelpers.setConstraintsForSecondButton(rejectMicrophoneAccessButton, allowMicrophoneAccessButton, margins, constants.rejectText, constants.textColor)
        
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
  
    public override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      titleLabel.preferredMaxLayoutWidth = self.view.frame.width - VoiceUIInternalConstants.sideMarginConstant * 2
      subtitleLabel.preferredMaxLayoutWidth = self.view.frame.width - VoiceUIInternalConstants.sideMarginConstant * 2
      self.view.layoutIfNeeded()
    }
    
    @objc func rejectMicrophoneTapped() {
        dismissMe(animated: true)
    }
    
    @objc func closeButtonTapped(_ sender: UITapGestureRecognizer) {
        dismissMe(animated: true)
    }

}
