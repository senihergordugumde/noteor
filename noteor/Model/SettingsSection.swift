//
//  SettingsSection.swift
//  noteor
//
//  Created by Emir AKSU on 2.05.2024.
//

import Foundation
import UIKit


struct SettingsSection {
    var title : String
    var cells : [SettingsItem]
    
    
}


struct SettingsItem{
    var createdCell : () -> UITableViewCell
    var action : (SettingsItem) -> Void
}
