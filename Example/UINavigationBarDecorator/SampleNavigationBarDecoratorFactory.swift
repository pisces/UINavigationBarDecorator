//
//  SampleNavigationBarDecoratorFactory.swift
//  UINavigationBarDecorator_Example
//
//  Created by KWANG HYOUN KIM on 2020/07/24.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UINavigationBarDecorator

struct SampleNavigationBarDecoratorFactory: UINavigationBarDecoratorFactory {
    init() {}
    
    func create(of vc: UIViewController) -> UINavigationBarDecorator? {
        switch vc {
        case is RootViewController:
            return .init(standard: .white)
        case is SecondViewController:
            return .init(standard: .black)
        default:
            return nil
        }
    }
}

private extension CompatibleNavigationBarAppearance {
    static var black: CompatibleNavigationBarAppearance {
        let appearance = CompatibleNavigationBarAppearance()
        appearance.backgroundColor = .black
        appearance.tintColor = .white
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
        return appearance
    }
    static var white: CompatibleNavigationBarAppearance {
        let appearance = CompatibleNavigationBarAppearance()
        appearance.tintColor = .black
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
        return appearance
    }
}
