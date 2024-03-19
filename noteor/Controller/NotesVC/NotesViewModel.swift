//
//  NotesViewModel.swift
//  noteor
//
//  Created by Emir AKSU on 19.03.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
protocol NotesViewModelDelegate : AnyObject {
    func reloadData()
}

protocol NotesViewModelProtocol{
    
    
    var delegate : NotesViewModelDelegate? { get set }
    var notesCount : Int { get }
    func note(at index : Int) -> Notes?
    
    func filtredNotes(with searchText : String)
    
    
    func getNotes()
    
    func updateNote(id : String, data : [AnyHashable : Any])
}


class NotesViewModel : NotesViewModelProtocol {
    weak var delegate: NotesViewModelDelegate?
    private var notes = [Notes]()
    private var filteredNotes = [Notes]()
    
    var notesCount: Int {
        return filteredNotes.isEmpty ? notes.count : filteredNotes.count

    }
    
    
    func note(at index: Int) -> Notes? {
        return filteredNotes.isEmpty ? notes[index] : filteredNotes[index]

    }
    
   

    func filtredNotes(with searchText: String) {
        filteredNotes = notes.filter{$0.Title.lowercased().contains(searchText.lowercased() )}
        
        
        DispatchQueue.main.async {
            self.delegate?.reloadData()

        }
    }
    
    func getNotes() {
        let firestore = Firestore.firestore()
        
        
        guard let userEmail = Auth.auth().currentUser?.email else {
            
            print("giriş yapılamadı")
            return}
        firestore.collection("Users").document(userEmail).collection("Notes").order(by: "StartDate", descending: true).addSnapshotListener { snap, error in
            
            
            guard let documents = snap?.documents else {
                
                    print("document error")
                
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
                self.delegate?.reloadData()
            }
            
        }
    }
    
    func updateNote(id: String, data: [AnyHashable : Any]) {
        
        let firestore = Firestore.firestore()
        
        
        guard let userEmail = Auth.auth().currentUser?.email else {
                print("Giriş yapılmadı")
            return}
        
        
            let path = firestore.collection("Users").document(userEmail).collection("Notes").document(id)
        
        
        do {
            try path.updateData(data)
        }
        catch{
            print("error update")
        }
    }
    
    
}
