//
//  Auth.swift
//  noteor
//
//  Created by Emir AKSU on 26.04.2024.
//

import Foundation
import FirebaseAuth
import Firebase
import GoogleSignIn
import FirebaseCore
import AuthenticationServices

protocol AuthService {
    func signIn(email : String, password : String, completion : @escaping(Result<Void,Error>) -> Void)
    func googleSignIn(completion: @escaping (Result<AuthDataResult, Error>) -> Void)
    func logout(completion : @escaping(Result<Void,Error>)->Void)
    func register(email : String, password:String, name : String, photoURL : String, completion : @escaping(Result<Void,Error>)->Void)
    func deleteUser(completion : @escaping(Result<Void,Error>) -> Void)
}

class Authentication: AuthService{
    
    
    func deleteUser(completion : @escaping(Result<Void,Error>) -> Void){
        let user = Auth.auth().currentUser
        
        user?.delete(completion: { error in
            if error != nil {
                completion(.failure(NSError()))
            }else{
                completion(.success(()))
            }
        })
    }
  
    func register(email : String, password:String, name : String, photoURL : String,completion : @escaping(Result<Void,Error>)->Void){
        
        
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil{
                completion(.failure(NSError()))
            }else{
                
                
                let firestore = Firestore.firestore()
                let firestoreDatabase = ["userID" : result!.user.uid, "displayName": name, "photoURL" : photoURL] as [String : Any]
                firestore.collection("Accounts").document(result!.user.uid).setData(firestoreDatabase, completion: { error in
                    
                    if error != nil{
                        print(error?.localizedDescription)
                        completion(.failure(NSError()))
                    }else{
                        
                        completion(.success(()))
                        
                    }
                    
                    
                    
                })
                
            }
        }
        
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            if error != nil {
                completion(.failure(NSError()))
            }
            else{
                completion(.success(()))
            }
            
        }
    }
    
  
    func googleSignIn(completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

      
        GIDSignIn.sharedInstance.signIn(withPresenting: UIApplication.shared.keyWindow!.rootViewController!) { [unowned self] result, error in
            guard error == nil else {
                print("error")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                    
                if error != nil{
                    completion(.failure(NSError()))
                }
                
                else{
                 
                    completion(.success(result!))
                }
                
            }

        }
     }
 
  
    
    // LOGOUT
    
    func logout(completion : @escaping(Result<Void,Error>)->Void){
        
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        }
        
        catch{
            completion(.failure(NSError()))
        }
        
    }
    
    
}
