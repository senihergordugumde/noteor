//
//  EATextField+Ext.swift
//  noteor
//
//  Created by Emir AKSU on 24.04.2024.
//

import Foundation
import UIKit

extension EATextField {
    
    func makeDatePicker(){
       
        let toolbar = UIToolbar()
        datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dateDoneClicked))
    
        toolbar.setItems([doneButton], animated: true)
        
        inputAccessoryView = toolbar
        inputView = datePicker
        
        datePicker.datePickerMode = .date
        
    }
    
    @objc func dateDoneClicked(){
        
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        self.text = formatter.string(from: datePicker.date)
        self.endEditing(true)
    }
    
    func makeTimePicker(){
       
        let toolbar = UIToolbar()
        datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(timeDoneClicked))
    
        toolbar.setItems([doneButton], animated: true)
        
        inputAccessoryView = toolbar
        inputView = datePicker
        
        datePicker.datePickerMode = .time
        
    }
    
    @objc func timeDoneClicked(){
        
        
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        
        self.text = formatter.string(from: datePicker.date)
        self.endEditing(true)
    }

    
    
}
