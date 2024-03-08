//
//  toDoCell.swift
//  noteor
//
//  Created by Emir AKSU on 6.03.2024.
//

import UIKit


class toDoCell: UITableViewCell {
    
    var action : (() -> Void)?

    
    static let id = "toDoCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        
    }
    
    let arrowImage = UIImageView(image: UIImage(named: "arrow"))
    let textField = EATextField(placeholder: "", isSecureTextEntry: false, textAlignment: .left)
    let deleteButton = EAButton(title: "", backgroundColor: .clear, cornerRadius: 0)
    private func configure(){
        
        self.addSubview(arrowImage)
        self.addSubview(textField)
        self.contentView.addSubview(deleteButton)
        deleteButton.isUserInteractionEnabled = true
        
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        
        textField.leftViewMode = .always
        textField.backgroundColor = .systemGray6
        textField.layer.borderWidth = 0
        

        
        
        NSLayoutConstraint.activate([
            
            arrowImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            arrowImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowImage.widthAnchor.constraint(equalToConstant: 25),
            arrowImage.heightAnchor.constraint(equalToConstant: 25),
            
            
            textField.leadingAnchor.constraint(equalTo: arrowImage.trailingAnchor, constant: 20),
            textField.centerYAnchor.constraint(equalTo: arrowImage.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -5),
            textField.heightAnchor.constraint(equalToConstant: 30),
            
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 25),
            deleteButton.heightAnchor.constraint(equalToConstant: 25)
            
        ])
     
        
        
        
        deleteButton.addTarget(self, action: #selector(didRightButtonClicked), for: .touchUpInside)

    }
    
    func set(task : tasks){
        textField.text = task.taskName
        
        if task.taskStatus{
            deleteButton.setImage(UIImage(named: "checkDetail"), for: .normal)

        }else{
            deleteButton.setImage(UIImage(named: "closeDetail"), for: .normal)

        }
        
      
    }
    
    @objc func didRightButtonClicked(){
        
        action?()
    }
   
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
