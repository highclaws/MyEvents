//
//  HomeViewController.swift
//  MyEvents
//
//  Created by ouali on 22/12/2019.
//  Copyright © 2019 Ouali Cherikh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!

    @IBOutlet var connectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Høme"    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.titleLabel.alpha = 0
    }
   
    @IBAction func touchConnect(_ sender: Any) {
        guard let navigationView = self.navigationController?.view else {
            return
        }
        UIView.transition(with: navigationView, duration: 0.5, options: .transitionFlipFromTop, animations: {
                self.navigationController?.pushViewController(LoginViewController(), animated: true)
        })
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}


