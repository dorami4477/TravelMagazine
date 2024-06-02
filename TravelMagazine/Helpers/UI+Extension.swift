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
//maskedCorners
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func roundCorneredImage(cornerSize:CGFloat, contentMode:UIView.ContentMode){
        self.layer.cornerRadius = cornerSize
        self.clipsToBounds = true
        self.contentMode = contentMode
    }
}

//String을 date로
extension String {
    func toDate() -> Date? { //"yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}

//date를 String으로
extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: self)
    }
}

