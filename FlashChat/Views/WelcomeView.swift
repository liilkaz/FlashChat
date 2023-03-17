//
//  WelcomeView.swift
//  FlashChat
//
//  Created by Лилия Феодотова on 13.03.2023.
//

import UIKit

class WelcomeView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(named: K.BrandColors.blue)
        label.font = .systemFont(ofSize: 50, weight: .black)
        label.highlightedTextColor = .black
        label.shadowOffset = .init(width: 0, height: -1)
        label.contentMode = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вход", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemTeal
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Регистрация", for: .normal)
        button.setTitleColor(UIColor(named: K.BrandColors.blue), for: .normal)
        button.backgroundColor = UIColor(named: K.BrandColors.lighBlue)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupView(){
        addSubview(titleLabel)
        addSubview(registerButton)
        addSubview(logInButton)
        
        contentMode = .center
        translatesAutoresizingMaskIntoConstraints = false

    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            logInButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            logInButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            logInButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: 61),
            
            registerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            registerButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 48),
            registerButton.bottomAnchor.constraint(equalTo: logInButton.topAnchor, constant: -8)
        ])
    }
}
