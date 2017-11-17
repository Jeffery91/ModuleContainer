//
//  Hoverable.swift
//  Pods
//
//  Created by jeffery on 2017/8/21.
//
//

import UIKit

public protocol Hoverable {
    
    var hoverView: UIView { get }
}

extension Hoverable where Self: UIView  {
    
    public func isIdentity() -> Bool {
        return hoverView.superview == self
    }
}
