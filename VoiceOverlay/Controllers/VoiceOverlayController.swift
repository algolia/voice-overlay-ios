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

public typealias RecordableHandler = () -> Recordable

/// Controller that takes care of launching a voice overlay and providing handlers to listen to text and error events.
@available(iOS 10.0, *)
@objc public class VoiceOverlayController: NSObject {
    
    let permissionViewController = PermissionViewController()
    let noPermissionViewController = NoPermissionViewController()
    let recordableHandler: RecordableHandler
    public weak var delegate: VoiceOverlayDelegate?
    var speechTextHandler: SpeechTextHandler?
    var speechErrorHandler: SpeechErrorHandler?
    var speechResultScreenHandler: SpeechResultScreenHandler?
  
    public var settings: VoiceUISettings = VoiceUISettings()
    var inputViewController: InputViewController? = InputViewController()
  
    public var datasource: Any? = nil
  
    public override init() {
      self.recordableHandler = {
        return SpeechController()
      }
      super.init()
    }
  
    public init(speechControllerHandler: @escaping RecordableHandler) {
      self.recordableHandler = speechControllerHandler
      super.init()
    }
    
    @objc public func start(on view: UIViewController, textHandler: @escaping SpeechTextHandler, errorHandler: @escaping SpeechErrorHandler, resultScreenHandler: SpeechResultScreenHandler? = nil) {
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

    @objc public func dismiss() {
      self.inputViewController?.dismiss(animated: true, completion: nil)
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
        @unknown default:
          break
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
        @unknown default:
          break
        }
    }
    
    fileprivate func showPermissionScreen(_ view: UIViewController) {
        permissionViewController.speechController = recordableHandler()
        permissionViewController.constants = settings.layout.permissionScreen
        view.present(permissionViewController, animated: true)
    }
    
    fileprivate func showNoPermissionScreen(_ view: UIViewController) {
        noPermissionViewController.constants = settings.layout.noPermissionScreen
        view.present(noPermissionViewController, animated: true)
    }
    
  fileprivate func showRecordingScreen(_ view: UIViewController) {
        inputViewController = InputViewController()
        guard let inputViewController = inputViewController else { return }
        inputViewController.delegate = delegate
        inputViewController.speechTextHandler = speechTextHandler
        inputViewController.speechErrorHandler = speechErrorHandler
        inputViewController.speechResultScreenHandler = speechResultScreenHandler
        inputViewController.speechController = recordableHandler()
        inputViewController.constants = settings.layout.inputScreen
        inputViewController.settings = settings
    
        inputViewController.dismissHandler = { [weak self] (retry) in
          self?.inputViewController = nil
          if retry {
            self?.showRecordingScreen(view)
          }
        }

    
        inputViewController.modalPresentationStyle = .overCurrentContext
        view.present(inputViewController, animated: true)
    }
}

public protocol VoiceOverlayDelegate: class {
    func recording(text: String?, final: Bool?, error: Error?)
}
