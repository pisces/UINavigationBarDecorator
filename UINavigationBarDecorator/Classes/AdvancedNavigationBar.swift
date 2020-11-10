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
//  AdvancedNavigationBar.swift
//  UINavigationBarDecorator
//
//  Created by Steve Kim on 2020/11/06.
//

import UIKit

open class AdvancedNavigationBar: UINavigationBar {
    
    // MARK: - Variables (Inspectables)
    
    @IBInspectable
    public var contentInsetLeft: CGFloat {
        get {
            contentInsets.left
        }
        set {
            contentInsets.left = newValue
            setNeedsLayout()
        }
    }
    @IBInspectable
    public var contentInsetTop: CGFloat {
        get {
            contentInsets.top
        }
        set {
            contentInsets.top = newValue
            setNeedsLayout()
        }
    }
    @IBInspectable
    public var contentInsetRight: CGFloat {
        get {
            contentInsets.right
        }
        set {
            contentInsets.right = newValue
            setNeedsLayout()
        }
    }
    @IBInspectable
    public var contentInsetBottom: CGFloat {
        get {
            contentInsets.bottom
        }
        set {
            contentInsets.bottom = newValue
            setNeedsLayout()
        }
    }
    
    // MARK: - Variables (Input)
    
    public var contentInsets: UIEdgeInsets = .zero {
        didSet {
            setNeedsLayout()
        }
    }
    
    // MARK: - Variables
    
    public var navigationBarHeight: CGFloat {
        44 + contentInsets.top + contentInsets.bottom
    }
    
    // MARK: - Constructors
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initProperties()
        sizeToFit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initProperties()
    }
    
    // MARK: - Overridden: UINavigationBar
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        subviews.forEach {
            $0.frame = frame(of: $0)
            $0.sizeToFit()
        }
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        .init(width: size.width, height: navigationBarHeight)
    }
    
    // MARK: - Functions
    
    open func initProperties() { }
}

extension AdvancedNavigationBar {
    private func frame(of subview: UIView) -> CGRect {
        let name = NSStringFromClass(subview.classForCoder)
        if name.contains("UIBarBackground") {
            return CGRect(x: 0, y: 0, width: bounds.width, height: navigationBarHeight)
        }
        if name.contains("UINavigationBarContentView") {
            return CGRect(
                x: contentInsets.left,
                y: (44 - subview.bounds.height) / 2 + contentInsets.top,
                width: bounds.width - contentInsets.left - contentInsets.right,
                height: subview.bounds.height)
        }
        return subview.frame
    }
}
