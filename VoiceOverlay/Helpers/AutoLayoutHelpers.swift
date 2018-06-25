//
//  AutoLayoutHelpers.swift
//  VoiceUI
//
//  Created by Guy Daher on 25/06/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import Foundation
import UIKit


    public func setConstraintsForTitleLabel(_ titleLabel: UILabel, _ margins: UILayoutGuide) {
        setDefaultSideConstraints(to: titleLabel, in: margins)
        titleLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 100).isActive = true
        titleLabel.text = VoiceUIConstants.PermissionScreen.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        titleLabel.textColor = VoiceUIConstants.PermissionScreen.textColor
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
    }
    
    public func setConstraintsForSubtitleLabel(_ subtitleLabel: UILabel, _ titleLabel: UILabel, _ margins: UILayoutGuide) {
        setDefaultSideConstraints(to: subtitleLabel, in: margins)
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        subtitleLabel.text = VoiceUIConstants.PermissionScreen.subtitle
        subtitleLabel.font = UIFont.systemFont(ofSize: 18)
        subtitleLabel.textColor = VoiceUIConstants.PermissionScreen.textColor
        subtitleLabel.lineBreakMode = .byWordWrapping
        subtitleLabel.numberOfLines = 0
    }
    
    public func setConstraintsForCloseView(_ closeView: CloseView, _ margins: UILayoutGuide) {
        closeView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        closeView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        closeView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -30).isActive = true
    }
    
    public func setConstraintsForAllowMicrophoneAccess(_ allowMicrophoneAccessButton: AllowPermissionButton, _ margins: UILayoutGuide) {
        setDefaultSideConstraints(to: allowMicrophoneAccessButton, in: margins)
        allowMicrophoneAccessButton.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 50).isActive = true
        allowMicrophoneAccessButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        allowMicrophoneAccessButton.setTitle(VoiceUIConstants.PermissionScreen.allowMicrophoneAccessText, for: .normal)
        allowMicrophoneAccessButton.setTitleColor(VoiceUIConstants.PermissionScreen.textColor, for: .normal)
    }
    
    public func setConstraintsForRejectMicrophoneAccessButton(_ rejectMicrophoneAccessButton: UIButton, _ allowMicrophoneAccessButton: AllowPermissionButton, _ margins: UILayoutGuide) {
        setDefaultSideConstraints(to: rejectMicrophoneAccessButton, in: margins)
        rejectMicrophoneAccessButton.topAnchor.constraint(equalTo: allowMicrophoneAccessButton.bottomAnchor, constant: 15).isActive = true
        rejectMicrophoneAccessButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        rejectMicrophoneAccessButton.setTitle(VoiceUIConstants.PermissionScreen.rejectMicrophoneAccessText, for: .normal)
        rejectMicrophoneAccessButton.setTitleColor(VoiceUIConstants.PermissionScreen.textColor, for: .normal)
        rejectMicrophoneAccessButton.backgroundColor = .clear
        rejectMicrophoneAccessButton.layer.cornerRadius = 7
        rejectMicrophoneAccessButton.layer.borderWidth = 1
        rejectMicrophoneAccessButton.layer.borderColor = VoiceUIConstants.PermissionScreen.textColor.cgColor
    }
    
    func setDefaultSideConstraints(to firstView: UIView, in layoutGuide: UILayoutGuide) {
        firstView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: VoiceUIConstants.PermissionScreen.sideMarginConstant).isActive = true
        firstView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: VoiceUIConstants.PermissionScreen.sideMarginConstant).isActive = true
    }

