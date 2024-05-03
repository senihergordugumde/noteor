//
//  AddItemVC+Ext.swift
//  noteor
//
//  Created by Emir AKSU on 16.03.2024.
//

import Foundation
import UIKit

extension AddItemVC : UITableViewDataSource, UITableViewDelegate{
    
    //MARK: - Task Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addItemViewModel.toDoList.count
    }
    
    //MARK: - Task Cell

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: toDoCell.id, for: indexPath) as! toDoCell
        
        cell.set(task: addItemViewModel.toDoList[indexPath.row])
        
        cell.action = {
            
            if self.addItemViewModel.toDoList[indexPath.row].taskStatus {
                self.addItemViewModel.toDoList[indexPath.row].taskStatus = false
                
                DispatchQueue.main.async {
                    cell.deleteButton.setImage(UIImage(named: "closeDetail"), for: .normal)

                }

            }
            
            else {
                self.addItemViewModel.toDoList[indexPath.row].taskStatus = true
                
                DispatchQueue.main.async {
                    cell.deleteButton.setImage(UIImage(named: "checkDetail"), for: .normal)

                }
            }
        }
        return cell
    }
    //MARK: - Task Delete

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            self.addItemViewModel.toDoList.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            self.addItemView.tableViewHeight?.constant = CGFloat(50 * self.addItemViewModel.toDoList.count)
            UIView.animate(withDuration: 1.0) {
                
                self.addItemView.mainView.layoutIfNeeded()
        
            }
       
        }
        self.addItemView.tableView.reloadData()
        print(addItemViewModel.toDoList)
    }
    
}

