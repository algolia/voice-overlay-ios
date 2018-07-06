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
    let noPermissionViewController = NoPermissionViewController()
    let speechController = SpeechController()
    public weak var delegate: VoiceOverlayDelegate?
    var speechTextHandler: SpeechTextHandler?
    var speechErrorHandler: SpeechErrorHandler?
    
    public init() {}
    
    // TODO: Define datasource that will be used to give back the text from the SpeechController
    public var datasource: Any? = nil
    
    public func start(on view: UIViewController, textHandler: @escaping SpeechTextHandler, errorHandler: @escaping SpeechErrorHandler) {
        self.speechTextHandler = textHandler
        self.speechErrorHandler = errorHandler
        
        checkPermissionsAndRedirectToCorrectScreen(view)
        
        permissionViewController.dismissHandler = { [weak self] in
            self?.checkPermissionsAndRedirectToCorrectScreen(view)
        }
        
        noPermissionViewController.dismissHandler = { [weak self] in
            if SFSpeechRecognizer.authorizationStatus() == .authorized {
                self?.checkPermissionsAndRedirectToCorrectScreen(view)
            }
        }
    }
    
    fileprivate func checkPermissionsAndRedirectToCorrectScreen(_ view: UIViewController) {
        
        // Audio/Record permissions
        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSession.RecordPermission.granted:
            // If audio/record permission is granted, we need to check for the speech permission next
            checkSpeechAuthorizationStatusAndRedirectToCorrectScreen(view)
        case AVAudioSession.RecordPermission.denied:
            showNoPermissionScreen(view)
        case AVAudioSession.RecordPermission.undetermined:
            showPermissionScreen(view)
        }
    }
    
    func checkSpeechAuthorizationStatusAndRedirectToCorrectScreen(_ view: UIViewController) {
        
        // speech permissions
        switch SFSpeechRecognizer.authorizationStatus() {
        case .authorized:
            showRecordingScreen(view)
        case .denied, .restricted:
            showNoPermissionScreen(view)
        case .notDetermined:
            showPermissionScreen(view)
        }
    }
    
    fileprivate func showPermissionScreen(_ view: UIViewController) {
        permissionViewController.speechController = speechController
        view.present(permissionViewController, animated: true)
    }
    
    fileprivate func showNoPermissionScreen(_ view: UIViewController) {
        view.present(noPermissionViewController, animated: true)
    }
    
  fileprivate func showRecordingScreen(_ view: UIViewController) {
        let recordingViewController = RecordingViewController()
        recordingViewController.delegate = delegate
        recordingViewController.speechTextHandler = speechTextHandler
        recordingViewController.speechErrorHandler = speechErrorHandler
        recordingViewController.speechController = self.speechController //SpeechController()
        view.present(recordingViewController, animated: true)
    }
}

public protocol VoiceOverlayDelegate: class {
    func recording(text: String?, final: Bool?, error: Error?)
}
