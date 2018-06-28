//
//  NoPermissionViewController.swift
//  VoiceOverlay
//
//  Created by Guy Daher on 28/06/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import UIKit

public class NoPermissionViewController: UIViewController {
    
    var dismissHandler: (() -> ())? = nil
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let margins = view.layoutMarginsGuide
        let titleLabel = UILabel()
        let subtitleLabel = UILabel()
        let goToSettingsButton = FirstPermissionButton(startColor: VoiceUIConstants.NoPermissionScreen.startGradientColor, endColor: VoiceUIConstants.NoPermissionScreen.endGradientColor)
        let doneWithSettingsButton = UIButton()
        let closeView = CloseView()
        
        let subViews = [titleLabel, subtitleLabel, goToSettingsButton, doneWithSettingsButton, closeView]
        
        ViewHelpers.translatesAutoresizingMaskIntoConstraintsFalse(for: subViews)
        ViewHelpers.addSubviews(for: subViews, in: view)
        
        view.backgroundColor = VoiceUIConstants.NoPermissionScreen.backgroundColor
        ViewHelpers.setConstraintsForTitleLabel(titleLabel, margins, VoiceUIConstants.NoPermissionScreen.title)
        ViewHelpers.setConstraintsForSubtitleLabel(subtitleLabel, titleLabel, margins, VoiceUIConstants.NoPermissionScreen.subtitle)
        ViewHelpers.setConstraintsForCloseView(closeView, margins)
        ViewHelpers.setConstraintsForFirstButton(goToSettingsButton, margins, VoiceUIConstants.NoPermissionScreen.goToSettingsText)
        ViewHelpers.setConstraintsForSecondButton(doneWithSettingsButton, goToSettingsButton, margins, VoiceUIConstants.NoPermissionScreen.doneText)
        
        goToSettingsButton.addTarget(self, action: #selector(goToSettingsTapped), for: .touchUpInside)
        doneWithSettingsButton.addTarget(self, action: #selector(doneWithSettingsTapped), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.closeButtonTapped(_:)))
        closeView.addGestureRecognizer(tap)
    }
    
    @objc func goToSettingsTapped() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)") // Prints true
            })
        }
    }
    
    @objc func doneWithSettingsTapped() {
        dismissMe(animated: true) {
            self.dismissHandler?()
        }
    }
    
    @objc func closeButtonTapped(_ sender: UITapGestureRecognizer) {
        dismissMe(animated: true)
    }
    
}
