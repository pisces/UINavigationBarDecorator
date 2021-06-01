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
//  CompatibleNavigationBarAppearance.swift
//  UINavigationBarDecorator
//
//  Created by Steve Kim on 2020/07/21.
//

import UIKit

open class CompatibleNavigationBarAppearance {
    
    // MARK: - Private Constants
    
    private enum BackgroundMode {
        case none
        case `default`
        case opaque
        case transparent
    }
    
    // MARK: - Open Properties
    
    open var isHidden = false
    open var isTranslucent = false
    open var backgroundImageContentMode: UIView.ContentMode = .scaleToFill
    open var titlePositionAdjustment: UIOffset = .zero
    open var tintColor: UIColor = .systemBlue
    open var backgroundImage: UIImage?
    open var shadowImage: UIImage?
    open var largeTitleTextAttributes: [NSAttributedString.Key: Any]?
    open var titleTextAttributes: [NSAttributedString.Key: Any]?
    
    open private(set) var backIndicatorImage: UIImage!
    open private(set) var backIndicatorTransitionMaskImage: UIImage!
    
    @NSCopying open var backgroundColor: UIColor?
    @NSCopying open var shadowColor: UIColor?
    @NSCopying open var backgroundEffect: UIBlurEffect?
    
    // MARK: - Private Properties

    private var backgroundMode: BackgroundMode = .none
    
    // MARK: - Constructors
    
    public init() {}
    
    // MARK: - Open Methods
    
    open func configureWithDefaultBackground() {
        backgroundMode = .default
    }
    open func configureWithOpaqueBackground() {
        backgroundMode = .opaque
    }
    open func configureWithTransparentBackground() {
        backgroundMode = .transparent
    }
    open func setBackIndicatorImage(_ backIndicatorImage: UIImage?, transitionMaskImage backIndicatorTransitionMaskImage: UIImage?) {
        if let backIndicatorImage = backIndicatorImage {
            self.backIndicatorImage = backIndicatorImage
        }
        if let backIndicatorTransitionMaskImage = backIndicatorTransitionMaskImage {
            self.backIndicatorTransitionMaskImage = backIndicatorTransitionMaskImage
        }
    }
    
    // MARK: - Internal Methods
    
    func apply(to navigationBar: UINavigationBar) {
        navigationBar.isTranslucent = isTranslucent
        navigationBar.tintColor = tintColor
        
        if #available(iOS 13.0, *) {
            return
        }
        
        navigationBar.barTintColor = backgroundColor
        navigationBar.backIndicatorImage = backIndicatorImage
        navigationBar.backIndicatorTransitionMaskImage = backIndicatorTransitionMaskImage
        navigationBar.titleTextAttributes = titleTextAttributes

        if let shadowImage = shadowImage {
            navigationBar.shadowImage = shadowImage
        } else if let shadowColor = shadowColor {
            navigationBar.shadowImage = .image(backgroundColor: shadowColor)
        }
        
        if #available(iOS 11.0, *) {
            navigationBar.largeTitleTextAttributes = largeTitleTextAttributes
        }
    }
    func apply(to navigationBar: UINavigationBar, for barMetrics: UIBarMetrics) {
        if let backgroundImage = backgroundImage {
            switch backgroundImageContentMode {
            case .scaleToFill:
                navigationBar.setBackgroundImage(backgroundImage, for: barMetrics)
            default:
                let imageView = UIImageView(image: backgroundImage)
                imageView.frame = .init(x: 0, y: 0, width: navigationBar.bounds.width, height: 64)
                imageView.contentMode = backgroundImageContentMode
                navigationBar.setBackgroundImage(imageView.captured(), for: barMetrics)
            }
        } else if backgroundMode == .transparent {
            navigationBar.setBackgroundImage(.init(), for: barMetrics)
        }

        navigationBar.setTitleVerticalPositionAdjustment(titlePositionAdjustment.vertical, for: barMetrics)
    }
    @available(iOS 13.0, *)
    func asUncompatible() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundImageContentMode = backgroundImageContentMode
        appearance.backgroundColor = backgroundColor
        appearance.backgroundEffect = backgroundEffect
        appearance.shadowColor = shadowColor
        appearance.shadowImage = shadowImage
        appearance.backgroundImage = backgroundImage
        appearance.largeTitleTextAttributes = largeTitleTextAttributes ?? [:]
        appearance.titleTextAttributes = titleTextAttributes ?? [:]
        appearance.titlePositionAdjustment = titlePositionAdjustment
        appearance.setBackIndicatorImage(backIndicatorImage, transitionMaskImage: backIndicatorTransitionMaskImage)
        switch backgroundMode {
        case .default:
            appearance.configureWithDefaultBackground()
        case .opaque:
            appearance.configureWithOpaqueBackground()
        case .transparent:
            appearance.configureWithTransparentBackground()
        case .none:
            ()
        }
        return appearance
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

private extension UIImage {
    static func image(backgroundColor: UIColor) -> UIImage {
        let view = UIView(frame: .init(x: 0, y: 0, width: 1, height: 1))
        view.backgroundColor = backgroundColor
        return view.captured()
    }
}

private extension UINavigationBar {
    var backgroundView: UIView? {
        return subviews.first(where: {
            switch NSStringFromClass(type(of: $0)) {
                case "UINavigationBarBackground",
                     "_UINavigationBarBackground",
                     "_UIBarBackground":
                return true
            default:
                return false
            }
        })
    }
}
