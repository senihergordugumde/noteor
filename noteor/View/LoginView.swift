//
//  LoginView.swift
//  noteor
//
//  Created by Emir AKSU on 25.04.2024.
//

import UIKit
import GoogleSignIn
import AuthenticationServices
protocol LoginViewDelegate : AnyObject {
    func signInClicked()
    func googleSignInClicked()
    func registerClicked()
    func appleSignInClicked()
}

class LoginView: UIView {
    
    weak var delegate : LoginViewDelegate?
    
    let signIn = GIDSignInButton()
    
    
    var yellowTopImage : UIImageView={
        let imageView = UIImageView(image: UIImage(named: "back-blur"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
  
    var redTopImage : UIImageView={
        let imageView = UIImageView(image: UIImage(named: "red-blur"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
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
    

    let signInButton : EAButton = {
        let signInButton = EAButton(title: "Sign In", backgroundColor: UIColor(named: "Pink")!, cornerRadius: 0)
       
        signInButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        return signInButton
    }()
    
    let registerButton : EAButton = {
        let registerButton = EAButton(title: "Dont you have account? Register.", backgroundColor: .clear, cornerRadius: 0)
        
        registerButton.setTitleColor(.secondaryLabel, for: .normal)
        registerButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return registerButton
    }()
    
    let forgetPassword : EAButton = {
        let forgetPassword = EAButton(title: "Forget Password?", backgroundColor: .clear, cornerRadius: 0)
        forgetPassword.setTitleColor(.secondaryLabel, for: .normal)
        return forgetPassword
    }()
    
    let welcomeBackTitle : EATitle = {
        let welcomeBackTitle = EATitle(textAlignment: .center, fontSize: 24)
        welcomeBackTitle.text = "Welcome Back"
        
        return welcomeBackTitle
    }()
    
    lazy var appleSignInButton : ASAuthorizationAppleIDButton = {
        let appleSignInButton = ASAuthorizationAppleIDButton()
        appleSignInButton.addTarget(self, action: #selector(appleSignInClicked), for: .touchUpInside)
        return appleSignInButton
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
        loginInputStackView.addArrangedSubview(mailTextField)
        loginInputStackView.addArrangedSubview(passwordTextField)
        loginInputStackView.addArrangedSubview(signInButton)
        loginInputStackView.addArrangedSubview(signIn)
        loginInputStackView.addArrangedSubview(appleSignInButton)
     
        
        NSLayoutConstraint.activate([
        
            loginInputStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginInputStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            loginInputStackView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20),
            loginInputStackView.heightAnchor.constraint(equalToConstant: 330)
        
        ])
        
      
        signIn.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(forgetPassword)
        
        NSLayoutConstraint.activate([
        
            forgetPassword.trailingAnchor.constraint(equalTo: loginInputStackView.trailingAnchor),
            forgetPassword.topAnchor.constraint(equalTo: loginInputStackView.bottomAnchor, constant: 15)
        
        ])
        
        addSubview(registerButton)

        NSLayoutConstraint.activate([
        
            registerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            registerButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
       /* NSLayoutConstraint.activate([
        
            signIn.centerXAnchor.constraint(equalTo: centerXAnchor) ,
            signIn.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            signIn.widthAnchor.constraint(equalToConstant: 250),
            signIn.heightAnchor.constraint(equalToConstant: 80)
            
        
        
        ]) */
        
        signIn.addTarget(self, action: #selector(googleSignInClicked), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerClicked), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInClicked), for: .touchUpInside)
        
    }
    
    @objc func signInClicked(){
        self.delegate?.signInClicked()
    }
    
    @objc func googleSignInClicked(){
        self.delegate?.googleSignInClicked()
    }
    
    @objc func registerClicked(){
        self.delegate?.registerClicked()
    }
    
    @objc func appleSignInClicked(){
        self.delegate?.appleSignInClicked()
    }
}
