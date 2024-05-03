//
//  RegisterVC.swift
//  noteor
//
//  Created by Emir AKSU on 27.04.2024.
//

import UIKit

class RegisterVC: UIViewController, RegisterViewModelDelegate, RegisterViewDelegate{
    
    func errorMessage(alertTitle: String, alertText: String) {
        self.makeEAAlert(alertTitle: alertTitle, alertLabel: alertText)
    }
    
   
    
    let viewModel : RegisterViewModel

    
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func registerClicked() {
        viewModel.registerUser(email: registerView.mailTextField.text!, password: registerView.passwordTextField.text!, passwordAgain: registerView.againPasswordTextField.text!, name: registerView.displayNameField.text!)
    }
    

    func registerSucces() {
        self.view.endEditing(true)
        self.dismiss(animated: true)
    }
    
    
      var registerView : RegisterView! {
          
          return self.view as? RegisterView
          
      }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = RegisterView()
        registerView.delegate = self
        viewModel.delegate = self
        setKeyboardListening()
        dismissKeyboardOnTouch()

    }
    


}
