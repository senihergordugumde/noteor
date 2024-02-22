//
//  AddItemVC.swift
//  noteor
//
//  Created by Emir AKSU on 17.02.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
class AddItemVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    
    let noteCategories = ["School","Work","Food","Sport","Special Days"]
    var selectedCateg : String?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return noteCategories.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        noteCategories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCateg = noteCategories[row]
    }
    
    var note : Notes?
  
    let titleInput = EATextField(placeholder: "Notes Title", isSecureTextEntry: false, textAlignment: .center)
    let noteInput = EATextView(placeholder: "Your Note Here")
    let pickerView = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setData()
    }
    
    private func setData(){
        guard let note = note else {return}
        titleInput.text = note.Title
        noteInput.text = note.Descr
        EditVC.lock = note.Lock
        EditVC.selectedColor = note.Color
        
    }
    
    private func configurePickerView(){
        view.addSubview(pickerView)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            pickerView.trailingAnchor.constraint(equalTo: noteInput.trailingAnchor),
            pickerView.topAnchor.constraint(equalTo: noteInput.bottomAnchor, constant: 20),
            pickerView.leadingAnchor.constraint(equalTo: noteInput.leadingAnchor, constant: 100),
            pickerView.heightAnchor.constraint(equalToConstant: 60)
        
        ])
        
    }
    
    private func configure(){
        let saveButton =  UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .done, target: self, action:  #selector(saveClicked))
        
        let editButton =  UIBarButtonItem(image: UIImage(systemName: "highlighter"), style: .done, target: self, action:  #selector(editClicked))

        let trashButton =  UIBarButtonItem(image: UIImage(systemName: "trash"), style: .done, target: self, action: #selector(trashClicked))
        let topRightButtons = [saveButton,editButton,trashButton]

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Add Note"
        
        view.backgroundColor = .systemBackground
        
  
        
        self.navigationItem.rightBarButtonItems = topRightButtons


        configureTitleInput()
        configureNoteInput()
        configurePickerView()
        
    }
    
    
    private func configureTitleInput(){
        view.addSubview(titleInput)
        titleInput.backgroundColor = .systemBackground
        
        
        NSLayoutConstraint.activate([
            
            titleInput.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            titleInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleInput.widthAnchor.constraint(equalToConstant: 300),
            titleInput.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
        
        
    }
    
    

    
    private func configureNoteInput(){
        view.addSubview(noteInput)
        
        
        NSLayoutConstraint.activate([
            
            noteInput.topAnchor.constraint(equalTo: titleInput.bottomAnchor, constant: 20),
            
            noteInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noteInput.widthAnchor.constraint(equalToConstant: 300),
            noteInput.heightAnchor.constraint(equalToConstant: 200)
            
            
        ])
        
        
    }
   
    
   
    
    @objc func editClicked(){
        let editVC = UINavigationController(rootViewController: EditVC())
        
        if let sheet = editVC.sheetPresentationController{
            
            sheet.detents = [.medium()]
            
        }
        
        self.present(editVC, animated: true)
        
        
    }
    
    
    @objc func saveClicked(){
        
        guard titleInput.text != "" else {
            makeEAAlert(alertTitle: "Error", alertLabel: "You must write a Title 📝")
            return
        }
        
        guard noteInput.text != "Your Note Here" else {
            makeEAAlert(alertTitle: "Error", alertLabel: "You must write a Note 📝")
            return
        }
        
        let firestore = Firestore.firestore()
        
        do{
            try firestore.collection("Users").document((Auth.auth().currentUser?.email)!).collection("Notes").addDocument(from: Notes(Title: titleInput.text!, Color: EditVC.selectedColor , Descr: noteInput.text!, Lock:EditVC.lock, Categ: self.selectedCateg!))
            
            
            
            
            titleInput.text = nil
            noteInput.text = nil
            
            self.navigationController?.popViewController(animated: true)

        } catch{
            print(error.localizedDescription)
        }
        
        
    }
    
    @objc func trashClicked(){
        
        guard let note = note else{
            makeEAAlert(alertTitle: "This note hasnt been created", alertLabel: "You should create a note for this feature 😊")
            return
        }
        let firestore = Firestore.firestore()
        
        do{
            
            try firestore.collection("Users").document((Auth.auth().currentUser?.email)!).collection("Notes").document(note.id ?? " ").delete()
            
        }
        
        catch{
            
            makeEAAlert(alertTitle: "Error", alertLabel: error.localizedDescription)
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
