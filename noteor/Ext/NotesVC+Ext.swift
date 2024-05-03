//
//  NotesVC+Ext.swift
//  noteor
//
//  Created by Emir AKSU on 19.03.2024.
//

import Foundation
import UIKit

extension NotesVC : UITextFieldDelegate {
    
   
}
extension NotesVC : UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCell.id, for: indexPath) as! TaskCell
        if var note = viewModel.note(at: indexPath.row) {
            cell.backgroundColor = UIColor(named: "DarkGray")
            cell.set(note: note)
            cell.action = { [weak self] in
                if note.isCompleted == "done"{
                    cell.statusButton.setImage(UIImage(named: "Doing"), for: .normal)
                    note.isCompleted = "doing"
                    
                    self?.viewModel.updateNotes(id: note.id!, data: ["isCompleted" : note.isCompleted])

                } else {
                    
                    cell.statusButton.setImage(UIImage(named: "done"), for: .normal)
                    note.isCompleted = "done"
                    
                    self?.viewModel.updateNotes(id: note.id!, data: ["isCompleted" : note.isCompleted])
                    
                }
            }
            
        }
        
        
        return cell

        
        }
      

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if let note = viewModel.note(at: indexPath.row){
            
            let postService : PostService = Post()
            let deleteService : DeleteService = Delete()
            let updateService : UpdateService = Update()
            let viewModel = AddItemViewModel(postService: postService as! Post, deleteService: deleteService as! Delete, updateService: updateService as! Update)
           
            let destinationVC = AddItemVC(addItemViewModel: viewModel)
            
            
            viewModel.note = note
            
            
            
            /*guard note.Lock == false else{
                
                makeEAAlertTextField(alertTitle: "Locked"){
                    self.navigationController?.pushViewController(destinationVC, animated: true)
                }
          
                return
            }*/
            
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
        
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.notesCount
       
   
  
    }
}
