//
//  ManualDecoratableNavigationController.swift
//  UINavigationBarDecorator_Example
//
//  Created by pisces on 2020/07/31.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UINavigationBarDecorator

final class ManualDecoratableNavigationController: UINavigationController {
    override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBarDecorator.factory = SampleNavigationBarDecoratorFactory()

        delegate = self
        
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = true
        }
    }
}

extension ManualDecoratableNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationBarDecorator?.decorate(to: viewController)
    }
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        viewController.navigationBarDecorator?.decorate(to: viewController, by: viewController.view.frame.size)
    }
}
