//
//  EAButton.swift
//  noteor
//
//  Created by Emir AKSU on 17.02.2024.
//

import UIKit

class EAButton: UIButton {

    init(title : String, backgroundColor : UIColor,cornerRadius : CGFloat){
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        
        self.translatesAutoresizingMaskIntoConstraints = false
      
    }
    
}
