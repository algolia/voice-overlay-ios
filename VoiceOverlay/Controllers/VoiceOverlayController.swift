//
//  VoiceOverlayController.swift
//  VoiceOverlay
//
//  Created by Guy Daher on 25/06/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import Foundation
import UIKit
import Speech

public class VoiceOverlayController {
    
    let permissionViewController = PermissionViewController()
    let speechController = SpeechController()
    public weak var delegate: VoiceOverlayDelegate?
    
    public init() {}
    
    // TODO: Define datasource that will be used to give back the text from the SpeechController
    public var datasource: Any? = nil
    
    fileprivate func redirect(_ view: UIViewController) {
        // TODO: Custom logic to check whether to do the PermissionController or directly the speech controller.
        
        let authorizationStatus = SFSpeechRecognizer.authorizationStatus()
        switch authorizationStatus {
        case .authorized:
            let recordingViewController = RecordingViewController()
            recordingViewController.delegate = delegate
            recordingViewController.speechController = self.speechController
            view.present(recordingViewController, animated: true)
        case .denied, .restricted:
            print("Launch the error ViewController")
        case .notDetermined:
            permissionViewController.speechController = speechController
            view.present(permissionViewController, animated: true)
        }
    }
    
    public func start(on view: UIViewController) {
        redirect(view)
        
        permissionViewController.dismissHandler = {
            self.redirect(view)
        }
        
    }
}

public protocol VoiceOverlayDelegate: class {
    func recording(text: String?, final: Bool?, error: Error?)
}
