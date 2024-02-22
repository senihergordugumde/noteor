//
//  EATitle.swift
//  noteor
//
//  Created by Emir AKSU on 17.02.2024.
//

import UIKit

class EATitle: UILabel {

  
    init(textAlignment : NSTextAlignment,fontSize : CGFloat){
        super.init(frame: .zero)
        
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    
    
    
    private func configure(){
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        numberOfLines = 2
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
