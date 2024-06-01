//
//  PopularCityViewController.swift
//  TravelMagazine
//
//  Created by 박다현 on 5/29/24.
//

import UIKit

class PopularCityViewController: UIViewController {

    @IBOutlet var locationSegmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    let cityInfo = CityInfo().city
    lazy var selectedItems:[City] = cityInfo
    
    var searchStr:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTableView()
    }
    
    //키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func configure(){
        title = "인기도시"
        locationSegmentedControl.setTitle("모두", forSegmentAt: 0)
        locationSegmentedControl.setTitle("국내", forSegmentAt: 1)
        locationSegmentedControl.setTitle("해외", forSegmentAt: 2)
        
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        searchBar.searchBarStyle = .minimal
    }
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: CityCell.identifier, bundle: nil), forCellReuseIdentifier: CityCell.identifier)
        tableView.rowHeight = 130
        tableView.separatorStyle = .none
    }

    
    //세그먼트컨트롤러 액션
    @IBAction func locationChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            selectedItems = cityInfo

        }else if sender.selectedSegmentIndex == 1{
            selectedItems = cityInfo.filter{ $0.domestic_travel }
            
        }else if sender.selectedSegmentIndex == 2{
            selectedItems = cityInfo.filter{ $0.domestic_travel == false }
            
        }
        tableView.reloadData()
    }
    

    
}

// MARK: - UISearchBarDelegate
extension PopularCityViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        var items:[City] = []
        var searchItems:[City] = []
        //공백확인
        if !searchText.trimmingCharacters(in: .whitespaces).isEmpty{
            searchStr = searchText

                if locationSegmentedControl.selectedSegmentIndex == 0{
                    items = cityInfo
                }else if locationSegmentedControl.selectedSegmentIndex == 1{
                    items = cityInfo.filter{ $0.domestic_travel }
                }else if locationSegmentedControl.selectedSegmentIndex == 2{
                    items = cityInfo.filter{ $0.domestic_travel == false }
                }

            items.forEach { item in
                //소문자로 변경하여 검색
                if item.city_name.contains(searchText) || item.city_english_name.lowercased().contains(searchText.lowercased()) ||  item.city_explain.contains(searchText) {
                    searchItems.append(item)
                }
            }
            
            searchBar.text = ""
            selectedItems = searchItems
            view.endEditing(true)
            tableView.reloadData()
            
            
        }else{
            //공백일 경우, 모든 값 리턴
            let alert = UIAlertController(title: "검색어를 입력해주세요.", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default){ _ in
                searchBar.text = ""
                self.selectedItems = self.cityInfo
                self.locationSegmentedControl.selectedSegmentIndex = 0
                self.tableView.reloadData()
            }
            alert.addAction(ok)
            present(alert, animated: true)
            
            
        }

    }
    
}

// MARK: - UITableView
extension PopularCityViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.identifier, for: indexPath) as! CityCell
        cell.configureData(selectedItems[indexPath.row])
        cell.selectionStyle = .none
        if let searchStr{
            cell.changeText(text: searchStr)
        }
        return cell
        
    }
    
    
}
