//
//  AddItemVC.swift
//  noteor
//
//  Created by Emir AKSU on 17.02.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Speech

class AddItemVC: UIViewController, UITextFieldDelegate, SFSpeechRecognizerDelegate, UserViewModelDelegate, AddItemViewDelegate {
    func descrSpeechClicked(textField: UITextView, button: UIButton) {
        speechRec.configureAudioEngine(textField: nil, button: button, textView: textField)
    }
    
    func updateSucces() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func titleSpeechClicked(textField : UITextField, button : UIButton) {
        speechRec.configureAudioEngine(textField: textField, button: button, textView: nil)
    }
 
    func setData(note: Notes) {
        saveButton.isEnabled = false
        editButton.isEnabled = true
        addItemView.startDate.text = note.StartDate.formatted(date: .complete, time: .omitted)
        addItemView.startTime.text  = note.StartTime.formatted(date: .omitted, time: .shortened)
        addItemView.endDate.text  = note.EndDate.formatted(date: .complete, time: .omitted)
        addItemView.endTime.text  = note.EndTime.formatted(date: .omitted, time: .shortened)
        addItemView.titleInput.text  = note.Title
        addItemView.noteInput.text  = note.Descr
        //toDoList = note.tasks
        addItemViewModel.toDoList = note.tasks
        updateTodo()
    }
    
    
    func deleteSucces() {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func makeAlert(alertTitle: String, alertLabel: String) {
        makeEAAlert(alertTitle: alertTitle, alertLabel: alertLabel)
    }
    
    func updateTodo() {
        DispatchQueue.main.async {
            
            self.addItemView.tableViewHeight?.constant = CGFloat(50 * self.addItemViewModel.toDoList.count)
            
            
            UIView.animate(withDuration: 1.0) {
                
                self.addItemView.mainView.layoutIfNeeded()
                
                self.addItemView.taskTextField.text = ""
            }
            
            self.addItemView.tableView.reloadData()
            
        }
    }
    
    func didTapAddButton() {
        addItemViewModel.toDoAddTapped(taskText: addItemView.taskTextField.text!)
        print("addclicked")
    }
    
    
    func saveSucces() {
        self.navigationController?.popViewController(animated: true)
    }
    
    var addItemView: AddItemView! {
        return self.view as? AddItemView
    }
    
    
    //TO MVVM
    let noteCategories = ["Work","Food","Gym"]
    var selectedCateg : String?
    let speechRec = SpeechRecognitionManager()
    let addItemViewModel : AddItemViewModel
    
    
    init(addItemViewModel: AddItemViewModel) {
        self.addItemViewModel = addItemViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = AddItemView()
        addItemView.tableView.delegate = self
        addItemView.tableView.dataSource = self
        addItemView.delegate = self
        addItemViewModel.delegate = self
        self.addItemViewModel.setDataIfExist()

        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    print("Speech recognition authorized")
                case .denied:
                    print("User denied access to speech recognition")
                case .restricted:
                    print("Speech recognition restricted on this device")
                case .notDetermined:
                    print("Speech recognition not yet authorized")
                @unknown default:
                    fatalError()
                }
            }
        }
        
        configureUI()
        dismissKeyboardOnTouch()
        
        
    }
    
    //MARK: - Configure UI
    private func configureUI(){
        
        
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        
    }
    
    //MARK: -  NavigationBar
    lazy var saveButton =  UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .done, target: self, action:  #selector(saveButtonClicked))
    
    
    
    lazy var  editButton : UIBarButtonItem = {
        let editButton =  UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .done, target: self, action:  #selector(editButtonClicked))
        editButton.isEnabled = false
        return editButton
    }()
    
    lazy var  trashButton =  UIBarButtonItem(image: UIImage(systemName: "trash"), style: .done, target: self, action: #selector(trashButtonClicked))
    private func configureNavigationBar(){
        
        let topRightButtons = [saveButton,editButton,trashButton]
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Add Note"
        self.navigationItem.rightBarButtonItems = topRightButtons
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow-left")!.resized(toWidth: 40), style: .done, target: self, action: #selector(backButtonClicked))
    }
    
    @objc func trashButtonClicked(){
        self.addItemViewModel.delete()
    }
    @objc func editButtonClicked(){
        
        self.addItemViewModel.update(title: addItemView.titleInput.text!, categ: "Gym", descr: addItemView.noteInput.text!, endDate: addItemView.endDate.text?.turnToDate() ?? Date(), endTime: addItemView.endTime.text?.turnToHour() ?? Date(), startDate: addItemView.startDate.text?.turnToDate() ?? Date(), startTime: addItemView.startTime.text?.turnToHour() ?? Date(), isCompleted: "doing", createDate: Date(), tasks: addItemViewModel.toDoList, id: addItemViewModel.note!.id!)
        
       
    }
    
    @objc func backButtonClicked(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func saveButtonClicked(){
        
        print("saved")
        addItemViewModel.post(title: addItemView.titleInput.text!, categ: selectedCateg!, descr: addItemView.noteInput.text!, endDate: addItemView.endDate.text?.turnToDate() ?? Date(), endTime: addItemView.endTime.text?.turnToHour() ?? Date(), startDate: addItemView.startDate.text?.turnToDate() ?? Date(), startTime: addItemView.startTime.text?.turnToHour() ?? Date(), isCompleted: "doing", createDate: Date(), tasks: addItemViewModel.toDoList)
        
    }
}
