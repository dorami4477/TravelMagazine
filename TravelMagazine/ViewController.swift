//
//  ViewController.swift
//  TravelMagazine
//
//  Created by 박다현 on 5/25/24.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let dataManger = MagazineInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.rowHeight = tableView.estimatedRowHeight
    }


}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManger.magazine.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        let data = dataManger.magazine[indexPath.row]
        cell.titleLabel.text = data.title
        cell.subTitleLabel.text = data.subtitle
        cell.dateLabel.text = data.newDate
        
        cell.titleLabel.font = .boldSystemFont(ofSize: 25)
        cell.titleLabel.numberOfLines = 0
        cell.subTitleLabel.font = .boldSystemFont(ofSize: 16)
        cell.subTitleLabel.textColor = .gray
        cell.dateLabel.font = .systemFont(ofSize: 13)
        cell.dateLabel.textColor = .gray
        cell.dateLabel.textAlignment = .right
        cell.mainImageView.layer.cornerRadius = 10
        cell.mainImageView.clipsToBounds = true
        cell.mainImageView.contentMode = .scaleAspectFill
        
        let url = URL(string: data.photo_image)
            cell.mainImageView.kf.setImage(with: url)
        if cell.mainImageView.kf.setImage(with: url) != nil{
            cell.mainImageView.image = UIImage(systemName: "questionmark")
            cell.mainImageView.backgroundColor = .lightGray
        }
    
        return cell
    }
    
    
}
