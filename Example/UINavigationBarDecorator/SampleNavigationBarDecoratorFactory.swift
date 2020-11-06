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
            return .init(standard: .orange, scrollEdge: .orange)
        case is SecondViewController:
            return .init(standard: .purple, scrollEdge: .purple)
        case is AdvancedNavigationBarViewController:
            return .init(standard: .extraLight, scrollEdge: .extraLight)
        case is PageSheetNavigationBarViewController:
            return .init(standard: .dark, scrollEdge: .dark)
        default:
            return nil
        }
    }
}

private extension CompatibleNavigationBarAppearance {
    static var dark: CompatibleNavigationBarAppearance {
        let appearance = CompatibleNavigationBarAppearance()
        appearance.backgroundEffect = .init(style: .dark)
        appearance.tintColor = .white
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font : UIFont.systemFont(ofSize: 17, weight: .thin)
        ]
        return appearance
    }
    static var extraLight: CompatibleNavigationBarAppearance {
        let appearance = CompatibleNavigationBarAppearance()
        appearance.backgroundEffect = .init(style: .extraLight)
        appearance.tintColor = .black
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
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
}
