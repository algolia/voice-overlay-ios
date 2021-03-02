//
//  MicrophonePermissionController.swift
//  
//
//  Created by Vladislav Fitc on 25/02/2021.
//

import Foundation
import AVFoundation

public struct MicrophonePermissionController: PermissionController {
  
  private init() {}
  
  static let shared = Self()
  
  public var status: PermissionStatus {
    switch AVAudioSession.sharedInstance().recordPermission {
    case .granted:
      return .granted
    case .denied:
      return .denied
    case .undetermined:
      fallthrough
    @unknown default:
      return .undetermined
    }
  }
  
  public func requestPermission(completion: @escaping (PermissionStatus) -> Void) {
    AVAudioSession.sharedInstance().requestRecordPermission { isGranted in
      completion(isGranted ? .granted : .denied)
    }
  }
  
}
