//
//  PermissionController.swift
//  
//
//  Created by Vladislav Fitc on 24/02/2021.
//

import Foundation

public protocol PermissionController {
  
  var status: PermissionStatus { get }
  
  func requestPermission(completion: @escaping (PermissionStatus) -> Void)
  
}

public enum PermissionStatus {
  case granted
  case denied
  case undetermined
}
