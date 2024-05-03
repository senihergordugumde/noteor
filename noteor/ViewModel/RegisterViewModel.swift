//
//  RegisterViewModel.swift
//  noteor
//
//  Created by Emir AKSU on 28.04.2024.
//

import Foundation

protocol RegisterViewModelDelegate : AnyObject{
    func registerSucces()
    func errorMessage(alertTitle : String, alertText : String)
}

class RegisterViewModel {
    
    weak var delegate : RegisterViewModelDelegate?
    let authService : AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    
    func registerUser(email : String, password: String, passwordAgain: String, name : String){
        authService.register(email: email, password: password,  name: name, photoURL:  " ") { result in
            
            guard password == passwordAgain else {
                self.delegate?.errorMessage(alertTitle: "Password Error", alertText: "Your password not same")
                return
            }
            
            switch result {
            case .success(_):
                self.delegate?.registerSucces()
                print("kayıt başarılı")
            case.failure(let error):
                self.delegate?.errorMessage(alertTitle: "Error", alertText: "Register failed.")
            }
            
            
        }
    }
    
}
