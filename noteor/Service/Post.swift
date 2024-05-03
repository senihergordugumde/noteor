//
//  Post.swift
//  noteor
//
//  Created by Emir AKSU on 23.04.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
protocol PostService{
  func createNote(
   title : String,
   categ : String,
   descr : String,
   endDate :Date,
   endTime : Date,
   startDate : Date,
   startTime : Date,
   isCompleted : String,
   createDate : Date,
   tasks : [tasks],
   completion : @escaping(Result<Bool,Error>) -> Void)
    
func postImage(imageData : Data, id : String,completion : @escaping(Result<URL,Error>) -> Void)
}

class Post : PostService{
    
    func createNote(
        
       title : String,
       categ : String,
       descr : String,
       endDate :Date,
       endTime : Date,
       startDate : Date,
       startTime : Date,
       isCompleted : String,
       createDate : Date,
       tasks : [tasks],
       completion : @escaping(Result<Bool,Error>) -> Void){
          
           
           let newNote = Notes(Title: title, Descr: descr, Categ: categ, StartDate: startDate, EndDate: endDate, StartTime: startTime, EndTime: endTime, isCompleted: isCompleted,tasks: tasks, createDate: createDate)
        
        let firestore = Firestore.firestore()
          
           guard let user = Auth.auth().currentUser else {
               completion(.failure(NSError(domain: "AuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı girişi yapılmamış."])))
               return
           }
           
           
           do{
               let ref = try firestore.collection("toDo").document(user.uid).collection("Notes").addDocument(from: newNote)
               completion(.success(true))
           }catch{
               print("hata EEE")
               completion(.failure(NSError()))
           }
        }

    
    
    func postImage(imageData : Data, id : String,completion : @escaping(Result<URL,Error>) -> Void){
        let storageRef = Storage.storage().reference().child("/UserImage/\(id)/pp.jpeg")
            storageRef.putData(imageData, metadata: nil) { (metadata, error) in
                    guard let metadata = metadata else {
                        print("Error occurred: \(error?.localizedDescription ?? "Unknown error")")
                        completion(.failure(NSError()))
                        return
                    }
                    storageRef.downloadURL { (url, error) in
                        guard let downloadURL = url else {
                            print("Error occurred: \(error?.localizedDescription ?? "Unknown error")")
                            return
                        }
                        
                        completion(.success(downloadURL))
                       
                    }
                }
    }
    
}
