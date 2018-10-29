//
//  CloseView.swift
//  VoiceUI
//
//  Created by Guy Daher on 21/06/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 10.0, *)
public class CloseView: UIView
{
    override public func draw(_ rect: CGRect)
    {
        drawRingFittingInsideView()
    }
    
    internal func drawRingFittingInsideView()->()
    {
        // The circle
        let halfSize:CGFloat = min( bounds.size.width/2, bounds.size.height/2)
        let desiredLineWidth:CGFloat = 2
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x:halfSize,y:halfSize),
            radius: CGFloat( halfSize - (desiredLineWidth/2) ),
            startAngle: CGFloat(0),
            endAngle:CGFloat(Double.pi * 2),
            clockwise: true)
        
        let circleShapeLayer = CAShapeLayer()
        circleShapeLayer.path = circlePath.cgPath
        
        circleShapeLayer.fillColor = UIColor.clear.cgColor
        circleShapeLayer.strokeColor = UIColor.white.cgColor
        circleShapeLayer.lineWidth = desiredLineWidth
        
        layer.addSublayer(circleShapeLayer)
        
        // the cross
        let upperPositionMultiplier: CGFloat = 1/3
        let lowerPositionMultipler: CGFloat = 1 - upperPositionMultiplier
        
        // The left part of the cross
        let leftCrossPath = UIBezierPath()
        leftCrossPath.move(to: CGPoint(x: bounds.size.width*upperPositionMultiplier, y: bounds.size.height*upperPositionMultiplier))
        leftCrossPath.addLine(to: CGPoint(x: bounds.size.width*lowerPositionMultipler, y: bounds.size.height*lowerPositionMultipler))
        leftCrossPath.close()
        
        let leftCrossShapeLayer = CAShapeLayer()
        leftCrossShapeLayer.path = leftCrossPath.cgPath
        
        leftCrossShapeLayer.fillColor = UIColor.clear.cgColor
        leftCrossShapeLayer.strokeColor = UIColor.white.cgColor
        leftCrossShapeLayer.lineWidth = desiredLineWidth
        
        layer.addSublayer(leftCrossShapeLayer)
        
        // The right part of the cross
        let rightCrossPath = UIBezierPath()
        rightCrossPath.move(to: CGPoint(x: bounds.size.width*lowerPositionMultipler, y: bounds.size.height*upperPositionMultiplier))
        rightCrossPath.addLine(to: CGPoint(x: bounds.size.width*upperPositionMultiplier, y: bounds.size.height*lowerPositionMultipler))
        rightCrossPath.close()
        
        let rightCrossShapeLayer = CAShapeLayer()
        rightCrossShapeLayer.path = rightCrossPath.cgPath
        
        rightCrossShapeLayer.fillColor = UIColor.clear.cgColor
        rightCrossShapeLayer.strokeColor = UIColor.white.cgColor
        rightCrossShapeLayer.lineWidth = desiredLineWidth
        
        layer.addSublayer(rightCrossShapeLayer)
    }
  
  override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    let frame = self.bounds.insetBy(dx: -30, dy: -30);
    return frame.contains(point) ? self : nil;
  }

}
