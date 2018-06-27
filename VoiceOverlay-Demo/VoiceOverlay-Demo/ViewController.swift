//
//  ViewController.swift
//  VoiceOverlay-Demo
//
//  Created by Guy Daher on 25/06/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import UIKit
import VoiceOverlay

class ViewController: UIViewController, VoiceOverlayDelegate {
    
    func recording(text: String?, final: Bool?, error: Error?) {
        if error == nil {
            label.text = text
        }
    }
    
    let voiceOverlayController = VoiceOverlayController()
    let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
    let label = UILabel(frame: CGRect(x: 100, y: 400, width: 400, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.setTitle("Voice Button", for: .normal)
        button.setTitleColor(.red, for: .normal)
        label.text = "asd"
        self.view.addSubview(label)
        self.view.addSubview(button)
        voiceOverlayController.delegate = self
        
        
    }
    
    @objc func buttonTapped() {
        
        voiceOverlayController.start(on: self)
    }


}

