//
//  Recordable.swift
//  InstantSearchVoiceOverlay
//
//  Created by Robert Mogos on 17/10/2018.
//

import Foundation

/// Protocol that allows to inject any STT into the voice overlay
public protocol Recordable {
  
  // Starting the recording and processing the STT
  func startRecording(textHandler: @escaping SpeechTextHandler, errorHandler: @escaping SpeechErrorHandler)
  
  // Stop the recording
  func stopRecording()
  
  // Get the state of the recording
  func isRecording() -> Bool
  
  // Request system authorisation for STT and Voice capabilies
  func requestAuthorization(_ statusHandler: @escaping (Bool) -> Void)
}


