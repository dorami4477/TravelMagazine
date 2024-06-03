//
//  SpeakerTableViewCell.swift
//  TravelMagazine
//
//  Created by 박다현 on 6/3/24.
//

import UIKit

class SpeakerChatTableViewCell: UITableViewCell {

    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var dialogueLabel: BaseLabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var dateLineView: UIView!
    @IBOutlet var dateLineLabel: UILabel!
    
    var line:Bool = false{
        didSet{
            if line{
                dateLineView.backgroundColor = .lightGray
                dateLineLabel.textColor = .lightGray
            }else{
                dateLineView.backgroundColor = .clear
                dateLineLabel.textColor = .clear
            }
        }
    }
    
    var chatList:Chat?{
        didSet{
            if let image = chatList?.user.profileImage{
                mainImageView.image = UIImage(named: image)
            }
            userNameLabel.text = chatList?.user.rawValue
            dialogueLabel.text = chatList?.message
            dateLabel.text = chatList?.timeDate
            dateLineLabel.text = " \(chatList!.dayDate) "
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI(){
        mainImageView.roundCorneredImage(cornerSize: mainImageView.frame.width / 2, contentMode: .scaleAspectFit)
        userNameLabel.font = .systemFont(ofSize: 15)
        dialogueLabel.font = .systemFont(ofSize: 14)
        dateLabel.setUILabel(size: 12, weight: .regular, color: .gray, numberOfLines: 1)
        dialogueLabel.layer.borderColor = UIColor.gray.cgColor
        dialogueLabel.layer.borderWidth = 1
        dialogueLabel.layer.cornerRadius = 10
        
        dateLineLabel.font = .systemFont(ofSize: 11)
        dateLineLabel.backgroundColor = .white
        dateLineLabel.textColor = .clear
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
