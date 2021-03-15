//
//  Gradient.swift
//  VoiceUI
//
//  Created by Guy Daher on 21/06/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

// we have to have this class or else when using autolayout, the gradient won't redraw itself.
@available(iOS 10.0, *)
public class FirstPermissionButton: UIButton {
    
    var startColor: UIColor = .white
    var endColor: UIColor = .white
    
    init(startColor: UIColor, endColor: UIColor) {
        self.startColor = startColor
        self.endColor = endColor
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private let gradient : CAGradientLayer = CAGradientLayer()
    
    override public func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        self.gradient.frame = self.bounds
    }
    
    override public func draw(_ rect: CGRect) {
        self.gradient.frame = self.bounds
        self.gradient.colors = [startColor.cgColor, endColor.cgColor]
        self.gradient.startPoint = CGPoint.init(x: 0, y: 1)
        self.gradient.endPoint = CGPoint.init(x: 1, y: 1)
        self.gradient.cornerRadius = 7
        if self.gradient.superlayer == nil {
            self.layer.insertSublayer(self.gradient, at: 0)
        }
    }
}
