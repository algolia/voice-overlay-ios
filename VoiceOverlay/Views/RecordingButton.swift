//
//  RecordingButton.swift
//  Musicologist
//
//  Created by Robert Mogos on 23/05/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import UIKit

@IBDesignable
class RecordingButton: UIButton {
  
  @IBInspectable public var pulseColor: UIColor = UIColor.blue
  @IBInspectable public var pulseDuration: CGFloat = 1.0
  @IBInspectable public var pulseRadius: CGFloat = 10.0
  
  private lazy var mainLayer: CAShapeLayer = { [unowned self] in
    let layer = CAShapeLayer()
    layer.backgroundColor = pulseColor.cgColor;
    layer.bounds = self.bounds;
    layer.cornerRadius = self.bounds.width / 2;
    layer.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2);
    layer.zPosition = -1;
    return layer
    }()
  
  private lazy var animationGroup: CAAnimationGroup = {
    let animationGroup = CAAnimationGroup()
    animationGroup.animations = [createScaleAnimation(), createOpacityAnimation()]
    animationGroup.duration = CFTimeInterval(self.pulseDuration)
    return animationGroup
  }()
  
  private var isAnimating = false
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.layer.addSublayer(mainLayer)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.layer.addSublayer(mainLayer)
  }
  
  public func animate(_ animate: Bool) {
    isAnimating = animate
    handleAnimations()
  }
  
  private func handleAnimations() {
    if !isAnimating {
      return
    }
    
    let animation = createAnimation()
    self.layer.insertSublayer(animation, below: mainLayer)
    animation.add(animationGroup, forKey: "pulse")
        
    let after: DispatchTime = .now() + 0.5 //TODO: customise this shit
    DispatchQueue.main.asyncAfter(deadline: after) { [weak self] in
      self?.handleAnimations()
    }
  }
  
  private func createAnimation() -> CAShapeLayer {
    let layer = CAShapeLayer()
    layer.backgroundColor = pulseColor.cgColor;
    layer.bounds = self.bounds;
    layer.cornerRadius = self.bounds.width / 2;
    layer.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2);
    
    layer.contentsScale = UIScreen.main.scale
    layer.zPosition = -2;
    layer.opacity = 0
    return layer
  }
  
  private func createScaleAnimation() -> CABasicAnimation {
    let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
    scaleAnimation.fromValue = 1
    scaleAnimation.toValue = pulseRadius + 1
    scaleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    return scaleAnimation
  }
  
  private func createOpacityAnimation() -> CAKeyframeAnimation {
    let animation = CAKeyframeAnimation(keyPath: "opacity")
    animation.values = [0.8, 0.4, 0]
    animation.keyTimes = [0.0, 0.5, 1.0]
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    return animation
  }
}
