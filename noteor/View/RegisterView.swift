//
//  RegisterView.swift
//  noteor
//
//  Created by Emir AKSU on 27.04.2024.
//

import UIKit

protocol RegisterViewDelegate : AnyObject {
    func registerClicked()
}
class RegisterView: UIView {

    weak var delegate : RegisterViewDelegate?
  
   
    let displayNameField : UITextField = {
       
        let displayNameField = EATextField(placeholder: "Your Name", isSecureTextEntry: false, textAlignment: .center)
        displayNameField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        displayNameField.layer.cornerRadius = 0
        displayNameField.layer.borderWidth = 0
        displayNameField.backgroundColor = UIColor(named: "Gray")
        return displayNameField
        
    }()
    
    let mailTextField : UITextField = {
       
        let mailTextField = EATextField(placeholder: "E-mail", isSecureTextEntry: false, textAlignment: .center)
        mailTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        mailTextField.layer.cornerRadius = 0
        mailTextField.layer.borderWidth = 0
        mailTextField.backgroundColor = UIColor(named: "Gray")
        return mailTextField
        
    }()
    
    let passwordTextField : UITextField = {
       
        let passwordTextField = EATextField(placeholder: "Password", isSecureTextEntry: true, textAlignment: .center)
        passwordTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        passwordTextField.layer.cornerRadius = 0

        passwordTextField.layer.borderWidth = 0
        passwordTextField.backgroundColor = UIColor(named: "Gray")
        return passwordTextField
        
    }()
    let againPasswordTextField : UITextField = {
       
        let againPasswordTextField = EATextField(placeholder: "Password", isSecureTextEntry: true, textAlignment: .center)
        againPasswordTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        againPasswordTextField.layer.cornerRadius = 0

        againPasswordTextField.layer.borderWidth = 0
        againPasswordTextField.backgroundColor = UIColor(named: "Gray")
        return againPasswordTextField
        
    }()
   
    let loginInputStackView : UIStackView = {
        let loginInputStackView = UIStackView()
        loginInputStackView.axis = .vertical
        loginInputStackView.spacing = 15
        loginInputStackView.translatesAutoresizingMaskIntoConstraints = false
        loginInputStackView.distribution = .fillEqually
        return loginInputStackView
        
    }()
    
    
   /* lazy var buttonStackView : UIStackView = {
        let buttonStackView = UIStackView(arrangedSubviews: [signInButton,signIn,registerButton])
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 15
        buttonStackView.distribution = .fillEqually
        buttonStackView.alignment = .firstBaseline
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        return buttonStackView
    }() */
    

    let registerButton : EAButton = {
        let registerButton = EAButton(title: "Register", backgroundColor: UIColor(named: "Pink")!, cornerRadius: 0)
        registerButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        return registerButton
    }()
   
    
    let welcomeBackTitle : EATitle = {
        let welcomeBackTitle = EATitle(textAlignment: .center, fontSize: 24)
        welcomeBackTitle.text = "Join Us 😉"
        
        return welcomeBackTitle
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupUI(){
        
       
        backgroundColor = UIColor(named: "DarkGray")
        
        addSubview(loginInputStackView)
        loginInputStackView.addArrangedSubview(welcomeBackTitle)
        loginInputStackView.addArrangedSubview(displayNameField)
        loginInputStackView.addArrangedSubview(mailTextField)
        loginInputStackView.addArrangedSubview(passwordTextField)
        loginInputStackView.addArrangedSubview(againPasswordTextField)
        loginInputStackView.addArrangedSubview(registerButton)
     
        NSLayoutConstraint.activate([
        
            loginInputStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginInputStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            loginInputStackView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20),
            loginInputStackView.heightAnchor.constraint(equalToConstant: 400)
        
        ])
        
      
       
        registerButton.addTarget(self, action: #selector(registerClicked), for: .touchUpInside)
        
    }
   
    @objc func registerClicked(){
        self.delegate?.registerClicked()
    }

}
