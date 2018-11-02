//
//  ViewController.swift
//  VoiceOverlay-Demo
//
//  Created by Guy Daher on 25/06/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import UIKit
import InstantSearchVoiceOverlay

class ViewController: UIViewController, VoiceOverlayDelegate {
  
  let voiceOverlayController = VoiceOverlayController()
  let button = UIButton()
  let label = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let margins = view.layoutMarginsGuide
    
    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    label.text = "Result Text from the Voice Input"
    
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
    label.textAlignment = .center
    
    button.setTitle("Start using voice", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    button.backgroundColor = UIColor(red: 255/255.0, green: 64/255.0, blue: 129/255.0, alpha: 1)
    button.layer.cornerRadius = 7
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor(red: 237/255, green: 82/255, blue: 129/255, alpha: 1).cgColor
    
    label.translatesAutoresizingMaskIntoConstraints = false
    button.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(label)
    self.view.addSubview(button)
    
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10),
      label.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -10),
      label.topAnchor.constraint(equalTo: margins.topAnchor, constant: 110),
      ])
    
    NSLayoutConstraint.activate([
    button.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10),
    button.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -10),
    button.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 10),
    button.heightAnchor.constraint(equalToConstant: 50),
    ])
    
    voiceOverlayController.delegate = self
    
    // If you want to start recording as soon as modal view pops up, change to true
    voiceOverlayController.settings.autoStart = true
    voiceOverlayController.settings.autoStop = true
    voiceOverlayController.settings.showResultScreen = false
    
//    voiceOverlayController.settings.layout.inputScreen.subtitleBulletList = ["Suggestion1", "Suggestion2"]
    
  }
  
  @objc func buttonTapped() {
    // First way to listen to recording through callbacks
    voiceOverlayController.start(on: self, textHandler: { (text, final, extraInfo) in
      print("callback: getting \(String(describing: text))")
      print("callback: is it final? \(String(describing: final))")
      
      if final {
        // here can process the result to post in a result screen
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (_) in
          let myString = text
          let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.red ]
          let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
          
          self.voiceOverlayController.settings.resultScreenText = myAttrString
          self.voiceOverlayController.settings.layout.resultScreen.titleProcessed = "BLA BLA"
        })
      }
    }, errorHandler: { (error) in
      print("callback: error \(String(describing: error))")
    }, resultScreenHandler: { (text) in
      print("Result Screen: \(text)")
    }
    )
  }
  // Second way to listen to recording through delegate
  func recording(text: String?, final: Bool?, error: Error?) {
    if let error = error {
      print("delegate: error \(error)")
    }
    
    if error == nil {
      label.text = text
    }
  }
  
  
}

