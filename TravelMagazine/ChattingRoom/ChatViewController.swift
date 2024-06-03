//
//  ChatViewController.swift
//  TravelMagazine
//
//  Created by 박다현 on 6/3/24.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet var dialogueTableView: UITableView!
    @IBOutlet var inputTextView: UITextView!
    
    var dialogueData:ChatRoom?

    
    var stackViewTopConstraint: NSLayoutConstraint!
    let textViewPlaceHolder = "메세지를 입력하세요."
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavi()
        configureTableView()
        configureUI()
       // setupNotification()
        scrollToBottom()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func configureNavi(){
        title = dialogueData?.chatroomName
        let naviAppearance = UINavigationBarAppearance()
        naviAppearance.backgroundColor = .white
        naviAppearance.configureWithOpaqueBackground()
        self.navigationController?.navigationBar.standardAppearance = naviAppearance
    }
    func configureUI(){
        inputTextView.backgroundColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.00)
        inputTextView.layer.cornerRadius = 10
        inputTextView.clipsToBounds = true
        inputTextView.text = textViewPlaceHolder
        inputTextView.textColor = .gray
        inputTextView.delegate = self
    }
    
    func configureTableView(){
        dialogueTableView.delegate = self
        dialogueTableView.dataSource = self
        dialogueTableView.rowHeight = UITableView.automaticDimension
        dialogueTableView.separatorStyle = .none
        
        let xib = UINib(nibName: SpeakerChatTableViewCell.identifier, bundle: nil)
        dialogueTableView.register(xib, forCellReuseIdentifier: SpeakerChatTableViewCell.identifier)
        
        let xib2 = UINib(nibName: UserChatTableViewCell.identifier, bundle: nil)
        dialogueTableView.register(xib2, forCellReuseIdentifier: UserChatTableViewCell.identifier)
        
        
        
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            self.dialogueTableView.scrollToRow(at: [0, self.dialogueData!.chatList.count - 1], at: .bottom, animated: true )
        }
    }
    

    /* 키보드 올라올때, 컨텐츠 올리기 좀 더 연구필요...
    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(moveUpAction), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveDownAction), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func moveUpAction(_ sender: Notification) {
        // 현재 동작하고 있는 이벤트에서 키보드의 frame을 받아옴
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        if view.frame.origin.y == 0 {
            view.frame.origin.y -= keyboardHeight
        }
    }
    
    @objc func moveDownAction() {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }*/

}

extension ChatViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dialogueData!.chatList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if dialogueData?.chatList[indexPath.row].user == .user{
            let cell = dialogueTableView.dequeueReusableCell(withIdentifier: UserChatTableViewCell.identifier, for: indexPath) as! UserChatTableViewCell
            cell.chatList = dialogueData?.chatList[indexPath.row]
            cell.selectionStyle = .none
            if indexPath.row > 0{
                if dialogueData?.chatList[indexPath.row].dayDate != dialogueData?.chatList[indexPath.row - 1].dayDate{
                    print("\(indexPath.row)?\(dialogueData!.chatList[indexPath.row].dayDate) : \(indexPath.row - 1)?\(dialogueData!.chatList[indexPath.row - 1].dayDate)")
                    cell.line = true
                }else{
                    cell.line = false
                }
               }
            return cell
        }
        let cell = dialogueTableView.dequeueReusableCell(withIdentifier: SpeakerChatTableViewCell.identifier, for: indexPath) as! SpeakerChatTableViewCell
        cell.chatList = dialogueData?.chatList[indexPath.row]
        cell.selectionStyle = .none
        if indexPath.row > 0{
            if dialogueData?.chatList[indexPath.row].dayDate != dialogueData?.chatList[indexPath.row - 1].dayDate{
                cell.line = true
            }else{
                cell.line = false
            }
           }
        return cell
    }
    
    
}

extension ChatViewController:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray{
            textView.text = nil
            textView.textColor = .black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .lightGray
        }
    }
}
