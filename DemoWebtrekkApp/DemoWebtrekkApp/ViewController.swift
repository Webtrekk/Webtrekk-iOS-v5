//
//  ViewController.swift
//  DemoWebtrekkApp
//
//  Created by Vladan Randjelovic on 20/01/2020.
//  Copyright © 2020 Vladan Randjelovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        MappIntelligence.shared()?.trackPage(self)
    }

    @IBAction func moveToConfigurationScreen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "configuration")
        self.present(vc, animated: true, completion: nil)
    }
    
}
