//
//  EALabel.swift
//  noteor
//
//  Created by Emir AKSU on 17.02.2024.
//

import UIKit

class EALabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(textAlignment : NSTextAlignment, fontSize : CGFloat){
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    
    
    private func configure(){
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byWordWrapping
        numberOfLines = 10
        translatesAutoresizingMaskIntoConstraints = false
        
    }

}
