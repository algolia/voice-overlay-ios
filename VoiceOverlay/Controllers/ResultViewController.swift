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
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    
    let margins = view.layoutMarginsGuide
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let startAgainButton = UIButton()
    let closeView = CloseView()
    
    let subViews = [titleLabel, subtitleLabel, startAgainButton, closeView]
    
    ViewHelpers.translatesAutoresizingMaskIntoConstraintsFalse(for: subViews)
    ViewHelpers.addSubviews(for: subViews, in: view)
    
    view.backgroundColor = constants.backgroundColor
    ViewHelpers.setConstraintsForTitleLabel(titleLabel, margins, constants.title, constants.textColor)
    ViewHelpers.setConstraintsForSubtitleLabel(subtitleLabel, titleLabel, margins, constants.subtitle, constants.textColor)
    ViewHelpers.setConstraintsForCloseView(closeView, margins, backgroundColor: constants.backgroundColor)
    ViewHelpers.setConstraintsForFirstButton(startAgainButton, margins, constants.startAgainText , constants.textColor)
    
    startAgainButton.addTarget(self, action: #selector(startAgainButtonTapped), for: .touchUpInside)
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(self.closeButtonTapped(_:)))
    closeView.addGestureRecognizer(tap)
  }
  
  @objc func startAgainButtonTapped() {
    dismissMe(animated: true)
  }
  
  @objc func closeButtonTapped(_ sender: UITapGestureRecognizer) {
    dismissMe(animated: true)
  }
  
}
