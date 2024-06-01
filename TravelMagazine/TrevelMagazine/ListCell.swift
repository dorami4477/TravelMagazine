//
//  ListCell.swift
//  TravelMagazine
//
//  Created by 박다현 on 5/25/24.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureUI(){
        titleLabel.setUILabel(size: 25, weight: .bold, color: .black, numberOfLines: 0)
        subTitleLabel.setUILabel(size: 16, weight: .bold, color: .gray, numberOfLines: 1)
        dateLabel.setUILabel(size: 13, weight: .regular, color: .gray, numberOfLines: 1)
        dateLabel.textAlignment = .right
        mainImageView.roundCorneredImage(cornerSize: 10, contentMode: .scaleAspectFill)

    }
    
    func configureData(data:Magazine){
        titleLabel.text = data.title
        subTitleLabel.text = data.subtitle
        dateLabel.text = data.newDate
        let url = URL(string: data.photo_image)
            mainImageView.kf.setImage(with: url)
        if mainImageView.kf.setImage(with: url) != nil{
            mainImageView.image = UIImage(systemName: "questionmark")
            mainImageView.backgroundColor = .lightGray
        }
    }
    
    



}
