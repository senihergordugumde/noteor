//
//  EATextField.swift
//  noteor
//
//  Created by Emir AKSU on 17.02.2024.
//

import UIKit

class EATextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        

    }
   
    
    init(placeholder : String , isSecureTextEntry : Bool,textAlignment : NSTextAlignment){
        super.init(frame:.zero)
        self.isSecureTextEntry = isSecureTextEntry
        self.placeholder = placeholder
        self.textAlignment = textAlignment
        configure()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        
        self.translatesAutoresizingMaskIntoConstraints = false
      
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.systemGray4.cgColor
        self.tintColor = .systemGreen
        
    }


}
