//
//  VoiceOverlayController.swift
//  VoiceOverlay
//
//  Created by Guy Daher on 25/06/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import Foundation
import UIKit

public class VoiceOverlayController {
    
    let permissionViewController = PermissionViewController()
    
    public init() {}
    
    // TODO: Define datasource that will be used to give back the text from the SpeechController
    var datasource: Any? = nil
    
    public func start(on view: UIViewController) {
        // TODO: Custom logic to check whether to do the PermissionController or directly the speech controller.
        
        permissionViewController.dismissHandler = {
            let listeningViewController = RecordingViewController()
            view.present(listeningViewController, animated: false)
        }
        
        view.present(permissionViewController, animated: false)
    }
}
