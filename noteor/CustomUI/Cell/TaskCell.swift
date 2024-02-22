//
//  TaskCell.swift
//  noteor
//
//  Created by Emir AKSU on 17.02.2024.
//

import UIKit

class TaskCell: UICollectionViewCell {
    
    let colorView = UIView()
    let title = EATitle(textAlignment: .center, fontSize: 16)
    let label = EALabel(textAlignment: .center, fontSize: 12)
    let time = UIDatePicker()
    let hr = UIView()
    static let id = "TaskCell"
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
        
    }
    
    private func configure(){
        
        
        layer.shadowRadius = 6.0
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        
        layer.masksToBounds = false
        
        
        backgroundColor = .secondarySystemBackground
    
        layer.cornerRadius = 10
        
        addSubview(hr)
        addSubview(colorView)
        addSubview(title)
        addSubview(label)
        addSubview(time)
      

        colorView.translatesAutoresizingMaskIntoConstraints = false
        time.translatesAutoresizingMaskIntoConstraints = false
        time.datePickerMode = .date
        
        time.isUserInteractionEnabled = false
        NSLayoutConstraint.activate([
        
            colorView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            colorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            colorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -150),
            colorView.heightAnchor.constraint(equalTo: heightAnchor)
        
        ])
        
        
        NSLayoutConstraint.activate([
        
            title.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            title.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: 5),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            title.heightAnchor.constraint(equalToConstant: 35)
        
        
        ])
        
        
        NSLayoutConstraint.activate([
            
            hr.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 0),
            hr.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: 5),
            hr.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            hr.heightAnchor.constraint(equalToConstant: 1)
        
        ])
        hr.translatesAutoresizingMaskIntoConstraints = false
        hr.backgroundColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            label.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            label.heightAnchor.constraint(equalToConstant: 100)
        
        
        ])
        
        
        NSLayoutConstraint.activate([
        
            time.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            time.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: 5),
            time.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            time.heightAnchor.constraint(equalToConstant: 25)
          
        
        
        ])
        
        
    }
    
    
    func set (note : Notes){
        
        
        
        title.text = note.Title
        
        colorView.backgroundColor = UIColor(named: note.Color)
        
        if note.Lock{
            label.text = "Need Password 🔐"
        }else{
           
            label.text = note.Descr
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
