//
//  ProfileView.swift
//  noteor
//
//  Created by Emir AKSU on 26.04.2024.
//

import UIKit

protocol ProfileViewDelegate : AnyObject {
    func logoutClicked()
    func imagePicker()
}


class ProfileView: UIView {

    weak var delegate : ProfileViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private let backgroundView : UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(named: "Gray")
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.layer.cornerRadius = 10
        return backgroundView
    }()
    
    
    private let userImageBackroundView : UIView = {
        let userImageBackroundView = UIView()
        userImageBackroundView.backgroundColor = UIColor(named: "Gray")
        userImageBackroundView.translatesAutoresizingMaskIntoConstraints = false
        userImageBackroundView.layer.cornerRadius = 10
        return userImageBackroundView
    }()
    
     lazy var userImageView : UIImageView = {
        let userImageView = UIImageView()
        userImageView.translatesAutoresizingMaskIntoConstraints = false
         userImageView.backgroundColor = .systemGray3
         userImageView.layer.cornerRadius = 10
         userImageView.clipsToBounds = true
         let gestureRec = UITapGestureRecognizer(target: self, action: #selector(userImageViewClicked))
         userImageView.isUserInteractionEnabled = true
         userImageView.addGestureRecognizer(gestureRec)
         
        return userImageView
    }()
    
    
    let taskTitle = EATitle(textAlignment: .center, fontSize: 16)

    
    lazy var taskStatusStackView : UIStackView = {
       
        let taskStatusStackView = UIStackView(arrangedSubviews: [completedTaskStackView,notCompletedTaskStackView])
        taskStatusStackView.axis = .horizontal
        taskStatusStackView.backgroundColor = UIColor(named: "DarkGray")
        taskStatusStackView.layer.cornerRadius = 10
        taskStatusStackView.translatesAutoresizingMaskIntoConstraints = false
        return taskStatusStackView
    }()
    
    
    private let completedImage : UIImageView = {
        let completedImage =  UIImageView(image: UIImage(named: "Done"))
        completedImage.translatesAutoresizingMaskIntoConstraints = false
        completedImage.widthAnchor.constraint(equalToConstant: 65).isActive = true
        completedImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return completedImage
    }()
    
    
    let completedTaskTitle = EATitle(textAlignment: .center, fontSize: 16)
    let completedTitle = EATitle(textAlignment: .center, fontSize: 12)
    
    lazy var completedTaskStackView : UIStackView = {
        let completedTaskStackView = UIStackView(arrangedSubviews: [completedImage,completedTaskTitle,completedTitle])
        completedTaskStackView.axis = .vertical
        completedTaskStackView.translatesAutoresizingMaskIntoConstraints = false
        completedTaskStackView.alignment = .center
        completedTaskStackView.distribution = .fillEqually
       
        completedTaskStackView.spacing = 10
        return completedTaskStackView
    }()
    
    private let notCompletedImage : UIImageView = {
        let notCompletedImage =  UIImageView(image: UIImage(named: "Dont"))
        notCompletedImage.translatesAutoresizingMaskIntoConstraints = false
        notCompletedImage.widthAnchor.constraint(equalToConstant: 65).isActive = true
        notCompletedImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return notCompletedImage
    }()
    
    
    let notCompletedTaskTitle = EATitle(textAlignment: .center, fontSize: 16)
    let notCompletedTitle = EATitle(textAlignment: .center, fontSize: 12)
    
    lazy var notCompletedTaskStackView : UIStackView = {
        let notCompletedTaskStackView = UIStackView(arrangedSubviews: [notCompletedImage,notCompletedTaskTitle,notCompletedTitle])
        notCompletedTaskStackView.axis = .vertical
        notCompletedTaskStackView.translatesAutoresizingMaskIntoConstraints = false
        notCompletedTaskStackView.alignment = .center
        notCompletedTaskStackView.distribution = .fillEqually
        notCompletedTaskStackView.spacing = 1
        return notCompletedTaskStackView
    }()
    
    
    lazy var logoutButton : EAButton = {
        let logoutButton = EAButton(title: " ", backgroundColor: .clear, cornerRadius: 15)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
        logoutButton.setImage(UIImage(named: "exit"), for: .normal)
        return logoutButton
    }()
    
    private func setupUI(){

        addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
        
            logoutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            logoutButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            logoutButton.widthAnchor.constraint(equalToConstant: 50),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
        
        ])
        
        completedTitle.text = "Completed"
        notCompletedTitle.text = "Not Completed"
        backgroundColor = UIColor(named: "DarkGray")
       
        addSubview(backgroundView)
        
        NSLayoutConstraint.activate([
        
            backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 250),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
        addSubview(userImageBackroundView)

        NSLayoutConstraint.activate([
            
            userImageBackroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            userImageBackroundView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            userImageBackroundView.heightAnchor.constraint(equalToConstant: 160),
            userImageBackroundView.widthAnchor.constraint(equalToConstant: 150)
        
        ])
        
        userImageBackroundView.addSubview(userImageView)
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: userImageBackroundView.leadingAnchor, constant: 15),
            userImageView.topAnchor.constraint(equalTo: userImageBackroundView.topAnchor, constant: 15),
            userImageView.bottomAnchor.constraint(equalTo: userImageBackroundView.bottomAnchor,constant: -15),
            userImageView.trailingAnchor.constraint(equalTo: userImageBackroundView.trailingAnchor, constant: -15)
        
        ])
        
        backgroundView.addSubview(taskTitle)
        taskTitle.text = "Current Task Status"
        NSLayoutConstraint.activate([
            taskTitle.leadingAnchor.constraint(equalTo: userImageBackroundView.leadingAnchor, constant: 15),
            taskTitle.topAnchor.constraint(equalTo: userImageBackroundView.bottomAnchor, constant: 15),
            
        
        ])
        
        
        backgroundView.addSubview(taskStatusStackView)
        
        NSLayoutConstraint.activate([
        
            taskStatusStackView.topAnchor.constraint(equalTo: taskTitle.bottomAnchor, constant: 20),
            taskStatusStackView.leadingAnchor.constraint(equalTo: userImageBackroundView.leadingAnchor, constant: 5),
            taskStatusStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            taskStatusStackView.heightAnchor.constraint(equalToConstant: 200)
        
        ])
            
    }
    
    
    @objc func logout(){
        print("?")
        self.delegate?.logoutClicked()
    }
    
    @objc func userImageViewClicked(){
        print("image clicked")
        self.delegate?.imagePicker()
    }
}
