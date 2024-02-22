//
//  EAView.swift
//  noteor
//
//  Created by Emir AKSU on 17.02.2024.
//

import UIKit

class EAView: UIView {

    init( backgroundColor : UIColor, cornerRadius : CGFloat ){
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        
    }
    
    
    private func configure(){
        
        
        self.translatesAutoresizingMaskIntoConstraints = false
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
