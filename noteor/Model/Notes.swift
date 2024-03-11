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
    var Color : String
    var Descr : String
    var Lock : Bool
    var Categ : String
    var StartDate : Date
    var EndDate : Date
    var StartTime : Date
    var EndTime : Date

    var tasks : [tasks]
   
    
}




struct tasks : Codable {
    var taskName : String
    var taskStatus : Bool
}
