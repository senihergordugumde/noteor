//
//  ColorCell.swift
//  noteor
//
//  Created by Emir AKSU on 17.02.2024.
//

import UIKit

class ColorCell: UICollectionViewCell {
    
    
    static let id = "ColorCell"

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        
        self.layer.cornerRadius = 20
        self.backgroundColor = .blue
    }
}
