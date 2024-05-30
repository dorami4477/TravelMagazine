//
//  RestaurantTableViewController.swift
//  TravelMagazine
//
//  Created by 박다현 on 5/25/24.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var categorys: [UIButton]!
    
    @IBOutlet var selectedAllButton: UIButton!
    
    var selectedCategory:String?
    var selectedCategoryArray:[Restaurant]?
    
    let dataManger = RestaurantList().restaurantArray
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        configureUI()
        configureSearchBar()
        
    }
    func configureUI(){
        let map = UIBarButtonItem(image: UIImage(systemName: "map.fill"), style: .plain, target: self, action: #selector(mapButtonClicked))
        navigationItem.rightBarButtonItem = map
        
        categorys.forEach {
            categoryBG(UIView: $0)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 5
            $0.titleLabel?.font = .boldSystemFont(ofSize: 14)
        }
        
        selectedAllButton.setTitleColor(.black, for: .normal)
    }
    
    func configureSearchBar(){
        searchBar.delegate = self
        searchBar.barTintColor = UIColor.white
        searchBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
    }
    
    @IBAction func selectedAllButtonTapped(_ sender: UIButton) {
        selectedCategory = nil
        selectedCategoryArray = nil
        tableView.reloadData()
    }
    
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        selectedCategory = title
        selectedCategoryArray = dataManger.filter { $0.category == selectedCategory }
        tableView.reloadData()
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
    
    @objc func mapButtonClicked(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        vc.restaurantData = dataManger
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - tableView function
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedCategoryArray != nil{
            return selectedCategoryArray!.count
        }else{
            return dataManger.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
        
        if selectedCategoryArray == nil{
            cell.configureData(data: dataManger[indexPath.row])
            
        }else{
            guard let categoryData = selectedCategoryArray?[indexPath.row] else { return UITableViewCell() }
            cell.configureData(data: categoryData)
            
        }
        categoryBG(UIView:cell.categoryLabel)
        cell.selectionStyle = .none
        return cell
    }
    

}

// MARK: - UISearchBarDelegate
extension RestaurantTableViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var searchItems:[Restaurant] = []

        dataManger.forEach { item in
            if item.name.contains(searchBar.text!) || item.category.contains(searchBar.text!){
                searchItems.append(item)
            }
        }
        print(searchItems)
        selectedCategoryArray = searchItems
        tableView.reloadData()
    }
}
