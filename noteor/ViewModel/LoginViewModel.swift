//
//  LoginViewModel.swift
//  noteor
//
//  Created by Emir AKSU on 26.04.2024.
//

import Foundation
import FirebaseCore
import GoogleSignIn
import FirebaseAuth

protocol LoginViewModelDelegate : AnyObject {
    func signInSucces()
}

class LoginViewModel{
    
    let Authentication : AuthService
    weak var delegate : LoginViewModelDelegate?
    
    init(Authentication: AuthService) {
        self.Authentication = Authentication
    }
    
    
    func signIn(email : String, password : String){
        Authentication.signIn(email: email, password: password) { result in
            
            switch result {
                
            case .success():
                self.delegate?.signInSucces()
            case .failure(_):
                print("Sign In Failed")
            }
            
            
        }
    }
    
    
    func googleSignIn(){
        
        Authentication.googleSignIn { result in
            switch result {
                
            case .success(let result):
                self.delegate?.signInSucces()
            case .failure(_):
                print("error")
            }
        }
          
    }
    
    
}
