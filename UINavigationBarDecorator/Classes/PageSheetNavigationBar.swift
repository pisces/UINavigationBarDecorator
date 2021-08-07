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
//  PageSheetNavigationBar.swift
//  UINavigationBarDecorator
//
//  Created by Steve Kim on 2020/11/06.
//

import UIKit

open class PageSheetNavigationBar: AdvancedNavigationBar {
    
    // MARK: - Lifecycle
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        thumbLayer.frame.origin = .init(
            x: (bounds.width - thumbLayer.bounds.width) / 2,
            y: (contentInsets.top - thumbLayer.bounds.height) / 2)
    }
    
    open override func initProperties() {
        layer.addSublayer(thumbLayer)
        contentInsetTop = 24
    }
    
    // MARK: - Public
    
    @IBInspectable
    public var thumbHeight: CGFloat {
        get {
            thumbLayer.frame.size.height
        }
        set {
            thumbLayer.frame.size.height = newValue
            setNeedsLayout()
        }
    }
    @IBInspectable
    public var thumbWidth: CGFloat {
        get {
            thumbLayer.frame.size.width
        }
        set {
            thumbLayer.frame.size.width = newValue
            setNeedsLayout()
        }
    }
    @IBInspectable
    public var thumbColor: UIColor? {
        get {
            thumbLayer.backgroundColor.map { UIColor(cgColor: $0) }
        }
        set {
            thumbLayer.backgroundColor = newValue?.cgColor
            setNeedsLayout()
        }
    }
    
    // MARK: - Private
    
    private lazy var thumbLayer: CALayer = {
        let layer = CALayer()
        layer.cornerRadius = 2
        layer.backgroundColor = UIColor(red: 166 / 255, green: 166 / 255, blue: 128 / 255, alpha: 0.18).cgColor
        layer.frame.size = .init(width: 44, height: 4)
        return layer
    }()
}
