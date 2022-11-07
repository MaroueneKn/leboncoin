//
//  ConstraintHandler.swift
//  leboncoin
//
//  Created by Kandara Marouene on 05/11/2022.
//

import Foundation
import UIKit

class ConstaintHanlder {
    static func setConstraint (_ view : UIView,
                 top: NSLayoutYAxisAnchor? = nil,
                 left: NSLayoutXAxisAnchor? = nil,
                 bottom: NSLayoutYAxisAnchor? = nil,
                 right: NSLayoutXAxisAnchor? = nil,
                 paddingTop: CGFloat = 0,
                 paddingLeft: CGFloat = 0,
                 paddingBottom: CGFloat = 0,
                 paddingRight: CGFloat = 0,
                 width: CGFloat = 0,
                 height: CGFloat = 0,
                 enableInsets: Bool) {
        
            var topInset = CGFloat(0)
            var bottomInset = CGFloat(0)
            
            if enableInsets {
                let insets = view.safeAreaInsets
                topInset = insets.top
                bottomInset = insets.bottom
            }
        
            view.translatesAutoresizingMaskIntoConstraints = false
            
            if let top = top {
                view.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
            }
            if let left = left {
                view.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
            }
            if let right = right {
                view.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }
            if let bottom = bottom {
                view.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
            }
            if height != 0 {
                view.heightAnchor.constraint(equalToConstant: height).isActive = true
            }
            if width != 0 {
                view.widthAnchor.constraint(equalToConstant: width).isActive = true
            }
        }
        
    
}
