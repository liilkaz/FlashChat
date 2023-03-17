//
//  RegisterViewController.swift
//  FlashChat
//
//  Created by Лилия Феодотова on 13.03.2023.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
        
    let emailView: TextFieldView = {
        let view = TextFieldView()
        view.customTextField.placeholder = "Email"
        view.customTextField.keyboardType = .emailAddress
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
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(UIColor(named: K.BrandColors.blue), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        regLogButton.addTarget(self, action: #selector(registerToChat), for: .touchUpInside)
    }
    
    @objc func registerToChat(){
        let chatScreen = ChatViewController()
        if let email = emailView.customTextField.text, let password = passwordView.customTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    var errorMessage = ""
                    switch e.localizedDescription{
                    case "The email address is badly formatted.":
                        errorMessage = "Адрес электронной почты плохо отформатирован."
                    case "An email address must be provided.":
                        errorMessage = "Необходимо указать адрес электронной почты."
                    case "The password must be 6 characters long or more.":
                        errorMessage = "Длина пароля должна составлять не менее 6 символов."
                    default:
                        errorMessage = "Проверьте введенные данные"
                    }
                    let alert = UIAlertController(title: "Ошибка", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else{
                    self.navigationController?.pushViewController(chatScreen, animated: true)
                }
            }
        }
    }
    
    func setupView(){
        view.backgroundColor = UIColor(named: "BrandLightBlue")
        view.addSubview(emailView)
        view.addSubview(passwordView)
        view.addSubview(regLogButton)
        navigationController?.navigationBar.tintColor = UIColor(named: K.BrandColors.blue)
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
