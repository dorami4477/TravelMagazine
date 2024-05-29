//
//  CityCell.swift
//  TravelMagazine
//
//  Created by 박다현 on 5/29/24.
//

import UIKit
import Kingfisher

class CityCell: UITableViewCell {

    @IBOutlet var backUIView: UIView!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var explainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()

    }

    override func draw(_ rect: CGRect) {
        backUIView.roundCorners(corners: [.bottomRight, .topLeft], radius: 20)

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //검색한 텍스트스타일 변경 ** 대소문자 구문을 못하는 문제가 있음
    func changeText(text:String){
        let attributedStr = NSMutableAttributedString(string: cityNameLabel.text!)
        attributedStr.addAttribute(.backgroundColor, value: UIColor.yellow, range: (cityNameLabel.text! as NSString).range(of: text))
        attributedStr.addAttribute(.foregroundColor, value: UIColor.black, range: (cityNameLabel.text! as NSString).range(of: text))
        cityNameLabel.attributedText = attributedStr
        
        let attributedStr2 = NSMutableAttributedString(string: explainLabel.text!)
        attributedStr2.addAttribute(.backgroundColor, value: UIColor.yellow, range: (explainLabel.text! as NSString).range(of: text))
        attributedStr2.addAttribute(.foregroundColor, value: UIColor.black, range: (explainLabel.text! as NSString).range(of: text))
        explainLabel.attributedText = attributedStr2
    }
    
    
    func configureUI(){
        mainImageView.contentMode = .scaleAspectFill
        cityNameLabel.setUILabel(size: 18, weight: .bold, color: .white, numberOfLines: 1)
        explainLabel.setUILabel(size: 14, weight: .regular, color: .white, numberOfLines: 1)
        explainLabel.backgroundColor = .black.withAlphaComponent(0.6)
        
        //** 그림자가 들어가지 않음!
        backUIView.layer.masksToBounds = false
        backUIView.layer.shadowColor = UIColor.black.cgColor
        backUIView.layer.shadowOpacity = 0.4
        backUIView.layer.shadowRadius = 6
    }
    
    
    func configureData(_ data:City){
        let url = URL(string: data.city_image)
        mainImageView.kf.setImage(with: url)
        
        cityNameLabel.text = data.city_name + " | " + data.city_english_name
        explainLabel.text = data.city_explain
    }
    
}


