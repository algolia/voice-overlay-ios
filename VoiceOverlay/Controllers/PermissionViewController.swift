//
//  ViewController.swift
//  VoiceUI
//
//  Created by Guy Daher on 20/06/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import UIKit

public class PermissionViewController: UIViewController {
    
    var dismissHandler: (() -> Void)? = nil
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let margins = view.layoutMarginsGuide
        let titleLabel = UILabel()
        let subtitleLabel = UILabel()
        let allowMicrophoneAccessButton = AllowPermissionButton()
        let rejectMicrophoneAccessButton = UIButton()
        let closeView = CloseView()
        
        let subViews = [titleLabel, subtitleLabel, allowMicrophoneAccessButton, rejectMicrophoneAccessButton, closeView]
        
        ViewHelpers.translatesAutoresizingMaskIntoConstraintsFalse(for: subViews)
        ViewHelpers.addSubviews(for: subViews, in: view)
        
        view.backgroundColor = VoiceUIConstants.PermissionScreen.backgroundColor
        ViewHelpers.setConstraintsForTitleLabel(titleLabel, margins, VoiceUIConstants.PermissionScreen.title)
        ViewHelpers.setConstraintsForSubtitleLabel(subtitleLabel, titleLabel, margins, VoiceUIConstants.PermissionScreen.subtitle)
        ViewHelpers.setConstraintsForCloseView(closeView, margins)
        ViewHelpers.setConstraintsForAllowMicrophoneAccess(allowMicrophoneAccessButton, margins)
        ViewHelpers.setConstraintsForRejectMicrophoneAccessButton(rejectMicrophoneAccessButton, allowMicrophoneAccessButton, margins)
        
        allowMicrophoneAccessButton.addTarget(self, action: #selector(allowMicrophoneTapped), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.closeButtonTapped(_:)))
        closeView.addGestureRecognizer(tap)
    }
    
    @objc func allowMicrophoneTapped() {
        dismissMe(animated: false) {
            self.dismissHandler?()
        }
        
    }
    
    @objc func closeButtonTapped(_ sender: UITapGestureRecognizer) {
        dismissMe(animated: true)
    }

}
