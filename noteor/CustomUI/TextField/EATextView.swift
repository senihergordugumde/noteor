//
//  EATextView.swift
//  noteor
//
//  Created by Emir AKSU on 17.02.2024.
//

import UIKit

class EATextView: UITextView {

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(placeholder : String){
        super.init(frame: CGRect.zero, textContainer: nil)
        
        self.text = placeholder
        
        configure()
        
    }
    
    
    private func configure(){
        self.textAlignment = .center
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.systemGray4.cgColor
        self.tintColor = .systemGreen
        translatesAutoresizingMaskIntoConstraints = false
        self.textColor = .label
        
        
    }
}
