//
//  NotesVC.swift
//  noteor
//
//  Created by Emir AKSU on 17.02.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
class NotesVC: UIViewController, NotesViewModelDelegate, NotesViewDelegate{
    
    func didFilterBegin(filterText: String) {
        viewModel.filtredNotes(with: filterText)
    }
    
   
    func reloadData() {
        notesView.collectionView.reloadData()
    }
 
    var notesView : NotesView! {
        return self.view as? NotesView
    }
    
    var viewModel : NotesViewModel
    
    init(viewModel : NotesViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = NotesView(frame: self.view.bounds)
        
        notesView.delegate = self
        viewModel.delegate = self
        notesView.collectionView.delegate = self
        notesView.collectionView.dataSource = self
        
        notesView.filterField.delegate = self
        viewModel.getNotes()
        dismissKeyboardOnTouch()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true

    }
  
    
}
