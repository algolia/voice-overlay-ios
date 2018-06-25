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

struct VoiceUIConstants {
    struct PermissionScreen {
        static let title = "You can use voice search to find products"
        static let subtitle = "May we access your device's microphone to enable voice search?"
        static let allowMicrophoneAccessText = "Allow microphone access"
        static let rejectMicrophoneAccessText = "No"
        
        static let sideMarginConstant: CGFloat = 5
        static let textColor: UIColor = .white
        static let backgroundColor: UIColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        static let startGradientColor = UIColor(red: 73/255, green: 171/255, blue: 248/255, alpha: 1)
        static let endGradientColor = UIColor(red: 67/255, green: 102/255, blue: 222/255, alpha: 1)
        
    }
}
