//
//  Delete.swift
//  noteor
//
//  Created by Emir AKSU on 23.04.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol DeleteService{
   func deleteNote(note : Notes,completion : @escaping(Result<Void,Error>) -> Void)
}

class Delete : DeleteService {
    
    
    func deleteNote(note : Notes,completion : @escaping(Result<Void,Error>) -> Void){
        
        let firestore = Firestore.firestore()
        
        guard let user = Auth.auth().currentUser else {
                print("Giriş yapılmadı")
                completion(.failure(NSError()))
            return}
        
        firestore.collection("toDo").document(user.uid).collection("Notes").document(note.id ?? " ").delete() { error in
            if error != nil{
                print(note.id!)

                completion(.failure(NSError()))
            }
            else{
                print(note.id!)
                completion(.success(()))
            }
            
        }
    }
    
    
}
