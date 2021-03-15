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

/// Customisation Settings for the Voice Overlay
public class VoiceUISettings {
  
  /// Specifies whether the overlay directly starts recording (true), or if it requires the user to click the mic (false). Defaults to true.
  public var autoStart = true
  
  /// Specifies whether the overlay stops recording after the user stops talking for `autoStopTimeout` seconds (true), or if it requires the user to click the mic (false). Defaults to true.
  public var autoStop = true
  
  /// When autoStop is set to true, autoStopTimeout determines the amount of silence time of the user that causes the recording to stop. Defaults to 2 seconds.
  public var autoStopTimeout: TimeInterval = 2
  
  /// Whether or not to show a result screen after the recording is finished.
  public var showResultScreen = false
  
  /// Timeout for showing the result screen in case no resultScreenText is provided on time.
  public var showResultScreenTimeout: TimeInterval = 2
  
  /// Time for showing the result screen with the provided resultScreenText.
  public var showResultScreenTime: TimeInterval = 4
  
  /// The processed result screen text that should be appear in the result screen.
  public var resultScreenText: NSAttributedString? {
    didSet {
      if let resultScreenText = resultScreenText {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "resultScreenTextNotification"), object: nil, userInfo: ["resultScreenText": resultScreenText])
      }
    }
  }
  
  /// The layout and style of all screens of the voice overlay.
  public var layout: Layout = Layout()
  
  public class Layout {
    /// Determine the properties associated with the screen asking for permissions for the user.
    public var permissionScreen = PermissionScreenConstants()
    
    /// Determine the properties associated with the screen stating that permissions are missing for enabling voice.
    public var noPermissionScreen = NoPermissionScreenConstants()
    
    /// Determine the properties associated with the screen that records the user's voice input.
    public var inputScreen = InputScreenConstants()
    
    /// Determine the properties associated with the result screen that shows after taking the user's voice input.
    public var resultScreen = ResultScreenConstants()
  }
}

public class PermissionScreenConstants {
  
  /// Title shown at the very top of the screen.
  public var title = "You can use voice search to find products"
  
  /// Subtitle shown at the top of the screen
  public var subtitle = "May we access your device's microphone to enable voice search?"
  
  /// Text on the button to allow microphone access
  public var allowText = "Allow microphone access"
  
  /// Text on the button to reject microphone access
  public var rejectText = "No"
  
  /// Text color of all labels in screen
  public var textColor: UIColor = .white
  
  /// Background color of the view
  public var backgroundColor: UIColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.95)
  
  /// Start gradient color for the permission button
  public var startGradientColor = UIColor(red: 73/255, green: 171/255, blue: 248/255, alpha: 1)
  
  /// End gradient color for the permission button
  public var endGradientColor = UIColor(red: 67/255, green: 102/255, blue: 222/255, alpha: 1)
  
}

public class NoPermissionScreenConstants {
  /// Title shown at the very top of the screen.
  public var title = "You don't have the right permissions"
  
  /// Subtitle shown at the top of the screen
  public var subtitle = "In order to enable voice search, you need to enable it in your setting's app."
  
  /// Text on the button to give permission
  public var permissionEnableText = "Give Permissions"
  
  /// Text on the button to dismiss view when done giving permissions
  public var doneText = "Done"
  
  /// Text color of all labels in screen
  public var textColor: UIColor = .white
  
  /// Background color of the view
  public var backgroundColor: UIColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.95)
  
  /// Start gradient color for the permission button
  public var startGradientColor = UIColor(red: 27/255, green: 70/255, blue: 151/255, alpha: 1)
  
  /// End gradient color for the permission button
  public var endGradientColor = UIColor(red: 70/255, green: 160/255, blue: 190/255, alpha: 1)
  
}

public class InputScreenConstants {
  /// Title shown at the very top of the screen before the recording button is activated.
  public var titleInitial = "Press the button to start"
  
  /// Title shown at the very top of the screen when the recording button is activated and no voice inputs received.
  public var titleListening = "Listening..."
  
  /// Subtitle shown at the top of the screen before the recording button is activated.
  public var subtitleInitial = "Say something like:"
  
  /// The bullet point shown for each item in the list of suggestions
  public var subtitleBullet = "\u{2022}"
  
  /// The list of query suggestions shown in a bullet list
  public var subtitleBulletList = ["\"iphone case\"", "\"Running shoes\""]
  
  /// Title shown at the very top of the screen when the recording button is activated and voice inputs have been received.
  public var titleInProgress = "Searching for:"
  
  /// Title shown at the very top of the screen when the recording button is activated and an error occured
  public var titleError = "Sorry, we didn't quite get that"
  
  /// Subtitle shown at the top of the screen when the recording button is activated and an error occured
  public var subtitleError = "Try repeating your request."
  
  /// Text shown at the bottom of the screen when an error occured and prompting the user to try again.
  public var errorHint = "Try Again"
  
  /// Layout of the input button that records the user's voice input
  public var inputButtonConstants = InputButtonConstants()
  
  /// Text color of all labels in screen
  public var textColor: UIColor = .white
  
  /// Background color of the view
  public var backgroundColor: UIColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.95)
}

public class ResultScreenConstants {
  /// Title shown at the very top of the screen when processing input results
  public var title = "Processing Resuts..."
  
  /// Title shown at the very top of the screen when input has been processed
  public var titleProcessed: String = "Searching for:" {
    didSet {
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "titleProcessedNotification"), object: nil, userInfo: ["titleProcessed": titleProcessed])
    }
  }
  
  /// Subtitle shown at the top of the screen when input has been processed
  public var subtitle = "Please wait a few seconds while we process your input"
  
  /// Text shown at the bottom of the screen prompting the user to start again
  public var startAgainText = "Start Again"
  
  /// Text color of all labels in screen
  public var textColor: UIColor = .white
  
  /// Background color of the view
  public var backgroundColor: UIColor = UIColor(red: 51/255, green: 74/255, blue: 97/255, alpha: 1)
}

public class InputButtonConstants {
  
  /// Color of the pulse
  public var pulseColor = UIColor(red: 51/255, green: 74/255, blue: 97/255, alpha: 1)
  
  /// Duration of the pulse
  public var pulseDuration: CGFloat = 4
  
  /// Radius of the pulse
  public var pulseRadius: CGFloat = 100
}

struct VoiceUIInternalConstants {
    public static var sideMarginConstant: CGFloat = 5
}
