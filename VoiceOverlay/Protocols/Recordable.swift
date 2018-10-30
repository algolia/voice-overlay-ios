//
//  Recordable.swift
//  InstantSearchVoiceOverlay
//
//  Created by Robert Mogos on 17/10/2018.
//

import Foundation

public protocol Recordable {
  func startRecording(textHandler: @escaping SpeechTextHandler, errorHandler: @escaping SpeechErrorHandler)
  
  func stopRecording()
  
  func isRecording() -> Bool
  
  func requestAuthorization(_ statusHandler: @escaping (Bool) -> Void)
}


