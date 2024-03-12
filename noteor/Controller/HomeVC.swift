//
//  HomeVC.swift
//  noteor
//
//  Created by Emir AKSU on 4.03.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
  
    
   
    
   
    
    var categories = ["Work", "Food", "Gym"]
    var notes : [Notes]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTopView()
        configurecolTableBack()
        view.backgroundColor = UIColor(named: "Red")
        getDocuments()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true

    }
    
    //MARK: -  ColTableBack
    
    
    private let colTableBack : UIView = {
       let view = UIView()
        
        view.backgroundColor = .secondarySystemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20

       
        return view
    }()
    
    
    let categoriesText = EATitle(textAlignment: .left, fontSize: 16)
    let calendarButton = EAButton(title: "", backgroundColor: .clear, cornerRadius: 0)
    
    private func configurecolTableBack(){
        
        
     
        categoriesText.text = "Categories"
  
        view.addSubview(colTableBack)
        colTableBack.addSubview(categoriesText)
        colTableBack.addSubview(calendarButton)
        
        NSLayoutConstraint.activate([
        
            colTableBack.topAnchor.constraint(equalTo: topView.bottomAnchor),
            colTableBack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            colTableBack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            colTableBack.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
        
        //MARK: -  Categories Text

        NSLayoutConstraint.activate([
        
            categoriesText.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20),
            categoriesText.leadingAnchor.constraint(equalTo: colTableBack.leadingAnchor, constant: 20),
            categoriesText.widthAnchor.constraint(equalToConstant: 100),
            categoriesText.heightAnchor.constraint(equalToConstant: 24)
        
        ])

        //MARK: -  Calendar

        NSLayoutConstraint.activate([
        
            calendarButton.centerYAnchor.constraint(equalTo: categoriesText.centerYAnchor),
            calendarButton.trailingAnchor.constraint(equalTo: colTableBack.trailingAnchor, constant: -20),
            calendarButton.widthAnchor.constraint(equalToConstant: 40),
            calendarButton.heightAnchor.constraint(equalToConstant: 44)
        
        ])
        calendarButton.setImage(UIImage(named: "calendar"), for: .normal)
        
      
        calendarButton.addTarget(self, action: #selector(calendarButtonClicked), for: .touchUpInside)
        
        
        
        configureCollectionView()
        todaysTask()
        configureTableView()
        
    }
    
    @objc func calendarButtonClicked(){
        let destinationVC = CalendarVC()
        destinationVC.notes = self.notes
        
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    
    //MARK: -  Collection View
    var collectionView : UICollectionView?

   

    private func configureCollectionView(){
        
        collectionView = UICollectionView(frame: .null, collectionViewLayout: createLayout())
        
        
        guard let collectionView = collectionView else {
            print("error")
            return}
            
        colTableBack.addSubview(collectionView)
        
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: categoriesText.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: colTableBack.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: colTableBack.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 120)
        

        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CategCell.self, forCellWithReuseIdentifier: CategCell.id)
        
        collectionView.backgroundColor = .clear
    }
    
    private func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let padding : Double = 14
        layout.itemSize = .init(width: 90, height: 110)
        layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        
        layout.scrollDirection = .horizontal
        return layout
        
        
    }
    
    //MARK: - CollectionView Delegates
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategCell.id, for: indexPath) as! CategCell
        
        cell.set(categ: categories[indexPath.row])
        
        return cell
    }
    
    //MARK: - Today's Task Text
    
    let todaysTaskText = EATitle(textAlignment: .left, fontSize: 16)
    private func todaysTask(){
        todaysTaskText.text = "Today's Task"
        colTableBack.addSubview(todaysTaskText)
        
        NSLayoutConstraint.activate([
        
            todaysTaskText.leadingAnchor.constraint(equalTo: colTableBack.leadingAnchor, constant: 20),
            todaysTaskText.topAnchor.constraint(equalTo: collectionView!.bottomAnchor, constant: 20),
            todaysTaskText.widthAnchor.constraint(equalToConstant: 200),
            todaysTaskText.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    //MARK: - Table View

    
    var tableView : UITableView?
    private func configureTableView(){
        
      
        
        view.addSubview(colTableBack)
        
        
        
        tableView = UITableView()
        guard let tableView = tableView else {return}
        colTableBack.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TaskCountCell.self, forCellReuseIdentifier: TaskCountCell.id)
        
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: todaysTaskText.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: colTableBack.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: colTableBack.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: colTableBack.bottomAnchor)

        
        ])
        
       
    
        
    }
    
    //MARK: -  TableView Delegates

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCountCell.id, for: indexPath) as! TaskCountCell
        
        
        
        var count = 0
        if let notes = self.notes {
            
            
            for j in notes{
                
                print(j.StartDate)
                print(j.EndDate)
            
                
                if (categories[indexPath.row] == j.Categ) && ((j.StartDate <= Date()) && (j.EndDate >= Date()))      {
                    count += 1
                }
            }
            
            
        }
      
        cell.set(categ: categories[indexPath.row], count: count)
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
    //MARK: -  TopView
    
    private let topView : UIView = {
       let view = UIView()
        
        view.backgroundColor = UIColor(named: "Red")
        view.translatesAutoresizingMaskIntoConstraints = false
    
       
        return view
    }()
    
    private func configureTopView(){
        
  
        view.addSubview(topView)
        NSLayoutConstraint.activate([
        
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 250)
        
        ])

        
      
        configureTopBar()

        
    }

    private func configureTopBar(){
        //MARK: -  TopBar

        let logo = UIImageView(image: UIImage(named: "logo"))
        let task = UIImageView(image: UIImage(named: "task"))
      
        logo.translatesAutoresizingMaskIntoConstraints = false
        task.translatesAutoresizingMaskIntoConstraints = false
        
        topView.addSubview(task)
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
            
     


        ])
        
        
        
    }
    
    
    //MARK: - Get Data

    
    func getDocuments(){
        
        
        let firestore = Firestore.firestore()
        
        guard let userEmail = Auth.auth().currentUser?.email else {
            
            self.makeEAAlert(alertTitle: "Login Error", alertLabel: "You should SignIn First")
            return}

        
        firestore.collection("Users").document(userEmail).collection("Notes").addSnapshotListener { snap, error in
            
            
            guard let documents = snap?.documents else {
                
                self.makeEAAlert(alertTitle: "Hata", alertLabel: error?.localizedDescription ?? "Something happened")
                
                return
                
            }
            
            self.notes = documents.compactMap{(snap) -> Notes? in
                do{
                    
                    let note : Notes
                    note = try snap.data(as: Notes.self)
                    
                    return note
                    
                }
                catch{
                    
                    print("hata")
                    return nil
                }
                
            }
            
            DispatchQueue.main.async {
                
                self.tableView?.reloadData()
                
            }
            
            
            
        }
      
        
    }

}
