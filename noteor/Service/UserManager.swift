//
//  UserManager.swift
//  noteor
//
//  Created by Emir AKSU on 26.04.2024.
//

import Foundation

class UserManager {
    
    static let shared = UserManager()
    
    private init () {}
    
    var currentUser : User?
    
    func setUser(user : User){
        currentUser = user
    }
    
    func getUser() -> User? {
        
        return currentUser
    }
    
}
