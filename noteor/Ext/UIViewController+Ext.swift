//
//  File.swift
//  noteor
//
//  Created by Emir AKSU on 19.02.2024.
//

import Foundation
import UIKit

extension UIViewController{
    
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
   
    
    
}
