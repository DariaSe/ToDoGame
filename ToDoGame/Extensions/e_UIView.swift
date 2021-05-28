//
//  e_UIView.swift
//  ToDoGame
//
//  Created by Дарья Селезнёва on 24.04.2021.
//

import UIKit

extension UIView {
    
    func setConstraints(on subview: UIView, margins: Bool = false, leading: CGFloat? = 0, trailing: CGFloat? = 0, top: CGFloat? = 0, bottom: CGFloat? = 0) {
        self.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        if margins {
            if let leading = leading {
                subview.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: leading).isActive = true
            }
            if let trailing = trailing {
                subview.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -trailing).isActive = true
            }
            if let top = top {
                subview.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: top).isActive = true
            }
            if let bottom = bottom {
                subview.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -bottom).isActive = true
            }
        }
        else {
            if let leading = leading {
                subview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leading).isActive = true
            }
            if let trailing = trailing {
                subview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -trailing).isActive = true
            }
            if let top = top {
                subview.topAnchor.constraint(equalTo: self.topAnchor, constant: top).isActive = true
            }
            if let bottom = bottom {
                subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -bottom).isActive = true
            }
        }
    }
    
    func pinToEdges(to superview: UIView, constant: CGFloat = 0) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant).isActive = true
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
    }
    
    func pinToLayoutMargins(to superview: UIView, constant: CGFloat = 0) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.leadingAnchor, constant: constant).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor, constant: -constant).isActive = true
        self.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor, constant: constant).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor, constant: -constant).isActive = true
    }
    
    func constrainToLayoutMargins(of superview: UIView, leading: CGFloat, trailing: CGFloat, top: CGFloat?, bottom: CGFloat?) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.leadingAnchor, constant: leading).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor, constant: -trailing).isActive = true
        if let top = top {
            self.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor, constant: top).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor, constant: -bottom).isActive = true
        }
    }
    
    func center(in superview: UIView) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }
    
    func setDimensions(width: CGFloat? = nil, height: CGFloat? = nil) {
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func setWidth(equalTo view: UIView, multiplier: CGFloat = 1) {
        self.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier).isActive = true
    }
    
    func setHeight(equalTo view: UIView, multiplier: CGFloat = 1) {
        self.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier).isActive = true
    }
}

extension UIView {
    
    var snapshot: UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension UIView {
    func maskRoundedCorners(cornerRadius: CGFloat) {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), cornerRadius: cornerRadius).cgPath
        self.layer.mask = maskLayer
    }
    
    func maskRoundedCorners(corners: UIRectCorner, cornerRadius: CGFloat) {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        self.layer.mask = maskLayer
    }
}
