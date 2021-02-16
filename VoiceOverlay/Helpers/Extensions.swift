//
//  Extensions.swift
//  VoiceOverlay
//
//  Created by Guy Daher on 25/06/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  public func dismissMe(animated: Bool, completion: (()->())? = nil) {
    DispatchQueue.main.async {
      if let navigationStackCount = self.navigationController?.viewControllers.count, navigationStackCount > 1 {
        self.navigationController?.popViewController(animated: animated)
        completion?()
      } else {
        self.dismiss(animated: animated, completion: completion)
      }
    }
  }
}
