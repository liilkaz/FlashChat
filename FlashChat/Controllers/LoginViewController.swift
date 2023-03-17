//
//  LoginViewController.swift
//  FlashChat
//
//  Created by Лилия Феодотова on 13.03.2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class LoginViewController: UIViewController {

    let emailView: TextFieldView = {
        let view = TextFieldView()
        view.customTextField.placeholder = "Email"
      return view
    }()
    
    let passwordView: TextFieldView = {
        let view = TextFieldView()
        view.customTextField.placeholder = "Пароль"
        view.customTextField.isSecureTextEntry = true
        return view
    }()
    
    let regLogButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(UIColor(named: K.BrandColors.lighBlue), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        regLogButton.addTarget(self, action: #selector(logInToChat), for: .touchUpInside)
    }
    
    @objc func logInToChat(){
        let chatScreen = ChatViewController()
        if let email = emailView.customTextField.text, let password = passwordView.customTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    let alert = UIAlertController(title: "Ошибка", message: "Неверный email или пароль", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    print(e.localizedDescription)
                } else{
                    self.navigationController?.pushViewController(chatScreen, animated: true)
                }
            }
        }
    }
    
    
    func setupView(){
        view.backgroundColor = UIColor(named: K.BrandColors.blue)
        view.addSubview(emailView)
        view.addSubview(passwordView)
        view.addSubview(regLogButton)
        
        navigationController?.navigationBar.tintColor = UIColor(named: K.BrandColors.lightPurple)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            
            emailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            passwordView.topAnchor.constraint(equalTo: emailView.bottomAnchor, constant: -100),
            passwordView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            passwordView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            regLogButton.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: -60),
            regLogButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            regLogButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
}
