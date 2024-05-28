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
        tableView.rowHeight = UITableView.automaticDimension
    }

}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManger.magazine.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        let data = dataManger.magazine[indexPath.row]
        cell.configureData(data: data)
        return cell
    }

}
