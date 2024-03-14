//
//  TaskCell.swift
//  noteor
//
//  Created by Emir AKSU on 17.02.2024.
//

import UIKit

class TaskCell: UICollectionViewCell {
    let colorView = UIView()
    
    var action : (() -> Void)?

    let title = EATitle(textAlignment: .left, fontSize: 16)
    let label = EALabel(textAlignment: .left, fontSize: 12)
    let time = UIDatePicker()
    let wood = UIImageView(image: UIImage(named: "wood"))
    let rope = UIImageView(image: UIImage(named: "rope"))
    let rope2 = UIImageView(image: UIImage(named: "rope"))
    let categImage = UIImageView(image: UIImage(named: "food"))
    let titleImage = UIImageView(image: UIImage(named: "titleTag"))
    let descrImage = UIImageView(image: UIImage(named: "description"))
    let categText = EATitle(textAlignment: .center, fontSize: 16)
    static let id = "TaskCell"
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
        
        
    }
    let statusButton = EAButton(title: "", backgroundColor: .clear, cornerRadius: 0)
    private func configure(){
        //MARK: - Cell BG
        configureBackground()
        
        
        backgroundColor = .systemBackground
    
  
        //MARK: - Wood
    
        addSubview(wood)
        wood.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
        
            wood.topAnchor.constraint(equalTo: topAnchor),
            wood.leadingAnchor.constraint(equalTo: leadingAnchor),
            wood.trailingAnchor.constraint(equalTo: trailingAnchor),
            wood.heightAnchor.constraint(equalToConstant: 35),
        ])
        
        
        //MARK: - Ropes
        insertSubview(rope, at: 1)
        insertSubview(rope2, at: 1)
        rope.translatesAutoresizingMaskIntoConstraints = false
        rope2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rope.topAnchor.constraint(equalTo: wood.bottomAnchor, constant:  -30),
            rope.leadingAnchor.constraint(equalTo: wood.leadingAnchor, constant: 0),
            rope.widthAnchor.constraint(equalToConstant: 80),
            rope.heightAnchor.constraint(equalToConstant: 150),
            
            rope2.topAnchor.constraint(equalTo: wood.bottomAnchor, constant:  -30),
            rope2.trailingAnchor.constraint(equalTo: wood.trailingAnchor, constant: 0),
            rope2.widthAnchor.constraint(equalToConstant: 80),
            rope2.heightAnchor.constraint(equalToConstant: 150)
      
        ])
        //MARK: - ColorView
        addSubview(colorView)
        colorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            colorView.topAnchor.constraint(equalTo: wood.bottomAnchor, constant: 50),
            colorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            colorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant:0),
            colorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25)
        
        ])
        colorView.layer.cornerRadius = 30
        
        
        
        
        //MARK: - Title

        colorView.addSubview(title)
        colorView.addSubview(titleImage)
        titleImage.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleImage.topAnchor.constraint(equalTo: colorView.topAnchor, constant: 20),
            titleImage.leadingAnchor.constraint(equalTo: colorView.leadingAnchor, constant: 120),
            titleImage.widthAnchor.constraint(equalToConstant: 50),
            titleImage.heightAnchor.constraint(equalToConstant: 48),
            
            title.centerYAnchor.constraint(equalTo: titleImage.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: titleImage.trailingAnchor, constant: 2),
            title.widthAnchor.constraint(equalToConstant: 100),
            title.heightAnchor.constraint(equalToConstant: 35)
            
            
        
        ])
        
        //MARK: - Categ
        
        colorView.addSubview(categImage)
        colorView.addSubview(categText)
        categImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            categImage.centerYAnchor.constraint(equalTo: colorView.centerYAnchor, constant: -21),
            categImage.leadingAnchor.constraint(equalTo: colorView.leadingAnchor, constant: 20),
            categImage.widthAnchor.constraint(equalToConstant: 75),
            categImage.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        NSLayoutConstraint.activate([
        
        
            categText.centerXAnchor.constraint(equalTo: categImage.centerXAnchor),
            categText.topAnchor.constraint(equalTo: categImage.bottomAnchor, constant: 5),
            categText.widthAnchor.constraint(equalToConstant: 100),
            categText.heightAnchor.constraint(equalToConstant: 20)
        
        ])
        
        //MARK: - Label
        colorView.addSubview(label)
        colorView.addSubview(descrImage)
        descrImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            
            descrImage.bottomAnchor.constraint(equalTo: categText.bottomAnchor),
           
            descrImage.centerXAnchor.constraint(equalTo: titleImage.centerXAnchor),
            descrImage.widthAnchor.constraint(equalToConstant: 31),
            descrImage.heightAnchor.constraint(equalToConstant: 35),
        
            label.centerYAnchor.constraint(equalTo: descrImage.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            label.widthAnchor.constraint(equalToConstant: 100),
            label.heightAnchor.constraint(equalToConstant: 35)
        
        ])
       
        //MARK: - Time

        
        //colorView.addSubview(time)
        
       
       
        //  time.translatesAutoresizingMaskIntoConstraints = false
       
        //  time.datePickerMode = .date
        
        // time.isUserInteractionEnabled = false
        
    
        
        
       

        // NSLayoutConstraint.activate([
        
        //  time.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
        //  time.leadingAnchor.constraint(equalTo: colorView.leadingAnchor),
        //  time.widthAnchor.constraint(equalToConstant: 100),
        // time.heightAnchor.constraint(equalToConstant: 25)
          
        
        
        //])
        //MARK: - Status Button
       
        
  
            
        self.addSubview(statusButton)
        
        
        NSLayoutConstraint.activate([
        
            statusButton.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: -35),
            statusButton.trailingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: -20),
            statusButton.widthAnchor.constraint(equalToConstant: 65),
            statusButton.bottomAnchor.constraint(equalTo: bottomAnchor)

        ])
            
    
        statusButton.addTarget(self, action: #selector(statusButtonClicked), for: .touchUpInside)
       
    }
    
    @objc func statusButtonClicked(){
        
        action?()
        
    }
    
    
    
    
        
    
 
    
    
    
   
    
    
    //MARK: - Background
    
    let redBlur = UIImageView(image: UIImage(named: "red-blur"))
    let yellowBlur = UIImageView(image: UIImage(named: "back-blur"))

    private func configureBackground(){
        insertSubview(redBlur, at: 0)
        redBlur.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            redBlur.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            redBlur.topAnchor.constraint(equalTo: topAnchor, constant:  0),
            redBlur.heightAnchor.constraint(equalToConstant: 200),
            redBlur.widthAnchor.constraint(equalToConstant: 100)
            
        ])
        
        insertSubview(yellowBlur, at: 0)
        yellowBlur.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            yellowBlur.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -20),
            yellowBlur.topAnchor.constraint(equalTo: topAnchor, constant:  0),
            yellowBlur.heightAnchor.constraint(equalToConstant: 100),
            yellowBlur.widthAnchor.constraint(equalToConstant: 100)
            
        ])
        
    }
    
    //MARK: - Set
    
    func set (note : Notes){
        
        
        
        title.text = note.Title
        time.date = note.StartDate
        colorView.backgroundColor = UIColor(named: note.Color)
        categImage.image = UIImage(named: note.Categ)
        categText.text = note.Categ
        
        if note.isCompleted == "doing"{
            statusButton.setImage(UIImage(named: "Doing"), for: .normal)
        }
        
        if note.isCompleted == "done"{
            statusButton.setImage(UIImage(named: "Done"), for: .normal)
        }
        if note.isCompleted == "dont"{
            statusButton.setImage(UIImage(named: "Dont"), for: .normal)
        }
        
        
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
