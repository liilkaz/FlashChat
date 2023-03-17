//
//  ChatView.swift
//  FlashChat
//
//  Created by Лилия Феодотова on 13.03.2023.
//

import UIKit

class ChatView: UIView {

    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.separatorStyle = .none
        table.register(MessageViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Write a message..."
        label.textAlignment = .right
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let messageTextField: UITextView = {
        let textField = UITextView()
        textField.textAlignment = .left
        textField.font = .systemFont(ofSize: 14)
        textField.textColor = UIColor(named: K.BrandColors.purple)
        textField.layer.cornerRadius = 15
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(named: K.BrandColors.lighBlue)
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        addSubview(tableView)
        addSubview(stackView)
        stackView.addArrangedSubview(messageTextField)
        messageTextField.addSubview(placeholderLabel)
        stackView.addArrangedSubview(sendButton)
        stackView.spacing = 20
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            stackView.heightAnchor.constraint(equalToConstant: 60),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            sendButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            messageTextField.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            messageTextField.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            messageTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            
            placeholderLabel.topAnchor.constraint(equalTo: messageTextField.topAnchor, constant: 10),
            placeholderLabel.leadingAnchor.constraint(equalTo: messageTextField.leadingAnchor, constant: 10)

        ])
    }
}
