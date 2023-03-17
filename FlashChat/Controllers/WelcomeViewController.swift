//
//  ViewController.swift
//  FlashChat
//
//  Created by Лилия Феодотова on 13.03.2023.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let welcomeView = WelcomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        animation()
        setupView()
        setConstraints()
        navigationBarSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    func animation(){
        var charIndex = 0
        let title = K.nameApp
        for letter in title{
            Timer.scheduledTimer(withTimeInterval: 0.1*Double(charIndex), repeats: false){(timer) in
                self.welcomeView.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
    func setupView(){
        view.backgroundColor = .white
        view.addSubview(welcomeView)
        welcomeView.registerButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        welcomeView.logInButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func navigationBarSetup(){
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 25, weight: .black)]
        navigationController?.navigationBar.tintColor = UIColor(named: K.BrandColors.lightPurple)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = UIColor(named: K.BrandColors.blue)
        navigationItem.backButtonTitle = "Назад"
    }
    
    @objc func buttonTapped(sender: UIButton){
        if sender.titleLabel?.text == "Регистрация"{
            navigationController?.pushViewController(RegisterViewController(), animated: true)
        } else{
            navigationController?.pushViewController(LoginViewController(), animated: true)
        }
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            welcomeView.topAnchor.constraint(equalTo: view.topAnchor),
            welcomeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            welcomeView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            welcomeView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
}

