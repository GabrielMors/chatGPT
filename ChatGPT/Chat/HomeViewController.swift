//
//  ViewController.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 31/05/23.
//

import UIKit

class HomeViewController: UIViewController {

    var screen: HomeScreen?
    
    override func loadView() {
        screen = HomeScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

