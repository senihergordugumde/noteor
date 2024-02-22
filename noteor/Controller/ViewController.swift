//
//  ViewController.swift
//  noteor
//
//  Created by Emir AKSU on 17.02.2024.
//

import UIKit
import FirebaseAuth
class ViewController: UIViewController {
    
    let username = EATextField(placeholder: "Username", isSecureTextEntry: false, textAlignment: .center)
    let password = EATextField(placeholder: "Password", isSecureTextEntry: true, textAlignment: .center)
    let signIn = EAButton(title: "SignIn", backgroundColor: .systemGray4,cornerRadius: 10)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureUsername()
        configurePassword()
        configureSignIn()
    }

    
    
   
    
    private func configureUsername(){
        
        view.addSubview(username)
        NSLayoutConstraint.activate([
        
            username.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
            
            username.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            username.widthAnchor.constraint(equalToConstant: 300),
            username.heightAnchor.constraint(equalToConstant: 50)
        
        
        ])
        
        
    }
    
    
    
    private func configurePassword(){
        
        view.addSubview(password)
        NSLayoutConstraint.activate([
        
            password.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 50),
            
            password.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            password.widthAnchor.constraint(equalToConstant: 300),
            password.heightAnchor.constraint(equalToConstant: 50)
        
        
        ])
        
        
    }
    
    private func configureSignIn(){
        
        view.addSubview(signIn)
        NSLayoutConstraint.activate([
        
            signIn.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 50),
            signIn.trailingAnchor.constraint(equalTo: password.trailingAnchor),
            signIn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 200),
            signIn.heightAnchor.constraint(equalToConstant: 30)
            
        
        
        ])
        
        signIn.addTarget(self, action: #selector(signInClicked), for: .touchUpInside)
        
    }
    
    
    
    @objc func signInClicked(){
        
        Auth.auth().signIn(withEmail: username.text!, password: password.text!) { result, error in
            
            
            if error != nil{
                self.makeEAAlert(alertTitle: "Error", alertLabel: "\(error!.localizedDescription) 😭")
                print(error?.localizedDescription)
            }else{
                
                let nav = UINavigationController(rootViewController: SceneDelegate().createTabbar())
                nav.modalPresentationStyle = .overFullScreen
                self.present(nav, animated: true)
              
                
                
            }
            
        }

    }
    
}

