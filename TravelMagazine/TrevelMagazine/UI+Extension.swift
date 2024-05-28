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
        self.font = .systemFont(ofSize: size)
    }
}