//
//  Notes.swift
//  noteor
//
//  Created by Emir AKSU on 17.02.2024.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

struct Notes : Identifiable, Codable{
    
    @DocumentID var id: String? = UUID().uuidString
    var Title : String

    var Descr : String

    var Categ : String
    var StartDate : Date
    var EndDate : Date
    var StartTime : Date
    var EndTime : Date
    var isCompleted : String
    var tasks : [tasks]
    var password : String? = nil
    var createDate : Date
    
}




struct tasks : Codable {
    var taskName : String
    var taskStatus : Bool
    
    func toDict() -> [String : Any]{
        
        return [
            "taskName" : taskName,
            "taskStatus" : taskStatus
         ]
        }
        
    
}
