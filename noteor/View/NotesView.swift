//
//  NotesView.swift
//  noteor
//
//  Created by Emir AKSU on 23.04.2024.
//

import UIKit

protocol NotesViewDelegate:AnyObject{
    func didFilterBegin(filterText : String)
}

class NotesView: UIView {
    
    weak var delegate : NotesViewDelegate?
    
    private let topView : UIView = {
       let view = UIView()
        
        view.backgroundColor = UIColor(named: "Gray")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
       
        return view
    }()
    
   
    private let filterButton : EAButton = {
        let filterButton = EAButton(title: "Filter", backgroundColor: UIColor(named: "Work") ?? .systemCyan, cornerRadius: 20)
        filterButton.setImage(UIImage(named: "selective"), for: .normal)

        return filterButton
    }()
    
    
     let filterField : EATextField = {
        let filterField = EATextField(placeholder: "", isSecureTextEntry: false, textAlignment: .left)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 20))

        filterField.leftViewMode = .always
        
        imageView.image = UIImage(named: "mag")!.resized(toWidth: 36)
        
        filterField.leftView = imageView
        filterField.backgroundColor = UIColor(named: "DarkGray")
        filterField.layer.borderWidth = 0
        
        
        return filterField
    }()
    
  
    
    private let logo : UIImageView = {
        let logo = UIImageView(image: UIImage(named: "logo"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private let task : UIImageView = {
        let task = UIImageView(image: UIImage(named: "task"))
        task.translatesAutoresizingMaskIntoConstraints = false
        
        return task
    }()
    
    private let taskTitle : EATitle = {
        let taskTitle = EATitle(textAlignment: .left, fontSize: 36)
        taskTitle.text = "Task"
        return taskTitle
    }()
    
    private let currentDataTitle : EALabel = {
        let currentDataTitle = EALabel(textAlignment: .center, fontSize: 12)
        currentDataTitle.text = Date().formatted(date: .complete, time: .omitted)
        return currentDataTitle
    }()
    
    let collectionViewBack = UIView()
    var collectionView : UICollectionView!
    
    private func setupUI(){
       addSubview(topView)
        
        NSLayoutConstraint.activate([
        
            topView.topAnchor.constraint(equalTo: topAnchor),
            topView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: CGFloat(frame.height / 3))
        
        ])
        topView.addSubview(task)
        topView.addSubview(taskTitle)
        topView.addSubview(logo)

                NSLayoutConstraint.activate([
                
                    logo.centerYAnchor.constraint(equalTo: task.centerYAnchor),
                    logo.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 10),
                    logo.heightAnchor.constraint(equalToConstant: 50),
                    logo.widthAnchor.constraint(equalToConstant: 50),
                    
                    
                    
                    task.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10),
                    task.topAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.topAnchor, constant: 10),
                    task.heightAnchor.constraint(equalToConstant: 70),
                    task.widthAnchor.constraint(equalToConstant: 65),
                    
                    taskTitle.trailingAnchor.constraint(equalTo: task.leadingAnchor, constant: -10),
                    taskTitle.centerYAnchor.constraint(equalTo: task.centerYAnchor),
                    taskTitle.widthAnchor.constraint(equalToConstant: 70),
                    taskTitle.heightAnchor.constraint(equalToConstant: 30)
                    


                ])
        
        
        addSubview(filterField)
        NSLayoutConstraint.activate([
        
            filterField.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20),
            filterField.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -20),
            filterField.widthAnchor.constraint(equalToConstant: 230),
            filterField.heightAnchor.constraint(equalToConstant: 40),


        ])
        
        
        filterField.addTarget(self, action: #selector(didTextFieldChanged), for: .editingChanged)
        
        addSubview(filterButton)
        
        NSLayoutConstraint.activate([
            
            filterButton.leadingAnchor.constraint(equalTo: filterField.trailingAnchor, constant: 10),
            filterButton.topAnchor.constraint(equalTo: filterField.topAnchor, constant: 0),
            filterButton.bottomAnchor.constraint(equalTo: filterField.bottomAnchor, constant: 0),
            filterButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20)

        
        
        ])
        
        topView.addSubview(currentDataTitle)
        
        NSLayoutConstraint.activate([
            
            currentDataTitle.bottomAnchor.constraint(equalTo: filterField.topAnchor, constant: -30),
            currentDataTitle.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            currentDataTitle.topAnchor.constraint(equalTo: task.bottomAnchor, constant: 10),
            currentDataTitle.widthAnchor.constraint(equalTo: topView.widthAnchor)
            
        ])
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: createFlowLayout())
        addSubview(collectionView)
        
        sendSubviewToBack(collectionView)
        collectionView.backgroundColor = UIColor(named: "DarkGray")
        collectionView.register(TaskCell.self, forCellWithReuseIdentifier: TaskCell.id)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        
        ])

    }
    
    
    func createFlowLayout() -> UICollectionViewFlowLayout{
        
        let layout = UICollectionViewFlowLayout()
        
        let width = bounds.width
        let padding : CGFloat = 8
        let minimumItemSpace : CGFloat = 12
        let newWidth =  width - (padding * 2) - (minimumItemSpace * 2)
        let itemWidth = newWidth
        layout.itemSize = .init(width: itemWidth, height: 295)
        layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        
        return layout
        
    }

    @objc func didTextFieldChanged(){
        self.delegate?.didFilterBegin(filterText: filterField.text!)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
