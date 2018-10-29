//
//  RecordingButton.swift
//  Musicologist
//
//  Created by Robert Mogos on 23/05/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import UIKit
import AVFoundation

@available(iOS 10.0, *)
@IBDesignable
public class RecordingButton: UIButton {
  
  @IBInspectable public var pulseColor: UIColor = UIColor.blue
  @IBInspectable public var pulseDuration: CGFloat = 1.0
  @IBInspectable public var pulseRadius: CGFloat = 10.0
  var player: AVAudioPlayer?
  
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
        
    let after: DispatchTime = .now() + 0.5
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

enum RecordingStatus {
    case startRecording, endRecording, error
}

@available(iOS 10.0, *)
extension RecordingButton {
    func setimage(_ isRecording: Bool) {
        let imageName = isRecording ? "mic-lg-active" : "mic-lg-inactive"
        let recordingImage = UIImage(named: imageName, in: Bundle(for: type(of: self)), compatibleWith: nil)
        setBackgroundImage(recordingImage, for: .normal)
    }
    
    func playSound(with recordingStatus: RecordingStatus){
        var fileName: String = "siri_start"
        
        switch recordingStatus {
        case .startRecording: fileName = "siri_start"
        case .endRecording: fileName = "siri_end"
        case .error : fileName = "siri_error"
        }
        
        guard let url = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
