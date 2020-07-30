//
//  SecondViewController.swift
//  UINavigationBarDecorator_Example
//
//  Created by KWANG HYOUN KIM on 2020/07/22.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UINavigationBarDecorator

final class SecondViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Purple"
    }
}
