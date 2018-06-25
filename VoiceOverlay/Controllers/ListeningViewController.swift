//
//  ListeningViewController.swift
//  VoiceUI
//
//  Created by Guy Daher on 25/06/2018.
//  Copyright © 2018 Algolia. All rights reserved.
//

import UIKit

class ListeningViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = VoiceUIConstants.PermissionScreen.backgroundColor
        
        let margins = view.layoutMarginsGuide
        let closeView = CloseView()
        
        closeView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(closeView)
        
        setConstraintsForCloseView(closeView, margins)
    
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.closeButtonTapped(_:)))
        closeView.addGestureRecognizer(tap)
    }
    
    @objc func closeButtonTapped(_ sender: UITapGestureRecognizer) {
        self.presentingViewController?.presentingViewController?.dismissMe(animated: true)
        dismissMe(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
