//
//  RootViewController.swift
//  UINavigationBarDecorator
//
//  Created by pisces on 07/21/2020.
//  Copyright (c) 2020 pisces. All rights reserved.
//

import UINavigationBarDecorator

final class RootViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Orange"
    }
}
