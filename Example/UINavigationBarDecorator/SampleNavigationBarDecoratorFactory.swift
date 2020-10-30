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
            return .init(standard: .transparent, scrollEdge: .transparent)
        case is SecondViewController:
            return .init(standard: .purple, scrollEdge: .purple)
        default:
            return nil
        }
    }
}

private extension CompatibleNavigationBarAppearance {
    static var purple: CompatibleNavigationBarAppearance {
        let appearance = CompatibleNavigationBarAppearance()
        appearance.backgroundColor = .purple
        appearance.tintColor = .white
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font : UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
        return appearance
    }
    static var orange: CompatibleNavigationBarAppearance {
        let appearance = CompatibleNavigationBarAppearance()
        appearance.backgroundColor = .orange
        appearance.tintColor = .black
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font : UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
        return appearance
    }
    static var transparent: CompatibleNavigationBarAppearance {
        let appearance = CompatibleNavigationBarAppearance()
        appearance.backgroundColor = .clear
        appearance.backgroundEffect = .none
        appearance.tintColor = .white
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font : UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
        appearance.configureWithTransparentBackground()
        return appearance
    }
}
