//
//  UIView+Decoration.swift
//  ToDo
//
//  Created by Gantapong Mongkhonkaset on 17/3/2564 BE.
//  Copyright © 2564 BE Gantapong Mongkhonkaset. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow(shadowColor: UIColor = .darkGray, offSet: CGSize = .zero, opacity: Float = 0.5, shadowRadius: CGFloat = 4, cornerRadius: CGFloat = 8, corners: UIRectCorner = .allCorners, fillColor: UIColor = .white) {
        
        let shadowLayer = CAShapeLayer()
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let cgPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: size).cgPath
        shadowLayer.path = cgPath
        shadowLayer.fillColor = fillColor.cgColor
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowPath = cgPath
        shadowLayer.shadowOffset = offSet
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        shadowLayer.zPosition = -1
        layer.addSublayer(shadowLayer)
    }
}
