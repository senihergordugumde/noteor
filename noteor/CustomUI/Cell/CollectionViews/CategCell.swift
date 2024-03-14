//
//  CategCell.swift
//  noteor
//
//  Created by Emir AKSU on 4.03.2024.
//

import UIKit

class CategCell: UICollectionViewCell {
    static let id = "CategCell"

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        
        
        
        self.layer.cornerRadius = 10
        
    }
    
    
    private func configureImage(image : String){
        
        let imageView = UIImageView(image: UIImage(named:image))
        let plus = UIImageView(image: UIImage(named: "plus"))
        let categText = EATitle(textAlignment: .center, fontSize: 12)
        addSubview(imageView)
        addSubview(plus)
        addSubview(categText)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        plus.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        NSLayoutConstraint.activate([
        
            plus.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            plus.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            plus.widthAnchor.constraint(equalToConstant: 20),
            plus.heightAnchor.constraint(equalToConstant: 20),

        ])
        NSLayoutConstraint.activate([
        
            categText.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            categText.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            categText.widthAnchor.constraint(equalToConstant: 100),
            categText.heightAnchor.constraint(equalToConstant: 16)
            
        ])
        
        categText.text = image
        backgroundColor = UIColor(named: image)
        
        
    }
    
    func set (categ : String){
   
        configureImage(image: categ)
        
    }
}
