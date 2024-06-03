//
//  ChattingRoomViewController.swift
//  TravelMagazine
//
//  Created by 박다현 on 6/2/24.
//

import UIKit

class ChattingRoomViewController: UIViewController {


    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    var listResults:[ChatRoom] = mockChatList{
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TRAVEL TALK"
        configureTableView()
        setupSearchController()
    }
    
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "친구 이름을 검색해보세요"
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .no
    }
    
    func configureTableView(){
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        let xib01 = UINib(nibName: PersonalChatListTableViewCell.identifier, bundle: nil)
        tableView.register(xib01, forCellReuseIdentifier: PersonalChatListTableViewCell.identifier)
        let xib02 = UINib(nibName: GroupChatListTableViewCell.identifier, bundle: nil)
        tableView.register(xib02, forCellReuseIdentifier: GroupChatListTableViewCell.identifier)
        
    }
    

}

extension ChattingRoomViewController:UISearchBarDelegate, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        var searchItems:[ChatRoom] = []
        
        guard let searchText = searchController.searchBar.text else { return }
        if !searchText.trimmingCharacters(in: .whitespaces).isEmpty{
            mockChatList.forEach {  chat in
                if chat.chatroomName.lowercased().contains(searchText.lowercased()){
                    searchItems.append(chat)
                }
            }
            listResults = searchItems

        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        listResults = mockChatList
        searchBar.text = ""
        view.endEditing(true)
    }
}


// MARK: - UITableView
extension ChattingRoomViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return listResults.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if listResults[indexPath.row].chatroomImage.count > 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: GroupChatListTableViewCell.identifier, for: indexPath) as! GroupChatListTableViewCell
            cell.configureData(listResults[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: PersonalChatListTableViewCell.identifier, for: indexPath) as! PersonalChatListTableViewCell
            cell.configureData(listResults[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: ChatViewController.identifier) as! ChatViewController
        vc.dialogueData = listResults[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
