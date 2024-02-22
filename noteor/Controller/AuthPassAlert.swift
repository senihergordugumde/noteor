//
//  AuthPassAlert.swift
//  noteor
//
//  Created by Emir AKSU on 20.02.2024.
//

import UIKit

class AuthPassAlert: UIViewController {
    var onAuthenticationSuccess: (() -> Void)?

    let alertContainer = UIView()
    let alertTitle = EATitle(textAlignment: .center, fontSize: 16)
    let textField = EATextField(placeholder: "Your Password", isSecureTextEntry: true, textAlignment: .center)
    let alertLabel = EALabel(textAlignment: .center, fontSize: 12)
    let alertButton = EAButton(title: "Unlock", backgroundColor: .systemGreen, cornerRadius: 10)
    let cancelButton = EAButton(title: "Cancel", backgroundColor: .systemRed, cornerRadius: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()


        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)


    }
    
    init(alertTitle : String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle.text = alertTitle
        

        alertView()
        configureAlertTitle()
        configureAlertTextField()
        configureAlertButton()
        configureCancelButton()
    }
    
    
    
    
    private func alertView(){
        view.addSubview(alertContainer)
        
        alertContainer.backgroundColor = .systemBackground
        alertContainer.layer.borderWidth = 2
        alertContainer.layer.borderColor = UIColor.white.cgColor
        alertContainer.layer.cornerRadius = 15
        alertContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            alertContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertContainer.widthAnchor.constraint(equalToConstant: 300),
            alertContainer.heightAnchor.constraint(equalToConstant: 200)
        
        
        
        ])
        
        
    }
    
    private func configureAlertTitle(){
        
        alertContainer.addSubview(alertTitle)
        
        NSLayoutConstraint.activate([
        
            alertTitle.topAnchor.constraint(equalTo: alertContainer.topAnchor, constant: 25),
            alertTitle.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor),
            alertTitle.widthAnchor.constraint(equalToConstant: 100),
            alertTitle.heightAnchor.constraint(equalToConstant: 20)
            
        
        ])
        
        
    }
    
    private func configureAlertTextField(){
        
        alertContainer.addSubview(textField)
        
        NSLayoutConstraint.activate([
        
            textField.topAnchor.constraint(equalTo: alertTitle.topAnchor, constant: 35),
            textField.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: 220),
            textField.heightAnchor.constraint(equalToConstant: 60)
            
        
        ])
        
        alertLabel.numberOfLines = 10
        
    }
    
    
    private func configureAlertButton(){
        
        alertContainer.addSubview(alertButton)
        
        NSLayoutConstraint.activate([
        
            alertButton.bottomAnchor.constraint(equalTo: alertContainer.bottomAnchor, constant: -35),
            alertButton.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            alertButton.widthAnchor.constraint(equalToConstant: 100),
            alertButton.heightAnchor.constraint(equalToConstant: 30)
            
        
        ])
        
       
        alertButton.addTarget(self, action: #selector(okButton), for: .touchUpInside)

    }
    
    private func configureCancelButton(){
        alertContainer.addSubview(cancelButton)
        NSLayoutConstraint.activate([
        
            cancelButton.bottomAnchor.constraint(equalTo: alertContainer.bottomAnchor, constant: -35),
            cancelButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: 100),
            cancelButton.heightAnchor.constraint(equalToConstant: 30)
            
        
        ])
        
        
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
    }
    
    
    @objc func okButton(){
        
        if "123" == "123" {
            dismiss(animated: true) {
                self.onAuthenticationSuccess?()
            }
        } else {
            // Şifre yanlış uyarısı verebilirsiniz.
            self.dismiss(animated: true)
        }
        
    }
    
    @objc func cancelButtonClicked(){
        
        self.dismiss(animated: true)
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
