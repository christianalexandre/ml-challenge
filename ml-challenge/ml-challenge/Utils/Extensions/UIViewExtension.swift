//
//  UIViewExtension.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 22/06/24.
//

import Foundation
import UIKit

protocol LayoutGuideProvider {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }

            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    func applyBorder() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 2
    }
    
    func fillSuperView(padding: UIEdgeInsets = .zero) {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: padding.top),
            leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: padding.left),
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -padding.bottom),
            trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -padding.right)
        ])
    }
    
    func centerToSuperView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        guard let superview = self.superview else { return }
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor?,
                left: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                right: NSLayoutXAxisAnchor?,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat = 0,
                height: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }

        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }

        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }

        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func anchorToEntireView(of view: UIView, padding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor, constant: padding).isActive = true
        leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding).isActive = true
    }

    func anchorToEntireView(of view: UIView,
                            paddingTop: CGFloat = 0,
                            paddingLeft: CGFloat = 0,
                            paddingBottom: CGFloat = 0,
                            paddingRight: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor, constant: paddingTop).isActive = true
        leftAnchor.constraint(equalTo: view.leftAnchor, constant: paddingLeft).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -paddingBottom).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor, constant: -paddingRight).isActive = true
    }
    
    func sizeGreaterThanOrEqualTo(width: CGFloat? = nil, height: CGFloat? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let width = width {
            self.widthAnchor.constraint(greaterThanOrEqualToConstant: width).isActive = true
        }

        if let height = height {
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
        }
    }

    func sizeConstraintsEqualTo(width: CGFloat? = nil, height: CGFloat? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

extension UIView {
    func showToast(message: String, duration: Double = 2.0) {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        toastLabel.text = message
        toastLabel.alpha = 0.0
        toastLabel.numberOfLines = 0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(toastLabel)
        
        NSLayoutConstraint.activate([
            toastLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            toastLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            toastLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            toastLabel.heightAnchor.constraint(equalToConstant: 36)

        ])
        
        toastLabel.layer.shadowColor = UIColor.black.cgColor
        toastLabel.layer.shadowOpacity = 0.3
        toastLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
        toastLabel.layer.shadowRadius = 4
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            toastLabel.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
}
