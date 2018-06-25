//
//  ViewController.swift
//  VoiceUI
//
//  Created by Guy Daher on 20/06/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import UIKit

public class PermissionViewController: UIViewController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let margins = view.layoutMarginsGuide
        let titleLabel = UILabel()
        let subtitleLabel = UILabel()
        let allowMicrophoneAccessButton = AllowPermissionButton()
        let rejectMicrophoneAccessButton = UIButton()
        let closeView = CloseView()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        allowMicrophoneAccessButton.translatesAutoresizingMaskIntoConstraints = false
        rejectMicrophoneAccessButton.translatesAutoresizingMaskIntoConstraints = false
        closeView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(allowMicrophoneAccessButton)
        view.addSubview(rejectMicrophoneAccessButton)
        view.addSubview(closeView)
        
        view.backgroundColor = VoiceUIConstants.PermissionScreen.backgroundColor
        setConstraintsForTitleLabel(titleLabel, margins)
        setConstraintsForSubtitleLabel(subtitleLabel, titleLabel, margins)
        setConstraintsForCloseView(closeView, margins)
        setConstraintsForAllowMicrophoneAccess(allowMicrophoneAccessButton, margins)
        setConstraintsForRejectMicrophoneAccessButton(rejectMicrophoneAccessButton, allowMicrophoneAccessButton, margins)
        
        allowMicrophoneAccessButton.addTarget(self, action: #selector(allowMicrophoneTapped), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.closeButtonTapped(_:)))
        closeView.addGestureRecognizer(tap)
    }
    
    @objc func allowMicrophoneTapped() {
        let listeningViewController = ListeningViewController()
        self.present(listeningViewController, animated: false)
    }
    
    @objc func closeButtonTapped(_ sender: UITapGestureRecognizer) {
        dismissMe(animated: true)
    }

}
