//
//  String+Ext.swift
//  noteor
//
//  Created by Emir AKSU on 8.03.2024.
//

import Foundation

extension String{
    
    
    
    func turnToDate() -> Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        
        return formatter.date(from: self)
    }
    
    func turnToHour() -> Date?{
        
        let formatter = DateFormatter()
        
        formatter.dateFormat =  "HH-mm"
        
        
        return formatter.date(from: self)
        
    }
    
    
}
