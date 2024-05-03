//
//  AddItemViewModel.swift
//  noteor
//
//  Created by Emir AKSU on 23.04.2024.
//

import Foundation

protocol UserViewModelDelegate : AnyObject{
    func saveSucces()
    func makeAlert(alertTitle: String , alertLabel: String)
    func updateTodo()
    func deleteSucces()
    func setData(note : Notes)
    func updateSucces()
}

class AddItemViewModel {
    
    var toDoList = [tasks]()
    var note : Notes?
    
    func setDataIfExist(){
        guard let note = note else { return }
        self.delegate?.setData(note: note)
        
    }
    
    var tableViewHeight : CGFloat {
        return CGFloat(50 * toDoList.count)
    }
    
    func toDoAddTapped(taskText : String){
        
        if taskText != "" {
            
            toDoList.append(tasks(taskName: taskText, taskStatus: false))
            
            self.delegate?.updateTodo()
            
        }else{
            
            self.delegate?.makeAlert(alertTitle: "Text Is Empty", alertLabel: "Task Text Cannot Be Empty 🥲")
            
        }
    }

    //MARK: - Service
   
    private let postService : Post
    private let deleteService : Delete
    private let updateService : Update
    weak var delegate : UserViewModelDelegate?
    
    init(postService: Post, deleteService : Delete, updateService : Update) {
        self.postService = postService
        self.deleteService = deleteService
        self.updateService = updateService
    }
    
    func update(title: String, categ: String, descr: String, endDate: Date, endTime: Date, startDate: Date, startTime: Date, isCompleted: String, createDate: Date, tasks : [tasks], id : String){
     
        let taskDict = tasks.map { $0.toDict() }
        
        let data = [
        
            "Title" : title,
            "Categ" : categ,
            "Descr" : descr,
            "EndDate" : endDate,
            "EndTime" : endTime,
            "StartDate" : startDate,
            "StartTime" : startTime,
            "isCompleted" : isCompleted,
            "createDate" : createDate,
            "tasks" : taskDict
        
        ] as [AnyHashable : Any]
        
        
        updateService.updateNote(id: id, data: data) { result in
            
            switch result {
            case .success():
                self.delegate?.updateSucces()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
    }
    
    
    func post(title: String, categ: String, descr: String, endDate: Date, endTime: Date, startDate: Date, startTime: Date, isCompleted: String, createDate: Date, tasks : [tasks]){
        
        if (title.isEmpty || descr.isEmpty) {
            self.delegate?.makeAlert(alertTitle: "Fill your note", alertLabel: "Your note Cannot Be Empty 🥲")
            return
        }
        
        postService.createNote(title: title, categ: categ, descr: descr, endDate: endDate, endTime: endTime, startDate: startDate, startTime: startTime, isCompleted: isCompleted, createDate: createDate, tasks: tasks){ Result in
            
            switch Result{
                case .success(_ ):
                    print("Note Created")
                    self.delegate?.saveSucces()
                case .failure(let error):
                    print("Save başarısız")
                }
            
        }
    
    }
    
    func delete(){
        guard let note = note else {
            print("not yok")
            return}
        deleteService.deleteNote(note: note) { result in
            switch result {
            case .success():
                self.delegate?.deleteSucces()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
