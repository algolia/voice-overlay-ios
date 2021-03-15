//
//  SpeechRecognitionPermissionController.swift
//  
//
//  Created by Vladislav Fitc on 25/02/2021.
//

import Foundation
import Speech

@available(iOS 10.0, *)
struct SpeechRecognitionPermissionController: PermissionController {
  
  private init() {}
  
  static let shared = Self()
  
  public var status: PermissionStatus {
    return mapStatus(SFSpeechRecognizer.authorizationStatus())
  }
  
  public func requestPermission(completion: @escaping (PermissionStatus) -> Void) {
    SFSpeechRecognizer.requestAuthorization { status in
      completion(mapStatus(status))
    }
  }
  
  private func mapStatus(_ status: SFSpeechRecognizerAuthorizationStatus) -> PermissionStatus {
    switch status {
    case .authorized:
      return .granted
    case .denied, .restricted:
      return .denied
    case .notDetermined:
      return .undetermined
    @unknown default:
      return .undetermined
    }
  }

}
