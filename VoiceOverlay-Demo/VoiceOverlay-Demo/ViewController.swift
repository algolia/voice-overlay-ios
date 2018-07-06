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
    
    let voiceOverlayController = VoiceOverlayController()
    let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
    let label = UILabel(frame: CGRect(x: 100, y: 400, width: 400, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.setTitle("Voice Button", for: .normal)
        button.setTitleColor(.red, for: .normal)
        label.text = "text filled by delegate method"
        self.view.addSubview(label)
        self.view.addSubview(button)
        voiceOverlayController.delegate = self
        
        // If you want to start recording as soon as modal view pops up, change to true
        VoiceUIConstants.RecordingScreen.autoStart = true
        VoiceUIConstants.RecordingScreen.autoStop = true
    }
    
    @objc func buttonTapped() {
        // First way to listen to recording through callbacks
        voiceOverlayController.start(on: self, textHandler: { (text, final) in
            print("callback: getting \(String(describing: text))")
            print("callback: is it final? \(String(describing: final))")
        }) { (error) in
            print("callback: error \(String(describing: error))")
        }
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

