//
//  Constant.swift
//  VoiceUI
//
//  Created by Guy Daher on 21/06/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

public struct VoiceUIConstants {
    public struct PermissionScreen {
        public static var title = "You can use voice search to find products"
        public static var subtitle = "May we access your device's microphone to enable voice search?"
        public static var allowMicrophoneAccessText = "Allow microphone access"
        public static var rejectMicrophoneAccessText = "No"
        
        public static var sideMarginConstant: CGFloat = 5
        public static var textColor: UIColor = .white
        public static var backgroundColor: UIColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        public static var startGradientColor = UIColor(red: 73/255, green: 171/255, blue: 248/255, alpha: 1)
        public static var endGradientColor = UIColor(red: 67/255, green: 102/255, blue: 222/255, alpha: 1)
        
    }
    
    public struct NoPermissionScreen {
        public static var title = "You don't have the right permissions"
        public static var subtitle = "In order to enable voice search, you need to enable it in your setting's app."
        public static var goToSettingsText = "Go to settings"
        public static var doneText = "Done"
        
        public static var sideMarginConstant: CGFloat = 5
        public static var textColor: UIColor = .white
        public static var backgroundColor: UIColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        public static var startGradientColor = UIColor(red: 27/255, green: 70/255, blue: 151/255, alpha: 1)
        public static var endGradientColor = UIColor(red: 70/255, green: 160/255, blue: 190/255, alpha: 1)
        
    }
    
    public struct RecordingScreen {
        public static var titleInitial = "Press the button to start"
        public static var titleListening = "Listening..."
        public static var subtitleInitial = "Say something like \"iphone case\""
        public static var titleInProgress = "Searching for:"
        public static var titleError = "Sorry, we didn't quite get that"
        public static var subtitleError = "Try repeating your request."
        public static var tryAgainText = "Try Again"
        public static var instantStart = false
        public static var instantStop = true
        public static var instantStopTimeout: TimeInterval = 2
        
        public struct RecordingButton {
            public static var pulseColor = UIColor(red: 51/255, green: 74/255, blue: 97/255, alpha: 1)
            public static var pulseDuration: CGFloat = 4
            public static var pulseRadius: CGFloat = 100
        }
    }
}
