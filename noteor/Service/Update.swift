//
//  Update.swift
//  noteor
//
//  Created by Emir AKSU on 23.04.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol UpdateService {
    func updateNote(id: String, data: [AnyHashable : Any], completion : @escaping(Result<Void,Error>) -> Void)
    func updateUserInfo(id : String, data : [AnyHashable : Any], completion : @escaping(Result<Void, Error>) -> Void)
}

class Update : UpdateService {
    
    func updateUserInfo(id : String, data : [AnyHashable : Any], completion : @escaping(Result<Void, Error>) -> Void){
        
        let firestore = Firestore.firestore()
        
        let path = firestore.collection("Accounts").document(id)
    
        path.updateData(data) { error in
            if error != nil {
                completion(.failure(NSError()))
            }
            else {
                completion(.success(()))
            }
        }
    }
    
    
   
    func updateNote(id: String, data: [AnyHashable : Any], completion : @escaping(Result<Void,Error>) -> Void) {
        
        let firestore = Firestore.firestore()
        
        
        guard let user = Auth.auth().currentUser else {
                print("Giriş yapılmadı")
                completion(.failure(NSError()))
            return}
        
        
        let path = firestore.collection("toDo").document(user.uid).collection("Notes").document(id)
            
        path.updateData(data) { error in
            if error != nil {
                completion(.failure(NSError()))
            }
            else {
                completion(.success(()))
            }
        }
        
        

}

    
    
    
}
