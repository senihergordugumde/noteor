//
//  ViewController.swift
//  noteor
//
//  Created by Emir AKSU on 17.02.2024.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import FirebaseCore
class ViewController: UIViewController {

    let signIn = GIDSignInButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
     
        configureSignIn()
        configureBackground(view: view)
    }

    
    
    
    
    
    
   
    
    private func configureSignIn(){
        
        view.addSubview(signIn)
        signIn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            signIn.centerXAnchor.constraint(equalTo: view.centerXAnchor) ,
            signIn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            signIn.widthAnchor.constraint(equalToConstant: 250),
            signIn.heightAnchor.constraint(equalToConstant: 80)
            
        
        
        ])
        
        signIn.addTarget(self, action: #selector(signInClicked), for: .touchUpInside)
        
    }
    
    
    
    @objc func signInClicked(){
        
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
          guard error == nil else {
              print(error?.localizedDescription)
              return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
              print(error?.localizedDescription)
              return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

          // ...
            
            
            Auth.auth().signIn(with: credential) { result, error in
                
                
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
    
}

