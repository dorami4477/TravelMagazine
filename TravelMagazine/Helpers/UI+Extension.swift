//
//  UI+Extension.swift
//  TravelMagazine
//
//  Created by 박다현 on 5/29/24.
//

import UIKit

extension UILabel{
    func setUILabel(size:CGFloat, weight:UIFont.Weight, color:UIColor, numberOfLines:Int){
        self.numberOfLines = numberOfLines
        self.textColor = color
        self.font = .systemFont(ofSize: size, weight: weight)
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
