//
//  RestaurantTableViewController.swift
//  TravelMagazine
//
//  Created by 박다현 on 5/25/24.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    @IBOutlet var categorys: [UIButton]!
    
    
    var selectedCategory:String?
    var selectedCategoryArray:[Restaurant]?
    
    let dataManger = RestaurantList()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    
    func configure(){
        tableView.rowHeight = 150
        categorys.forEach {
            categoryBG(UIView: $0)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 5
            $0.titleLabel?.font = .boldSystemFont(ofSize: 14)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedCategory != nil{
            return selectedCategoryArray!.count
        }else{
            return dataManger.restaurantArray.count
        }
    }
    
    
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        selectedCategory = title
        selectedCategoryArray = dataManger.restaurantArray.filter { $0.category == selectedCategory }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
        
        let data = dataManger.restaurantArray[indexPath.row]
        

        
        if selectedCategory == nil{
            cell.nameLabel.text = data.name
            cell.addressLabel.text = data.address
            cell.categoryLabel.text = data.category
            cell.phoneLabel.text = data.phoneNumber
            cell.priceLabel.text = "\(data.price)원"
            
            let url = URL(string: data.image)
            cell.mainImageView.kf.setImage(with: url)

        }else{
            guard let categoryData = selectedCategoryArray?[indexPath.row] else { return UITableViewCell() }
            cell.nameLabel.text = categoryData.name
            cell.addressLabel.text = categoryData.address
            cell.categoryLabel.text = categoryData.category
            cell.phoneLabel.text = categoryData.phoneNumber
            cell.priceLabel.text = "\(categoryData.price)원"
            
            let url = URL(string: categoryData.image)
            cell.mainImageView.kf.setImage(with: url)
            
        }
        
        cell.mainImageView.layer.cornerRadius = 10
        cell.mainImageView.contentMode = .scaleAspectFill
        cell.categoryLabel.layer.cornerRadius = 5
        cell.categoryLabel.clipsToBounds = true
        categoryBG(UIView:cell.categoryLabel)
        
        return cell
    }
    
    func categoryBG(UIView:UIView){
        var categorytitle:String = ""
        if let element = UIView as? UILabel{
            categorytitle = element.text!
        }else if let element2 = UIView as? UIButton{
            categorytitle = element2.titleLabel!.text!
        }
        
        switch categorytitle{
        case "한식":
            UIView.backgroundColor = .systemOrange
        case "카페":
            UIView.backgroundColor = .systemBrown
        case "분식":
            UIView.backgroundColor = .systemCyan
        case "경양식":
            UIView.backgroundColor = .systemMint
        case "양식":
            UIView.backgroundColor = .systemTeal
        case "일식":
            UIView.backgroundColor = .systemGreen
        default:
            UIView.backgroundColor = .systemBlue
        }
    }
}
