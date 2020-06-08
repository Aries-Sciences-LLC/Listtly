//
//  UIViewShadowExtensions.swift
//  Listtly
//
//  Created by Ozan Mirza on 5/4/18.
//  Copyright © 2018 Ozan Mirza. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow(with color: UIColor) {
        layer.shadowColor = color.cgColor
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    func removeShadow() {
        layer.shadowOpacity = 0
    }
}
