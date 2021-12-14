//
//  ViewController.swift
//  AirbnbClone
//
//  Created by Владислав Матыгин on 14.12.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func button(_ sender: UIButton) {
        navigationController?.pushViewController(MainViewController(), animated: true)
    }
}
