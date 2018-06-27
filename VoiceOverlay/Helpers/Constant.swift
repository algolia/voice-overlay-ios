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
        public static let title = "You can use voice search to find products"
        public static let subtitle = "May we access your device's microphone to enable voice search?"
        public static let allowMicrophoneAccessText = "Allow microphone access"
        public static let rejectMicrophoneAccessText = "No"
        
        public static let sideMarginConstant: CGFloat = 5
        public static let textColor: UIColor = .white
        public static let backgroundColor: UIColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        public static let startGradientColor = UIColor(red: 73/255, green: 171/255, blue: 248/255, alpha: 1)
        public static let endGradientColor = UIColor(red: 67/255, green: 102/255, blue: 222/255, alpha: 1)
        
    }
    
    public struct RecordingScreen {
        public static let titleInitial = "Listening..."
        public static let subtitleInitial = "Say something like \"iphone case\""
        public static let titleInProgress = "Searching for:"
        public static let titleError = "Sorry, we didn't quite get that"
        public static let subtitleError = "Try repeating your request."
        public static let tryAgainText = "Try Again"
        
        public struct RecordingButton {
            public static let pulseColor = UIColor(red: 51/255, green: 74/255, blue: 97/255, alpha: 1)
            public static let pulseDuration: CGFloat = 4
            public static let pulseRadius: CGFloat = 100
        }
    }
}
