//
//  TextFieldView.swift
//  FlashChat
//
//  Created by Лилия Феодотова on 13.03.2023.
//

import UIKit

class TextFieldView: UIView {
    
    let imageTextField: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "textField")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let customTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(named: K.BrandColors.blue)
        textField.font = .systemFont(ofSize: 25)
        textField.minimumFontSize = 17
        textField.textAlignment = .center
        textField.contentHorizontalAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.contentMode = .scaleToFill
        textField.isEnabled = true
        textField.isUserInteractionEnabled = true
        textField.adjustsFontSizeToFitWidth = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        addSubview(imageTextField)
        addSubview(customTextField)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 177),
            
            imageTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            imageTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            imageTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            customTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            customTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -82),
            customTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 48),
            customTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -48),
        ])
    }
    
}
