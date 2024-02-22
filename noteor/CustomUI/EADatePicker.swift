//
//  EADatePicker.swift
//  noteor
//
//  Created by Emir AKSU on 17.02.2024.
//

import UIKit

class EADatePicker: UIDatePicker {


    init(datePickerMode : ){
        
        super.init(frame: .zero)
        
        
        
        
    }
    
    private func configure(){
        
        
        time.translatesAutoresizingMaskIntoConstraints = false
        time.datePickerMode =
        time.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
