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

/// Controller that takes care of launching a voice overlay and providing handlers to listen to text and error events.
public class VoiceOverlayController {
    
    let permissionViewController = PermissionViewController()
    let noPermissionViewController = NoPermissionViewController()
    let speechController = SpeechController()
    public weak var delegate: VoiceOverlayDelegate?
    var speechTextHandler: SpeechTextHandler?
    var speechErrorHandler: SpeechErrorHandler?
    var speechResultScreenHandler: SpeechResultScreenHandler?
  
    public var settings: VoiceUISettings = VoiceUISettings()
    var recordingViewController: RecordingViewController? = RecordingViewController()
  
    public var datasource: Any? = nil
  
    public init() {}
    
    public func start(on view: UIViewController, textHandler: @escaping SpeechTextHandler, errorHandler: @escaping SpeechErrorHandler, resultScreenHandler: SpeechResultScreenHandler? = nil) {
        self.speechTextHandler = textHandler
        self.speechErrorHandler = errorHandler
        self.speechResultScreenHandler = resultScreenHandler
        
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
    
    fileprivate func checkSpeechAuthorizationStatusAndRedirectToCorrectScreen(_ view: UIViewController) {
        
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
        permissionViewController.constants = settings.layout.permissionScreen
        view.present(permissionViewController, animated: true)
    }
    
    fileprivate func showNoPermissionScreen(_ view: UIViewController) {
        noPermissionViewController.constants = settings.layout.noPermissionScreen
        view.present(noPermissionViewController, animated: true)
    }
    
  fileprivate func showRecordingScreen(_ view: UIViewController) {
        recordingViewController = RecordingViewController()
        guard let recordingViewController = recordingViewController else { return }
        recordingViewController.delegate = delegate
        recordingViewController.speechTextHandler = speechTextHandler
        recordingViewController.speechErrorHandler = speechErrorHandler
        recordingViewController.speechResultScreenHandler = speechResultScreenHandler
        recordingViewController.speechController = SpeechController()
        recordingViewController.constants = settings.layout.recordingScreen
        recordingViewController.settings = settings
    
        recordingViewController.dismissHandler = { [unowned self] (retry) in
          self.recordingViewController = nil
          if retry {
            self.showRecordingScreen(view)
          }
        }

        view.present(recordingViewController, animated: true)
    }
}

public protocol VoiceOverlayDelegate: class {
    func recording(text: String?, final: Bool?, error: Error?)
}
