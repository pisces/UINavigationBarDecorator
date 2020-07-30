//
//  AutoDecoratableNavigationController.swift
//  UINavigationBarDecorator_Example
//
//  Created by pisces on 2020/07/30.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UINavigationBarDecorator

final class AutoDecoratableNavigationController: UINavigationController {
    override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBarDecorator.isAllowsSwizzleLifeCycleOfViewController = true
        UINavigationBarDecorator.factory = SampleNavigationBarDecoratorFactory()
        
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = true
        }
    }
}
