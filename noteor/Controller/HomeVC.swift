//
//  HomeVC.swift
//  noteor
//
//  Created by Emir AKSU on 17.02.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchResultsUpdating {
    
    var searchController : UISearchController!

    @Published var notes = [Notes]()
    

    // MARK: - Filter
    var filteredNotes = [Notes]()
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
      
        
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            
            
            guard scopeButton == "All" else {
                filteredNotes = notes.filter{$0.Categ.lowercased().contains(scopeButton.lowercased()) } // Sadece kategoriye göre filtreler
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                return
            }
            
         
            filteredNotes = notes // All seçili, Filtre yok
     
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            return
        }
        
        if scopeButton == "All"{
            filteredNotes = notes.filter{  $0.Title.lowercased().contains(filter.lowercased()) }  // All seçiliyken yazıya göre filtreler
            
        }else{
          
            filteredNotes = notes.filter{  $0.Title.lowercased().contains(filter.lowercased()) && $0.Categ.lowercased().contains(scopeButton.lowercased()) } // Hem katgoriye hem yazıya göre filtreler
          
         
        }
        
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
    
    //MARK: - Collection View
    var collectionView : UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
      
        return filteredNotes.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCell.id, for: indexPath) as! TaskCell
        
   
        cell.set(note: filteredNotes[indexPath.row])
        
        return cell
       
  
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationVC = AddItemVC()
        destinationVC.note = filteredNotes[indexPath.item]
        
        guard filteredNotes[indexPath.item].Lock == false else{
            
            makeEAAlertTextField(alertTitle: "Locked"){
                self.navigationController?.pushViewController(destinationVC, animated: true)
            }
          
            
          

            return
        }
        
       
        self.navigationController?.pushViewController(destinationVC, animated: true)
       
    }
    
    
    //MARK: - Life Cycle
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
  
        configureCollectionView()
        
        getDocuments()
        
        configureSearchBar()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Noteor"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        
    }
    
  
    //MARK: - UI Configures

    @objc func addButtonClicked(){
        
        self.navigationController?.pushViewController(AddItemVC(), animated: true)
    }
    
    
    private func configureSearchBar(){
        
        
        searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search in notes"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        searchController.searchBar.scopeButtonTitles = ["All","School","Work","Food","Sport","Special Days"]
        searchController.searchBar.showsScopeBar = true
        
    }

    private func configureCollectionView(){
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createFlowLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TaskCell.self, forCellWithReuseIdentifier: TaskCell.id)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        view.addSubview(collectionView)

        
    }
    
    
    func createFlowLayout() -> UICollectionViewFlowLayout{
        
        let layout = UICollectionViewFlowLayout()
        
        let width = view.bounds.width
        let padding : CGFloat = 8
        let minimumItemSpace : CGFloat = 12
        let newWidth =  width - (padding * 2) - (minimumItemSpace * 2)
        let itemWidth = newWidth / 2
        layout.itemSize = .init(width: itemWidth, height: itemWidth)
        layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        
        return layout
        
    }
    
    
    func getDocuments(){
        
        let firestore = Firestore.firestore()
        
        firestore.collection("Users").document(Auth.auth().currentUser?.email ?? "").collection("Notes").addSnapshotListener { snap, error in
            
            
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
            
            self.filteredNotes = self.notes
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
        
        
        
    }
}
