//
//  ResultViewController.swift
//  VoiceOverlay
//
//  Created by Guy Daher on 10/07/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import UIKit

import UIKit

public class ResultViewController: UIViewController {
  
  var constants: ResultScreenConstants!
  
  let titleLabel = UILabel()
  let subtitleLabel = UILabel()
  
  var voiceOutputText: NSAttributedString? {
    didSet {
      titleLabel.text = constants.titleProcessed
      subtitleLabel.attributedText = voiceOutputText
    }
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    let margins = view.layoutMarginsGuide
    
    let subViews = [titleLabel, subtitleLabel]
    
    ViewHelpers.translatesAutoresizingMaskIntoConstraintsFalse(for: subViews)
    ViewHelpers.addSubviews(for: subViews, in: view)
    
    view.backgroundColor = constants.backgroundColor
    ViewHelpers.setConstraintsForTitleLabel(titleLabel, margins, constants.title, constants.textColor)
    ViewHelpers.setConstraintsForSubtitleLabel(subtitleLabel, titleLabel, margins, constants.subtitle, constants.textColor)
  }
}
