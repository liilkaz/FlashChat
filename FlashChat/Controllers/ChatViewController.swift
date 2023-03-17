//
//  ChatViewController.swift
//  FlashChat
//
//  Created by Лилия Феодотова on 13.03.2023.
//

import UIKit
import AVFoundation
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    var player: AVAudioPlayer!
    let chatView = ChatView()
    let db = Firestore.firestore()
    var messages: [Message] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        chatView.messageTextField.delegate = self
        setupView()
        setConstraints()
        navigationBarSetup()
        loadMessages()
    }
    
    func loadMessages(){
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener() { [self]
            (querySnapshot, err) in
            self.messages = []
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let snapshotDoc = querySnapshot?.documents{
                    for document in snapshotDoc {
                        let data = document.data()
                        if let sender = data[K.FStore.senderField] as? String, let message = data[K.FStore.bodyField] as? String{
                            let newMessage = Message(sender: sender, body: message)
                            self.messages.append(newMessage)
                            DispatchQueue.main.async {
                                if self.messages[self.messages.count-1].sender != Auth.auth().currentUser?.email{
                                    self.playSound(name: "newMessage")
                                }
                                self.chatView.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.chatView.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func setupView(){
        view.backgroundColor = UIColor(named: K.BrandColors.purple)
        view.addSubview(chatView)
        chatView.tableView.dataSource = self
        title = K.nameApp
        chatView.sendButton.isEnabled = false
        chatView.sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
    }
    
    func navigationBarSetup(){
        navigationController?.navigationBar.tintColor = UIColor(named: K.BrandColors.lightPurple)
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(logOutPressed))
    }
    
    @objc func logOutPressed(){
        do {
          try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    @objc func sendMessage(){
        if let messageBody = chatView.messageTextField.text, let messageSender = Auth.auth().currentUser?.email{
            if !messageBody.isEmpty{
                db.collection(K.FStore.collectionName).addDocument(data: [
                    K.FStore.senderField: messageSender,
                    K.FStore.bodyField: messageBody,
                    K.FStore.dateField: Date().timeIntervalSince1970
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        self.playSound(name: "send")
                        DispatchQueue.main.async {
                            self.chatView.messageTextField.text = ""
                        }
                    }
                }
            }
        }
    }
    
    func playSound(name: String) {
            let url = Bundle.main.url(forResource: name, withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            chatView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chatView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            chatView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            chatView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

//MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MessageViewCell
        cell?.message.text = message.body
        cell?.selectionStyle = .none
        cell?.login.text = message.sender
        
        if message.sender == Auth.auth().currentUser?.email {
            cell?.youAvatar.isHidden = true
            cell?.myAvatar.isHidden = false
            cell?.message.textAlignment = .right
            cell?.bubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell?.message.textColor = UIColor(named: K.BrandColors.purple)
            cell?.login.textColor = UIColor(named: K.BrandColors.purple)
            cell?.login.textAlignment = .left
            
        } else{
            cell?.myAvatar.isHidden = true
            cell?.youAvatar.isHidden = false
            cell?.bubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell?.message.textAlignment = .left
            cell?.message.textColor = UIColor(named: K.BrandColors.lightPurple)
            cell?.login.textColor = UIColor(named: K.BrandColors.lightPurple)
            cell?.login.textAlignment = .right
        }
        return cell!
    }
}

//MARK: - UITextViewDelegate

extension ChatViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        chatView.placeholderLabel.isHidden = true
        chatView.sendButton.isEnabled = false
    }
    
    func textViewDidChange(_ textView: UITextView) {
        chatView.placeholderLabel.isHidden = !textView.text.isEmpty
        chatView.sendButton.isEnabled = !textView.text.isEmpty
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        chatView.placeholderLabel.isHidden = !textView.text.isEmpty
        chatView.sendButton.isEnabled = !textView.text.isEmpty
    }
}

