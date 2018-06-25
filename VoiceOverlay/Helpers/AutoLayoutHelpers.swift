//
//  AutoLayoutHelpers.swift
//  VoiceUI
//
//  Created by Guy Daher on 25/06/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import Foundation
import UIKit

class AutoLayoutHelpers {
    static func setConstraintsForTitleLabel(_ titleLabel: UILabel, _ margins: UILayoutGuide, _ text: String) {
            setDefaultSideConstraints(to: titleLabel, in: margins)
            titleLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 100).isActive = true
            titleLabel.text = text
            titleLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
            titleLabel.textColor = VoiceUIConstants.PermissionScreen.textColor
            titleLabel.lineBreakMode = .byWordWrapping
            titleLabel.numberOfLines = 0
        }
    
    static func setConstraintsForSubtitleLabel(_ subtitleLabel: UILabel, _ titleLabel: UILabel, _ margins: UILayoutGuide, _ text: String) {
        setDefaultSideConstraints(to: subtitleLabel, in: margins)
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        subtitleLabel.text = text
        subtitleLabel.font = UIFont.systemFont(ofSize: 18)
        subtitleLabel.textColor = VoiceUIConstants.PermissionScreen.textColor
        subtitleLabel.lineBreakMode = .byWordWrapping
        subtitleLabel.numberOfLines = 0
    }

    static func setConstraintsForCloseView(_ closeView: CloseView, _ margins: UILayoutGuide) {
        closeView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        closeView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        closeView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -30).isActive = true
    }

    static func setConstraintsForAllowMicrophoneAccess(_ allowMicrophoneAccessButton: AllowPermissionButton, _ margins: UILayoutGuide) {
        setDefaultSideConstraints(to: allowMicrophoneAccessButton, in: margins)
        allowMicrophoneAccessButton.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 50).isActive = true
        allowMicrophoneAccessButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        allowMicrophoneAccessButton.setTitle(VoiceUIConstants.PermissionScreen.allowMicrophoneAccessText, for: .normal)
        allowMicrophoneAccessButton.setTitleColor(VoiceUIConstants.PermissionScreen.textColor, for: .normal)
    }

    static func setConstraintsForRejectMicrophoneAccessButton(_ rejectMicrophoneAccessButton: UIButton, _ allowMicrophoneAccessButton: AllowPermissionButton, _ margins: UILayoutGuide) {
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
    
    static func setConstraintsForRecordingButton(_ recordingButton: RecordingButton, _ margins: UILayoutGuide) {
        recordingButton.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 50).isActive = true
        recordingButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        recordingButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        recordingButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        let bundle = Bundle(for: self)
        let recordingImage = UIImage(named: "mic-lg-active", in: bundle, compatibleWith: nil)
        recordingButton.setBackgroundImage(recordingImage, for: .normal)
    }

    static func setConstraintsForTryAgainLabel(_ tryAgainLabel: UILabel, _ recordButton: UIView, _ margins: UILayoutGuide, _ text: String) {
        tryAgainLabel.topAnchor.constraint(equalTo: recordButton.bottomAnchor, constant: 15).isActive = true
        tryAgainLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        tryAgainLabel.text = text
        tryAgainLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        tryAgainLabel.textColor = VoiceUIConstants.PermissionScreen.textColor
        tryAgainLabel.textAlignment = .center
    }
    
    
    static func setDefaultSideConstraints(to firstView: UIView, in layoutGuide: UILayoutGuide) {
        firstView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: VoiceUIConstants.PermissionScreen.sideMarginConstant).isActive = true
        firstView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: VoiceUIConstants.PermissionScreen.sideMarginConstant).isActive = true
    }
}
