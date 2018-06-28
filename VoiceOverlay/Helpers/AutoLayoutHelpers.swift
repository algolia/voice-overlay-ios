//
//  AutoLayoutHelpers.swift
//  VoiceUI
//
//  Created by Guy Daher on 25/06/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import Foundation
import UIKit

class ViewHelpers {
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
        closeView.backgroundColor = VoiceUIConstants.PermissionScreen.backgroundColor
    }

    static func setConstraintsForFirstButton(_ firstButton: FirstPermissionButton, _ margins: UILayoutGuide, _ text: String) {
        setDefaultSideConstraints(to: firstButton, in: margins)
        firstButton.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 50).isActive = true
        firstButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        firstButton.setTitle(text, for: .normal)
        firstButton.setTitleColor(VoiceUIConstants.PermissionScreen.textColor, for: .normal)
    }

    static func setConstraintsForSecondButton(_ secondButton: UIButton, _ firstButton: FirstPermissionButton, _ margins: UILayoutGuide, _ text: String) {
        setDefaultSideConstraints(to: secondButton, in: margins)
        secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 15).isActive = true
        secondButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        secondButton.setTitle(text, for: .normal)
        secondButton.setTitleColor(VoiceUIConstants.PermissionScreen.textColor, for: .normal)
        secondButton.backgroundColor = .clear
        secondButton.layer.cornerRadius = 7
        secondButton.layer.borderWidth = 1
        secondButton.layer.borderColor = VoiceUIConstants.PermissionScreen.textColor.cgColor
    }
    
    static func setConstraintsForRecordingButton(_ recordingButton: RecordingButton, _ margins: UILayoutGuide) {
        recordingButton.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 50).isActive = true
        recordingButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        recordingButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        recordingButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        let bundle = Bundle(for: self)
        let recordingImage = UIImage(named: "mic-lg-inactive", in: bundle, compatibleWith: nil)
        recordingButton.setBackgroundImage(recordingImage, for: .normal)
        
        recordingButton.pulseColor = VoiceUIConstants.RecordingScreen.RecordingButton.pulseColor
        recordingButton.pulseDuration = VoiceUIConstants.RecordingScreen.RecordingButton.pulseDuration
        recordingButton.pulseRadius = VoiceUIConstants.RecordingScreen.RecordingButton.pulseDuration
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
    
    static func translatesAutoresizingMaskIntoConstraintsFalse(for views: [UIView]) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    static func addSubviews(for subViews: [UIView], in view: UIView) {
        subViews.forEach {
            view.addSubview($0)
        }
    }
}
