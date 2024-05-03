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

import AuthenticationServices
class LoginVC: UIViewController, LoginViewDelegate, LoginViewModelDelegate{
    var currentNonce : String?
    func appleSignInClicked() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        // Generate nonce for validation after authentication successful
        self.currentNonce = randomNonceString()
        // Set the SHA256 hashed nonce to ASAuthorizationAppleIDRequest
        request.nonce = sha256(currentNonce!)

        // Present Apple authorization form
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func signInClicked() {
        loginViewModel.signIn(email: loginView.mailTextField.text!, password: loginView.passwordTextField.text!)
    }
    
    
    func signInSucces() {
        let nav = UINavigationController(rootViewController: SceneDelegate().createTabbar())
        nav.modalPresentationStyle = .overFullScreen
        self.present(nav, animated: true)
 
    }
    
    
    let loginViewModel : LoginViewModel
    
    func googleSignInClicked() {
        loginViewModel.googleSignIn()

    }
    
    func registerClicked() {
        print("register clicked")
        let authService : AuthService = Authentication()
        let viewModel = RegisterViewModel(authService: authService)
        self.present(RegisterVC(viewModel: viewModel), animated: true)
    }
    
  
    var loginView : LoginView! {
        
        return self.view as? LoginView
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = LoginView()
        dismissKeyboardOnTouch()
        loginViewModel.delegate = self
        loginView.delegate = self
        
        
    }

    
    
    
    init(loginViewModel : LoginViewModel){
        self.loginViewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

        
        
        
        
       


    
}

