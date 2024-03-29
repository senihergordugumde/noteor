//
//  NotesVC.swift
//  noteor
//
//  Created by Emir AKSU on 17.02.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
class NotesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate, NotesViewModelDelegate{
    
    func reloadData() {
        collectionView.reloadData()
    }
 

    
    var viewModel = NotesViewModel()

    //MARK: - Life Cycle
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.getNotes()
        view.backgroundColor = .white
        configureTopView()
        configureCollectionView()
        view.bringSubviewToFront(topView)
        dismissKeyboardOnTouch()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true

    }
    
    //MARK: - TopBar
    let logo = UIImageView(image: UIImage(named: "logo"))
    let task = UIImageView(image: UIImage(named: "task"))
    let taskTitle = EATitle(textAlignment: .left, fontSize: 36)
    private func configureTopBar(){
        
        taskTitle.text = "Task"
        logo.translatesAutoresizingMaskIntoConstraints = false
        task.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        
        
    }
    
    
    //MARK: -  TopView
    
    private let topView : UIView = {
       let view = UIView()
        
        view.backgroundColor = .secondarySystemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
       
        return view
    }()
    
    private func configureTopView(){
        
  
        view.addSubview(topView)
        NSLayoutConstraint.activate([
        
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: CGFloat(view.frame.height / 3))
        
        ])

        
        configureFilterField()
        configureFilterButton()
        configureTopBar()
        configureDate()
        
    }
    //MARK: - Filter
    let filterButton = EAButton(title: "Filter", backgroundColor: UIColor(named: "Work") ?? .systemCyan, cornerRadius: 20)
    let filterField = EATextField(placeholder: "", isSecureTextEntry: false, textAlignment: .left)
    var filteredNotes = [Notes]()

    private func configureFilterButton(){
        //MARK: - ConfigureFilterButton
        topView.addSubview(filterButton)
        
        NSLayoutConstraint.activate([
            
            filterButton.leadingAnchor.constraint(equalTo: filterField.trailingAnchor, constant: 10),
            filterButton.topAnchor.constraint(equalTo: filterField.topAnchor, constant: 0),
            filterButton.bottomAnchor.constraint(equalTo: filterField.bottomAnchor, constant: 0),
            filterButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20)

        
        
        ])
        
        filterButton.setImage(UIImage(named: "selective"), for: .normal)
        
    }
    
    private func configureFilterField(){
        //MARK: - ConfigureFilterField

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        topView.addSubview(filterField)
        
        NSLayoutConstraint.activate([
        
            filterField.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20),
            filterField.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -20),
            filterField.widthAnchor.constraint(equalToConstant: 230),
            filterField.heightAnchor.constraint(equalToConstant: 40),


        ])
        
        
        filterField.leftViewMode = .always
        
        imageView.image = UIImage(named: "mag")!.resized(toWidth: 36)
        
        filterField.leftView = imageView
        filterField.backgroundColor = .systemBackground
        filterField.layer.borderWidth = 0
        filterField.delegate = self
        
        filterField.addTarget(self, action: #selector(didTextFieldChanged), for: .editingChanged)
    }
    
    @objc func didTextFieldChanged(){
        

        viewModel.filtredNotes(with: filterField.text ?? "")
      
        
    }
    
    
    
    
    //MARK: - Configure Date
    private func configureDate(){
        let currentDataTitle = EALabel(textAlignment: .center, fontSize: 16)
        currentDataTitle.text = Date().formatted(date: .complete, time: .omitted)
        topView.addSubview(currentDataTitle)
        
        NSLayoutConstraint.activate([
            
            currentDataTitle.bottomAnchor.constraint(equalTo: filterField.topAnchor, constant: -30),
            currentDataTitle.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            currentDataTitle.topAnchor.constraint(equalTo: task.bottomAnchor, constant: 10),
            currentDataTitle.widthAnchor.constraint(equalTo: topView.widthAnchor)
            
        ])
        
    }
    
  
    
    //MARK: - Collection View
    let collectionViewBack = UIView()

    var collectionView : UICollectionView!
    
    private func configureCollectionView(){
        //MARK: - Configure Collection View

        
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createFlowLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TaskCell.self, forCellWithReuseIdentifier: TaskCell.id)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
    
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(collectionView)
        
        
        NSLayoutConstraint.activate([
        
            collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        
        ])

        
    }
    
    
    func createFlowLayout() -> UICollectionViewFlowLayout{
        
        let layout = UICollectionViewFlowLayout()
        
        let width = view.bounds.width
        let padding : CGFloat = 8
        let minimumItemSpace : CGFloat = 12
        let newWidth =  width - (padding * 2) - (minimumItemSpace * 2)
        let itemWidth = newWidth
        layout.itemSize = .init(width: itemWidth, height: 295)
        layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        
        return layout
        
    }

        
        
    
}
