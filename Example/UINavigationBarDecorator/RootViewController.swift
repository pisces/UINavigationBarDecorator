//
//  RootViewController.swift
//  UINavigationBarDecorator
//
//  Created by pisces on 07/21/2020.
//  Copyright (c) 2020 pisces. All rights reserved.
//

import UINavigationBarDecorator

final class RootViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "RootViewController"
        view.backgroundColor = .black
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

private extension UIView {
    func captured() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
