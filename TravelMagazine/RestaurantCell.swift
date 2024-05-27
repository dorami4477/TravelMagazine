//
//  RestaurantCell.swift
//  TravelMagazine
//
//  Created by 박다현 on 5/25/24.
//

import UIKit

class RestaurantCell: UITableViewCell {

    @IBOutlet var mainImageView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureData(data:Restaurant){
        nameLabel.text = data.name
        addressLabel.text = data.address
        categoryLabel.text = data.category
        phoneLabel.text = data.phoneNumber
        priceLabel.text = "\(data.price)원"
        
        let url = URL(string: data.image)
        mainImageView.kf.setImage(with: url)
    }
    
    func configureUI(){
        mainImageView.layer.cornerRadius = 10
        mainImageView.contentMode = .scaleAspectFill
        categoryLabel.layer.cornerRadius = 5
        categoryLabel.clipsToBounds = true
        
    }
    
    

}
