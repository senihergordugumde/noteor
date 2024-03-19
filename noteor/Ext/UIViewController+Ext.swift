//
//  File.swift
//  noteor
//
//  Created by Emir AKSU on 19.02.2024.
//

import Foundation
import UIKit
import AVFAudio
import Speech

extension UIViewController{
    
    func configureBackground(view : UIView){
        
        var yellowTopImage : UIImageView={
            let imageView = UIImageView(image: UIImage(named: "back-blur"))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            return imageView
        }()
        
        view.insertSubview(yellowTopImage, at: 0)
        NSLayoutConstraint.activate([
            
            yellowTopImage.topAnchor.constraint(equalTo: view.topAnchor, constant: -150),
            yellowTopImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            yellowTopImage.widthAnchor.constraint(equalToConstant: 250),
            yellowTopImage.heightAnchor.constraint(equalToConstant: 200)
            
        ])
        
        
        var redTopImage : UIImageView={
            let imageView = UIImageView(image: UIImage(named: "red-blur"))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            return imageView
        }()
        
        view.insertSubview(redTopImage, at: 0)
        NSLayoutConstraint.activate([
            
            redTopImage.topAnchor.constraint(equalTo: view.topAnchor, constant: -150),
            redTopImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            redTopImage.widthAnchor.constraint(equalToConstant: 250),
            redTopImage.heightAnchor.constraint(equalToConstant: 300)
            
        ])
        
        
        
        var redBottomImage : UIImageView={
            let imageView = UIImageView(image: UIImage(named: "redBottom"))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            return imageView
        }()
        
        view.insertSubview(redBottomImage, at: 0)
        NSLayoutConstraint.activate([
            
            redBottomImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            redBottomImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            redBottomImage.widthAnchor.constraint(equalToConstant: 250),
            redBottomImage.heightAnchor.constraint(equalToConstant: 120)
            
        ])
        
        
    }
    
    func makeEAAlert(alertTitle : String, alertLabel : String){
        DispatchQueue.main.async {
            let alert = AlertVC(alertTitle: alertTitle, alertLabel: alertLabel)
            
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle = .crossDissolve
            
            
            self.present(alert, animated: true)
        }

        
    }
         
         
    
    
    func makeEAAlertTextField(alertTitle : String, completion : @escaping () -> ()) {
        
        DispatchQueue.main.async {
            let alert = AuthPassAlert(alertTitle: alertTitle)
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle = .crossDissolve
            self.present(alert, animated: true)
            
            alert.onAuthenticationSuccess = {
                completion()
            }
            
            
           
        }
        
        
        
        
    }
    
    func dismissKeyboardOnTouch(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
       
    }
    @objc func dismissKeyboard(){
     
        view.endEditing(true)
    }
    
}
