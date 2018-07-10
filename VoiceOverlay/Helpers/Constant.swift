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

public class VoiceUISettings {
  
  public var autoStart = false
  public var autoStop = true
  public var autoStopTimeout: TimeInterval = 2
  public var layout: Layout = Layout()
  
  public class Layout {
    
    public var permissionScreen = PermissionScreenConstants()
    public var noPermissionScreen = NoPermissionScreenConstants()
    public var recordingScreen = RecordingScreenConstants()
  }
}

public class PermissionScreenConstants {
  public var title = "You can use voice search to find products"
  public var subtitle = "May we access your device's microphone to enable voice search?"
  public var allowMicrophoneAccessText = "Allow microphone access"
  public var rejectMicrophoneAccessText = "No"
  
  public var textColor: UIColor = .white
  public var backgroundColor: UIColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
  public var startGradientColor = UIColor(red: 73/255, green: 171/255, blue: 248/255, alpha: 1)
  public var endGradientColor = UIColor(red: 67/255, green: 102/255, blue: 222/255, alpha: 1)
  
}

public class NoPermissionScreenConstants {
  public var title = "You don't have the right permissions"
  public var subtitle = "In order to enable voice search, you need to enable it in your setting's app."
  public var goToSettingsText = "Go to settings"
  public var doneText = "Done"
  
  public var textColor: UIColor = .white
  public var backgroundColor: UIColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
  public var startGradientColor = UIColor(red: 27/255, green: 70/255, blue: 151/255, alpha: 1)
  public var endGradientColor = UIColor(red: 70/255, green: 160/255, blue: 190/255, alpha: 1)
  
}

public class RecordingScreenConstants {
  public var titleInitial = "Press the button to start"
  public var titleListening = "Listening..."
  public var subtitleInitial = "Say something like \"iphone case\""
  public var titleInProgress = "Searching for:"
  public var titleError = "Sorry, we didn't quite get that"
  public var subtitleError = "Try repeating your request."
  public var tryAgainText = "Try Again"
  public var recordingButtonConstants = RecordingButtonConstants()
  
  
  public var textColor: UIColor = .white
  public var backgroundColor: UIColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
}

public class RecordingButtonConstants {
  public var pulseColor = UIColor(red: 51/255, green: 74/255, blue: 97/255, alpha: 1)
  public var pulseDuration: CGFloat = 4
  public var pulseRadius: CGFloat = 100
}

struct VoiceUIInternalConstants {
    public static var sideMarginConstant: CGFloat = 5
}
