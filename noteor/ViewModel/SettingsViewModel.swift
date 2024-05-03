//
//  SettingsViewModel.swift
//  noteor
//
//  Created by Emir AKSU on 2.05.2024.
//

import Foundation
import UIKit

extension SettingsViewModel : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewSections[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewSections[indexPath.section].cells[indexPath.row]
        return cell.createdCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewSections.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewSections[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableViewSections[indexPath.section].cells[indexPath.row]
        cell.action(cell)
    }
    
}

protocol SettingsViewModelDelegate : AnyObject {
    func deleteAccountClicked()
    func didClickedLogout()
    func logout()
    func deleteUser()
}

class SettingsViewModel : NSObject{
    static let id = "SettingsCell"
    var authService : AuthService
    private var tableViewSections = [SettingsSection]()
    private weak var delegate : SettingsViewModelDelegate?
    
    init(delegate: SettingsViewModelDelegate, authService : AuthService) {
        self.delegate = delegate
        self.authService = authService
        super.init()
        self.configureDataSource()
        
    }
 
    
    private func configureDataSource(){
        let account = SettingsSection(title: "Account", cells:
                                        [
                                                    
                                                    SettingsItem(createdCell: {
                                                        let cell = UITableViewCell(style: .value1, reuseIdentifier: Self.id)
                                                        cell.textLabel?.text = "Sign Out"
                                                        return cell
                                                    }, action: { _ in
                                                        self.delegate?.didClickedLogout()
                                                    }),
                                                    
                                                    SettingsItem(createdCell: {
                                                        let cell = UITableViewCell(style: .value1, reuseIdentifier: Self.id)
                                                        cell.textLabel?.text = "Delete My Account"
                                                        return cell
                                                    }, action: { _ in
                                                        self.delegate?.deleteAccountClicked()
                                                    })
        
                                        ]
        )
        
       tableViewSections = [account]
    }
    
    
    func logout(){
        
        authService.logout { result in
            switch result {
                
            case .success():
                self.delegate?.logout()
            case .failure(_):
                print("error")
            }
        }
    }
    
    func deleteUser(){
        authService.deleteUser { result in
            switch result {
                case .success(_):
                    self.delegate?.deleteUser()
                case .failure(let error):
                    print("User delete error")
            }
        }
    }
   
    
}
