//
//  VoiceOverlayController.swift
//  VoiceOverlay
//
//  Created by Guy Daher on 25/06/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import Foundation
import UIKit

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
  public var permissionControllers: [PermissionController]
  
  public var settings: VoiceUISettings = VoiceUISettings()
  var inputViewController: InputViewController? = InputViewController()
    
  public var datasource: Any? = nil
  
  public override convenience init() {
    self.init(speechControllerHandler: { SpeechController() },
              permissionControllers: [MicrophonePermissionController.shared, SpeechRecognitionPermissionController.shared])
  }
  
  public init(speechControllerHandler: @escaping RecordableHandler,
              permissionControllers: [PermissionController] = []) {
    self.recordableHandler = speechControllerHandler
    self.permissionControllers = permissionControllers
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
      self?.checkPermissionsAndRedirectToCorrectScreen(view)
    }
  }

  @objc public func dismiss() {
    self.inputViewController?.dismiss(animated: true, completion: nil)
  }

  fileprivate func checkPermissionsAndRedirectToCorrectScreen(_ view: UIViewController) {

    let permissionStatuses = permissionControllers.map(\.status)
        
    if permissionStatuses.allSatisfy({ $0 == .granted }) {
      showRecordingScreen(view)
    } else if permissionStatuses.contains(.denied) {
      showNoPermissionScreen(view)
    } else {
      showPermissionScreen(view)
    }
    
  }

  fileprivate func showPermissionScreen(_ view: UIViewController) {
    permissionViewController.permissionControllers = permissionControllers.filter { $0.status == .undetermined }
    permissionViewController.constants = settings.layout.permissionScreen
    DispatchQueue.main.async {
      view.present(self.permissionViewController, animated: true)
    }
  }

  fileprivate func showNoPermissionScreen(_ view: UIViewController) {
    noPermissionViewController.constants = settings.layout.noPermissionScreen
    DispatchQueue.main.async {
      view.present(self.noPermissionViewController, animated: true)
    }
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
    DispatchQueue.main.async {
      view.present(inputViewController, animated: true)
    }
  }
}

public protocol VoiceOverlayDelegate: class {
  func recording(text: String?, final: Bool?, error: Error?)
}
