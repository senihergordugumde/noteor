//
//  AlertVC.swift
//  noteor
//
//  Created by Emir AKSU on 19.02.2024.
//

import UIKit

class AlertVC: UIViewController {
    
    let alertContainer = UIView()
    let alertTitle = EATitle(textAlignment: .center, fontSize: 16)
    let alertLabel = EALabel(textAlignment: .center, fontSize: 12)
    let alertButton = EAButton(title: "OK", backgroundColor: .systemGreen, cornerRadius: 15)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)


    }
    
    init(alertTitle : String, alertLabel : String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle.text = alertTitle
        self.alertLabel.text = alertLabel

        alertView()
        configureAlertTitle()
        configureAlertLabel()
        configureAlertButton()
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
            alertTitle.widthAnchor.constraint(equalToConstant: 140),
            alertTitle.heightAnchor.constraint(equalToConstant: 40)
            
        
        ])
        
        alertTitle.numberOfLines = 2
    }
    
    private func configureAlertLabel(){
        
        alertContainer.addSubview(alertLabel)
        
        NSLayoutConstraint.activate([
        
            alertLabel.topAnchor.constraint(equalTo: alertTitle.topAnchor, constant: 35),
            alertLabel.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor),
            alertLabel.widthAnchor.constraint(equalToConstant: 220),
            alertLabel.heightAnchor.constraint(equalToConstant: 60)
            
        
        ])
        
        alertLabel.numberOfLines = 10
        
    }
    
    
    private func configureAlertButton(){
        
        alertContainer.addSubview(alertButton)
        
        NSLayoutConstraint.activate([
        
            alertButton.bottomAnchor.constraint(equalTo: alertContainer.bottomAnchor, constant: -35),
            alertButton.centerXAnchor.constraint(equalTo: alertContainer.centerXAnchor),
            alertButton.widthAnchor.constraint(equalToConstant: 100),
            alertButton.heightAnchor.constraint(equalToConstant: 30)
            
        
        ])
        
       
        alertButton.addTarget(self, action: #selector(okClicked), for: .touchUpInside)
   
        
    }
    
    
    
    @objc func okClicked(){
        
        self.dismiss(animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

   
}
