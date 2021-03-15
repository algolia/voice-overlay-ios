//
//  AutoLayoutHelpers.swift
//  VoiceUI
//
//  Created by Guy Daher on 25/06/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 10.0, *)
class ViewHelpers {
    static func setConstraintsForTitleLabel(_ titleLabel: UILabel, _ margins: UILayoutGuide, _ text: String, _ textColor: UIColor) {
        setDefaultSideConstraints(to: titleLabel, in: margins)
        titleLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 100).isActive = true
        titleLabel.text = text
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        titleLabel.textColor = textColor
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
      }
    
    static func setConstraintsForSubtitleLabel(_ subtitleLabel: UILabel, _ titleLabel: UILabel, _ margins: UILayoutGuide, _ text: String, _ textColor: UIColor) {
        setDefaultSideConstraints(to: subtitleLabel, in: margins)
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        subtitleLabel.text = text
        subtitleLabel.font = UIFont.systemFont(ofSize: 18)
        subtitleLabel.textColor = textColor
        subtitleLabel.lineBreakMode = .byWordWrapping
        subtitleLabel.numberOfLines = 0
    }
  
  static func setConstraintsForSubtitleBulletLabel(_ subtitleBulletLabel: UILabel, _ subtitleLabel: UILabel, _ margins: UILayoutGuide, _ text: [String], _ textColor: UIColor) {
    setDefaultSideConstraints(to: subtitleBulletLabel, in: margins, multiplier: 2)
    subtitleBulletLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10).isActive = true
    
    // This is a temp fix for labels not always showing the current intrinsic multiline height
    subtitleBulletLabel.heightAnchor.constraint(equalToConstant: CGFloat(36 * text.count)).isActive = true
    subtitleBulletLabel.font = UIFont.boldSystemFont(ofSize: 16)
    subtitleBulletLabel.attributedText = ViewHelpers.add(stringList: text, font: subtitleBulletLabel.font)
    subtitleBulletLabel.textColor = textColor
    subtitleBulletLabel.lineBreakMode = .byWordWrapping
    subtitleBulletLabel.numberOfLines = 0
  }

  static func setConstraintsForCloseView(_ closeView: CloseView, _ margins: UILayoutGuide, backgroundColor: UIColor) {
        closeView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        closeView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        closeView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -30).isActive = true
        closeView.backgroundColor = .clear
    }

    static func setConstraintsForFirstButton(_ firstButton: UIButton, _ margins: UILayoutGuide, _ text: String, _ textColor: UIColor) {
      setDefaultSideConstraints(to: firstButton, in: margins)
        firstButton.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 50).isActive = true
        firstButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        firstButton.setTitle(text, for: .normal)
        firstButton.setTitleColor(textColor, for: .normal)
    }

    static func setConstraintsForSecondButton(_ secondButton: UIButton, _ firstButton: FirstPermissionButton, _ margins: UILayoutGuide, _ text: String, _ textColor: UIColor) {
        setDefaultSideConstraints(to: secondButton, in: margins)
        secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 15).isActive = true
        secondButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        secondButton.setTitle(text, for: .normal)
        secondButton.setTitleColor(textColor, for: .normal)
        secondButton.backgroundColor = .clear
        secondButton.layer.cornerRadius = 7
        secondButton.layer.borderWidth = 1
        secondButton.layer.borderColor = textColor.cgColor
    }
    
  static func setConstraintsForRecordingButton(_ recordingButton: RecordingButton, _ margins: UILayoutGuide, recordingButtonConstants: InputButtonConstants) {
        recordingButton.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 50).isActive = true
        recordingButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        recordingButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        recordingButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        let bundle = Bundle(for: self)
        let recordingImage = UIImage(named: "mic-lg-inactive", in: bundle, compatibleWith: nil)
        recordingButton.setBackgroundImage(recordingImage, for: .normal)
        
        recordingButton.pulseColor = recordingButtonConstants.pulseColor
        recordingButton.pulseDuration = recordingButtonConstants.pulseDuration
        recordingButton.pulseRadius = recordingButtonConstants.pulseDuration
    }

    static func setConstraintsForTryAgainLabel(_ tryAgainLabel: UILabel, _ recordButton: UIView, _ margins: UILayoutGuide, _ text: String, _ textColor: UIColor) {
        tryAgainLabel.topAnchor.constraint(equalTo: recordButton.bottomAnchor, constant: 15).isActive = true
        tryAgainLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        tryAgainLabel.text = text
        tryAgainLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        tryAgainLabel.textColor = textColor
        tryAgainLabel.textAlignment = .center
    }
  
  static func add(stringList: [String],
                       font: UIFont,
                       bullet: String = "\u{2022}",
                       indentation: CGFloat = 30,
                       lineSpacing: CGFloat = 2,
                       paragraphSpacing: CGFloat = 5,
                       textColor: UIColor = .white,
                       bulletColor: UIColor = .white) -> NSAttributedString {
    
    let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: textColor]
    let bulletAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: bulletColor]
    
    let paragraphStyle = NSMutableParagraphStyle()
    let nonOptions = [NSTextTab.OptionKey: Any]()
    paragraphStyle.tabStops = [
      NSTextTab(textAlignment: .left, location: indentation, options: nonOptions)]
    paragraphStyle.defaultTabInterval = indentation
    //paragraphStyle.firstLineHeadIndent = 0
    //paragraphStyle.headIndent = 20
    //paragraphStyle.tailIndent = 1
    paragraphStyle.lineSpacing = lineSpacing
    paragraphStyle.paragraphSpacing = paragraphSpacing
    paragraphStyle.headIndent = indentation
    
    let bulletList = NSMutableAttributedString()
    for string in stringList {
      let formattedString = "\(bullet)\t\(string)\n"
      let attributedString = NSMutableAttributedString(string: formattedString)
      
      attributedString.addAttributes(
        [NSAttributedString.Key.paragraphStyle : paragraphStyle],
        range: NSMakeRange(0, attributedString.length))
      
      attributedString.addAttributes(
        textAttributes,
        range: NSMakeRange(0, attributedString.length))
      
      let string:NSString = NSString(string: formattedString)
      let rangeForBullet:NSRange = string.range(of: bullet)
      attributedString.addAttributes(bulletAttributes, range: rangeForBullet)
      bulletList.append(attributedString)
    }
    
    return bulletList
  }
    
    
  static func setDefaultSideConstraints(to firstView: UIView, in layoutGuide: UILayoutGuide, multiplier: CGFloat = 1) {
        firstView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: multiplier * VoiceUIInternalConstants.sideMarginConstant).isActive = true
        firstView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: multiplier * VoiceUIInternalConstants.sideMarginConstant).isActive = true
    }
    
    static func translatesAutoresizingMaskIntoConstraintsFalse(for views: [UIView]) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    static func addSubviews(for subViews: [UIView], in view: UIView) {
        subViews.forEach {
            view.addSubview($0)
        }
    }
}
