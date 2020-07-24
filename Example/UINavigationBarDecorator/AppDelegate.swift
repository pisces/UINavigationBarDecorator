//
//  AppDelegate.swift
//  UINavigationBarDecorator
//
//  Created by pisces on 07/21/2020.
//  Copyright (c) 2020 pisces. All rights reserved.
//

import UINavigationBarDecorator

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBarDecorator.isApplyWhenViewWillAppear = true
        UINavigationBarDecorator.factory = SampleNavigationBarDecoratorFactory()
        return true
    }
}

