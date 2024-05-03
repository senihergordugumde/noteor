//
//  Get.swift
//  noteor
//
//  Created by Emir AKSU on 23.04.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol GetService {
    func getNote(completion : @escaping(Result<[Notes],Error>)->Void)
    func getUserImage(Url : URL,completion : @escaping(Result<UIImage,Error>)->Void)
    func getStatusCount(field : String, isEqualTo : Any,completion : @escaping(Result<Int,Error>)->Void)

}

class Get : GetService {
    
    func getStatusCount(field : String, isEqualTo : Any,completion : @escaping(Result<Int,Error>)->Void){
        let firestore = Firestore.firestore()
        
        
        guard let user = Auth
            .auth()
            .currentUser else {
            
            completion(.failure(NSError()))
            return}
        
        firestore.collection("toDo")
            .document(user.uid)
            .collection("Notes").whereField(field, isEqualTo: isEqualTo).getDocuments { result, error in
                
                guard let result = result else {
                    completion(.failure(NSError()))
                    return
                }
                completion(.success(result.documents.count))
                
            }
        

    }
    
    func getNote(completion : @escaping(Result<[Notes],Error>)->Void){
        let firestore = Firestore.firestore()
        
        guard let user = Auth
            .auth().currentUser
            else {
            
            completion(.failure(NSError()))
            return}
        
        firestore.collection("toDo")
            .document(user.uid)
            .collection("Notes")
            .order(by: "StartDate", descending: true)
            .addSnapshotListener { snap, error in
            
                guard let documents = snap?.documents else {
                      print("document error")
                      return
                        }
    
                let notes = documents.compactMap{(snap) -> Notes? in
                    do{
                        let note : Notes
                        note = try snap.data(as: Notes.self)
                        return note
                    } 
                    catch {
                              completion(.failure(NSError()))
                              return nil
                          }
                      }
                      completion(.success(notes))
            }
    }
    
    func getUserImage(Url : URL,completion : @escaping(Result<UIImage,Error>)->Void){
     
        let task = URLSession.shared.dataTask(with: Url) { data, response, error in
            
            guard let data = data else {
                completion(.failure(NSError()))
                return}
            
            guard let image = UIImage(data: data) else {
                completion(.failure(NSError()))
                return}
            
            completion(.success(image))
            
            
            
        }
        task.resume()
    }
    
}
