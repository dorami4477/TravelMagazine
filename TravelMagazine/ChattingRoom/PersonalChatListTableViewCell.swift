//
//  PersonalChatListTableViewCell.swift
//  TravelMagazine
//
//  Created by 박다현 on 6/2/24.
//

import UIKit

class PersonalChatListTableViewCell: UITableViewCell {

    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var chatRoomNameLabel: UILabel!
    @IBOutlet var chatFristLineLabel: UILabel!
    @IBOutlet var DateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureData(_ data:ChatRoom){
        if let image = data.chatroomImage.first{
            mainImageView.image = UIImage(named: image)
        }
        chatRoomNameLabel.text = data.chatroomName
        chatFristLineLabel.text = data.chatList.last?.message
        guard let date = data.chatList.last?.date else { return }
        DateLabel.text = stringConvertToDateTime(date: date)
    }
    
    func configureUI(){
        mainImageView.roundCorneredImage(cornerSize: mainImageView.frame.width / 2, contentMode: .scaleAspectFill)
        chatRoomNameLabel.setUILabel(size: 15, weight: .bold, color: .black, numberOfLines: 1)
        chatFristLineLabel.setUILabel(size: 13, weight: .regular, color: .darkGray, numberOfLines: 1)
        DateLabel.setUILabel(size: 12, weight: .regular, color: .gray, numberOfLines: 1)
    }
    
    //날짜 형식 변환
    func stringConvertToDateTime(date:String) -> String {
        let stringFormat = "yyyy-MM-dd HH:mm"
        let formatter = DateFormatter()
        formatter.dateFormat = stringFormat
        formatter.locale = Locale(identifier: "ko")
        guard let tempDate = formatter.date(from: date) else {
            return ""
        }
        formatter.dateFormat = "yy.MM.dd"
        
        return formatter.string(from: tempDate)
    }

}
