//
//  UserChatTableViewCell.swift
//  TravelMagazine
//
//  Created by 박다현 on 6/3/24.
//

import UIKit

class UserChatTableViewCell: UITableViewCell {

    @IBOutlet var dialogueLabel: BaseLabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var dateLineLabel: UILabel!
    @IBOutlet var dateLineView: UIView!
    
    var line:Bool = false{
        didSet{
            if line{
              //  print(chatList?.dayDate)
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
        dialogueLabel.backgroundColor = UIColor(red: 1.00, green: 0.93, blue: 0.74, alpha: 1.00)
        dialogueLabel.font = .systemFont(ofSize: 14)
        dateLabel.setUILabel(size: 12, weight: .regular, color: .gray, numberOfLines: 1)
        dialogueLabel.layer.borderColor = UIColor(red: 0.97, green: 0.86, blue: 0.56, alpha: 1.00).cgColor
        dialogueLabel.layer.borderWidth = 1
        dialogueLabel.layer.cornerRadius = 10
        dialogueLabel.clipsToBounds = true
        
        dateLineLabel.font = .systemFont(ofSize: 11)
        dateLineLabel.backgroundColor = .white
        dateLineLabel.textColor = .clear
    }
    
}
