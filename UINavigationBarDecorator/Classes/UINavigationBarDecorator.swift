//  BSD 2-Clause License
//
//  Copyright (c) 2020, Steve Kim
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  * Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//
//  * Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
//  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
//  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
//  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
//  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  UINavigationBarDecorator.swift
//  UINavigationBarDecorator
//
//  Created by Steve Kim on 2020/07/21.
//

import UIKit

public protocol UINavigationBarDecoratorFactory {
    func create(of vc: UIViewController) -> UINavigationBarDecorator?
}

public final class UINavigationBarDecorator {
    
    // MARK: - Public Properties
    
    /**
     * If true, navigation bar will decorate automacally it according to life cycle of view controller.
     * @default value is false
     */
    public static var isAllowsSwizzleLifeCycleOfViewController = false {
        didSet {
            if isAllowsSwizzleLifeCycleOfViewController {
                UIViewController.swizzleViewWillAppear()
                UIViewController.swizzleViewDidAppear()
            }
        }
    }
    /**
     * It will create navigation bar decorator of view controller if navigationBarDecorator of view controller is not setted.
     */
    public static var factory: UINavigationBarDecoratorFactory?
    
    // MARK: - Private Constants
    
    private let standard: CompatibleNavigationBarAppearance
    private let compact: CompatibleNavigationBarAppearance?
    private let scrollEdge: CompatibleNavigationBarAppearance?
    
    // MARK: - Private Properties
    
    private static var isNavigationControllerSwizzled = false
    
    // MARK: - Constructors
    
    public init(standard: CompatibleNavigationBarAppearance, compact: CompatibleNavigationBarAppearance? = nil, scrollEdge: CompatibleNavigationBarAppearance? = nil) {
        self.standard = standard
        self.compact = compact
        self.scrollEdge = scrollEdge

        if !Self.isNavigationControllerSwizzled {
            UINavigationController.swizzleViewWillTransition()
            Self.isNavigationControllerSwizzled = true
        }
    }
    
    // MARK: - Public Methods
    
    public func decorate(to target: UIViewController) {
        target.navigationController.map {
            if #available(iOS 13.0, *) {
                $0.navigationBar.standardAppearance = standard.asUncompatible()
                $0.navigationBar.compactAppearance = compact?.asUncompatible()
                $0.navigationBar.scrollEdgeAppearance = scrollEdge?.asUncompatible()
            } else {
                standard.apply(to: $0.navigationBar, for: .default)
                standard.apply(to: $0.navigationBar, for: .defaultPrompt)
                (compact ?? standard).apply(to: $0.navigationBar, for: .compact)
                (compact ?? standard).apply(to: $0.navigationBar, for: .compactPrompt)
            }
            decorate(to: target, by: target.view.bounds.size)
        }
    }
    public func decorate(to target: UIViewController, by size: CGSize) {
        target.navigationController.map {
            let current = currentAppearance(of: size, navigationBar: $0.navigationBar) ?? standard
            $0.isNavigationBarHidden = current.isHidden
            current.apply(to: $0.navigationBar)
        }
    }
    
    // MARK: - Private Methods
    
    private func currentAppearance(of size: CGSize, navigationBar: UINavigationBar) -> CompatibleNavigationBarAppearance? {
        guard size.width > size.height else {
            if #available(iOS 11.0, *) {
                return navigationBar.prefersLargeTitles ? scrollEdge : standard
            }
            return standard
        }
        return compact
    }
}

// MARK: - Swizzling

private struct SwizzleObject {
    let `class`: AnyClass
    let selector: Selector
}

private func swizzle(from: SwizzleObject, to: SwizzleObject) {
    let fromMethod = class_getInstanceMethod(from.class, from.selector)
    let toMethod = class_getInstanceMethod(to.class, to.selector)
    
    if let origin = fromMethod, let swizzle = toMethod {
        method_exchangeImplementations(origin, swizzle)
    }
}

private extension UIViewController {
    static func swizzleViewWillAppear() {
        swizzle(
            from: .init(class: UIViewController.self, selector: #selector(viewWillAppear)),
            to: .init(class: UIViewController.self, selector: #selector(swizzled_viewWillAppear(_:)))
        )
    }
    static func swizzleViewDidAppear() {
        swizzle(
            from: .init(class: UIViewController.self, selector: #selector(viewDidAppear(_:))),
            to: .init(class: UIViewController.self, selector: #selector(swizzled_viewDidAppear))
        )
    }
    
    func isDecoratable(_ target: UIViewController) -> Bool {
        switch NSStringFromClass(type(of: target)) {
        case "UINavigationController",
             "UIInputWindowController":
            return false
        default:
            return true
        }
    }
    
    @objc private func swizzled_viewWillAppear(_ animated: Bool) {
        if isDecoratable(self) {
            navigationBarDecorator?.decorate(to: self)
        }
    }
    @objc private func swizzled_viewDidAppear(_ animated: Bool) {
        if isDecoratable(self) {
            navigationBarDecorator?.decorate(to: self, by: view.frame.size)
        }
    }
}

private extension UINavigationController {
    static func swizzleViewWillTransition() {
        swizzle(
            from: .init(class: UINavigationController.self, selector: #selector(viewWillTransition(to:with:))),
            to: .init(class: UINavigationController.self, selector: #selector(swizzled_viewWillTransition(to:with:)))
        )
    }
    
    @objc private func swizzled_viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        visibleViewController.map {
            navigationBarDecorator?.decorate(to: $0, by: size)
        }
    }
}
