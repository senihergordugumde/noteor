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


class NotesViewModel{
    
    weak var delegate: NotesViewModelDelegate?
    private let getService : GetService
    private let updateService : UpdateService
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
    
    
    init(getService: GetService, updateService : UpdateService) {
        
        self.updateService = updateService
        self.getService = getService

    }
    
    
    func getNotes(){
       
        getService.getNote { result in
            
            switch result{
                case .success(let notes):
                    self.notes = notes
                    self.delegate?.reloadData()
                case .failure(let error):
                    print("error")
            }
            
        }
        
    }
    
    func updateNotes(id : String, data : [AnyHashable : Any]){
        updateService.updateNote(id: id, data: data) { result in
            switch result {
                case .success(let isTrue):
                    print("Notes taken")
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    
}
