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
    
    
}
