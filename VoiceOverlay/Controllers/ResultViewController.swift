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
  let startAgainButton = UIButton()
  
  var dismissHandler: ((Bool) -> ())? = nil
  
  var voiceOutputText: NSAttributedString? {
    didSet {
      titleLabel.text = constants.titleProcessed
      subtitleLabel.attributedText = voiceOutputText
    }
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    let margins = view.layoutMarginsGuide
    
    let subViews = [titleLabel, subtitleLabel, startAgainButton]
    
    ViewHelpers.translatesAutoresizingMaskIntoConstraintsFalse(for: subViews)
    ViewHelpers.addSubviews(for: subViews, in: view)
    
    view.backgroundColor = constants.backgroundColor
    ViewHelpers.setConstraintsForTitleLabel(titleLabel, margins, constants.title, constants.textColor)
    ViewHelpers.setConstraintsForSubtitleLabel(subtitleLabel, titleLabel, margins, constants.subtitle, constants.textColor)
    ViewHelpers.setConstraintsForFirstButton(startAgainButton, margins, constants.startAgainText, constants.textColor)
    startAgainButton.backgroundColor = .clear
    startAgainButton.layer.cornerRadius = 7
    startAgainButton.layer.borderWidth = 1
    startAgainButton.layer.borderColor = constants.textColor.cgColor
    
    startAgainButton.addTarget(self, action: #selector(startAgainTapped), for: .touchUpInside)
  }
  
  @objc func startAgainTapped() {
    dismissHandler?(true)
  }
}
