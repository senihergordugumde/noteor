//
//  SureAlertVC.swift
//  noteor
//
//  Created by Emir AKSU on 2.05.2024.
//

import UIKit

class SureAlertVC: UIViewController {
    
    var okClicked: (() -> Void)?

    let alertContainer = UIView()
    let alertTitle = EATitle(textAlignment: .center, fontSize: 16)
    let alertLabel = EALabel(textAlignment: .center, fontSize: 12)
    let alertButton = EAButton(title: "Yes", backgroundColor: .systemGreen, cornerRadius: 10)
    let cancelButton = EAButton(title: "Cancel", backgroundColor: .systemRed, cornerRadius: 10)
    
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
        
        alertTitle.numberOfLines = 2
        
    }
    
    private func configureAlertLabel(){
        alertContainer.addSubview(alertLabel)
        
        NSLayoutConstraint.activate([
        
            alertLabel.topAnchor.constraint(equalTo: alertTitle.bottomAnchor, constant: 35),
            alertLabel.centerXAnchor.constraint(equalTo: alertTitle.centerXAnchor),
            alertLabel.widthAnchor.constraint(equalToConstant: 100),
            alertLabel.heightAnchor.constraint(equalToConstant: 24)
            
        ])
       
    }
    
    private func configureAlertButton(){
        
        alertContainer.addSubview(alertButton)
        
        NSLayoutConstraint.activate([
        
            alertButton.bottomAnchor.constraint(equalTo: alertContainer.bottomAnchor, constant: -35),
            alertButton.leadingAnchor.constraint(equalTo: alertContainer.leadingAnchor,constant: 30),
            alertButton.widthAnchor.constraint(equalToConstant: 100),
            alertButton.heightAnchor.constraint(equalToConstant: 30)
            
        
        ])
        
       
        alertButton.addTarget(self, action: #selector(okButton), for: .touchUpInside)

    }
    
    private func configureCancelButton(){
        alertContainer.addSubview(cancelButton)
        NSLayoutConstraint.activate([
        
            cancelButton.bottomAnchor.constraint(equalTo: alertContainer.bottomAnchor, constant: -35),
            cancelButton.trailingAnchor.constraint(equalTo: alertContainer.trailingAnchor, constant: -35),
            cancelButton.widthAnchor.constraint(equalToConstant: 100),
            cancelButton.heightAnchor.constraint(equalToConstant: 30)
            
        
        ])
        
        
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
    }
    
    
    @objc func okButton(){
        self.okClicked?()
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
