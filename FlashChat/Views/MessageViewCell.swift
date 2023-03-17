//
//  MessageViewCell.swift
//  FlashChat
//
//  Created by Лилия Феодотова on 14.03.2023.
//

import UIKit

class MessageViewCell: UITableViewCell {
    
    let stackHorizontal: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .top
        stack.axis = .horizontal
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let stackVertical: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let bubble: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let login: UILabel = {
        let textLabel = UILabel()
        textLabel.font = .systemFont(ofSize: 12, weight: .black)
        textLabel.textColor = UIColor(named: K.BrandColors.purple)
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 0
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    let message: UILabel = {
        let textLabel = UILabel()
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .right
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    let myAvatar: UIImageView = {
        let image = UIImageView()
        image.isHidden = true
        image.image = UIImage(named: K.myAvatar)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let youAvatar: UIImageView = {
        let image = UIImageView()
        image.isHidden = true
        image.image = UIImage(named: K.youAvatar)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setConstraints()
    }
    
    func setupView(){
        addSubview(stackHorizontal)
        stackHorizontal.addArrangedSubview(youAvatar)
        stackHorizontal.addArrangedSubview(bubble)
        bubble.addSubview(stackVertical)
        stackVertical.addArrangedSubview(login)
        stackVertical.addArrangedSubview(message)
        stackHorizontal.addArrangedSubview(myAvatar)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            stackHorizontal.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stackHorizontal.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            stackHorizontal.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackHorizontal.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            stackVertical.topAnchor.constraint(equalTo: bubble.topAnchor),
            stackVertical.bottomAnchor.constraint(equalTo: bubble.bottomAnchor, constant: -10),
            stackVertical.leadingAnchor.constraint(equalTo: bubble.leadingAnchor, constant: 10),
            stackVertical.trailingAnchor.constraint(equalTo: bubble.trailingAnchor, constant: -10),
            
            myAvatar.heightAnchor.constraint(equalToConstant: 40),
            myAvatar.widthAnchor.constraint(equalToConstant: 40),
            
            youAvatar.heightAnchor.constraint(equalToConstant: 40),
            youAvatar.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
