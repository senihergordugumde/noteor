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

class AddItemVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, SFSpeechRecognizerDelegate{
    
    
    //TO MVVM
    let noteCategories = ["Work","Food","Gym"]
    var selectedCateg : String?
    var note : Notes?
    let speechRec = SpeechRecognitionManager()
    
  
    //MARK: - Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        setData()
        dismissKeyboardOnTouch()
      

    }
    
    //MARK: - Configure UI
    private func configureUI(){
       
        
        view.backgroundColor = .systemBackground
        
        
        
        configureNavigationBar()
        configureBackground(view: mainView)
        configureScrollView()
        configureTitleInput()
        configureTaskAdd()
        configureNoteInput()
        //configureStartDate()
        //configureEndDate()
        //configureStartTime()
        //configureEndTime()
   
    }
    
    
    //MARK: - Background Configure
    private func configureAddItemsBackground(){
            
            var yellowTopImage : UIImageView={
                let imageView = UIImageView(image: UIImage(named: "back-blur"))
                imageView.translatesAutoresizingMaskIntoConstraints = false
                
                return imageView
            }()
            
            view.insertSubview(yellowTopImage, at: 0)
            NSLayoutConstraint.activate([
                
                yellowTopImage.topAnchor.constraint(equalTo: navigationController?.navigationBar.topAnchor ?? view.topAnchor, constant: -150),
                yellowTopImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                yellowTopImage.widthAnchor.constraint(equalToConstant: 250),
                yellowTopImage.heightAnchor.constraint(equalToConstant: 200)
                
            ])
            
            
            var redTopImage : UIImageView={
                let imageView = UIImageView(image: UIImage(named: "red-blur"))
                imageView.translatesAutoresizingMaskIntoConstraints = false
                
                return imageView
            }()
            
            view.insertSubview(redTopImage, at: 0)
            NSLayoutConstraint.activate([
                
                redTopImage.topAnchor.constraint(equalTo: navigationController?.navigationBar.topAnchor ?? view.topAnchor, constant: -150),
                redTopImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                redTopImage.widthAnchor.constraint(equalToConstant: 250),
                redTopImage.heightAnchor.constraint(equalToConstant: 300)
                
            ])
            
            
            
            var redBottomImage : UIImageView={
                let imageView = UIImageView(image: UIImage(named: "redBottom"))
                imageView.translatesAutoresizingMaskIntoConstraints = false
                
                return imageView
            }()
            
            view.insertSubview(redBottomImage, at: 0)
            NSLayoutConstraint.activate([
                
                redBottomImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                redBottomImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                redBottomImage.widthAnchor.constraint(equalToConstant: 250),
                redBottomImage.heightAnchor.constraint(equalToConstant: 120)
                
            ])
            
            
      
    }
    
    
   
    
    
    
    //MARK: -  NavigationBar

    private func configureNavigationBar(){
        let saveButton =  UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .done, target: self, action:  #selector(saveClicked))
        
        let editButton =  UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .done, target: self, action:  #selector(editClicked))

        let trashButton =  UIBarButtonItem(image: UIImage(systemName: "trash"), style: .done, target: self, action: #selector(trashClicked))
        let topRightButtons = [saveButton,editButton,trashButton]

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Add Note"
        
        
        self.navigationItem.rightBarButtonItems = topRightButtons
        self.navigationController?.isNavigationBarHidden = false
       
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow-left")!.resized(toWidth: 40), style: .done, target: self, action: #selector(backButton))
    }
    
    
    @objc func backButton(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: - MainView
    public let mainView : UIView = {
     
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1000).isActive = true
        return view
        
    }()
    
    //MARK: - Scrollview
    private let scrollView : UIScrollView = {
       
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
       
        
        
    }()
    
    private func configureScrollView(){
        
        view.addSubview(scrollView)
        scrollView.addSubview(mainView)
        
        NSLayoutConstraint.activate([
        
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        
        ])
        
        NSLayoutConstraint.activate([
        
            mainView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        
        ])
        
    }
    
 
    //MARK: - SetDATA
    //TO MVVM
    private func setData(){
        guard let note = note else {return}
        
        startDate.text = note.StartDate.formatted(date: .complete, time: .omitted)
        startTime.text = note.StartTime.formatted(date: .omitted, time: .shortened)
        endDate.text = note.EndDate.formatted(date: .complete, time: .omitted)
        endTime.text = note.EndTime.formatted(date: .omitted, time: .shortened)

        titleInput.text = note.Title
        noteInput.text = note.Descr
        EditVC.lock = note.Lock
        EditVC.selectedColor = note.Color
        toDoList = note.tasks
        DispatchQueue.main.async {
            self.tableViewHeight?.constant = CGFloat(50 * self.toDoList.count)

            self.tableView.reloadData()
            self.mainView.layoutIfNeeded()
        }
    
    }
    
  
    
    //MARK: - Set Title Input
    private func configureTitleInput(){
        configureTitleSpeechButton()
        configureTitleField()
        configureTitleText()
       
       
    }
    
    
                //MARK: - Configure Title Text

                let titleText = EATitle(textAlignment: .left, fontSize: 24)
                private func configureTitleText(){
                    titleText.text = "Task Title*"
                    mainView.addSubview(titleText)
                    
                    
                    NSLayoutConstraint.activate([
                        
                        titleText.bottomAnchor.constraint(equalTo: titleInput.topAnchor, constant: -20),
                        titleText.leadingAnchor.constraint(equalTo: titleInput.leadingAnchor),
                        titleText.heightAnchor.constraint(equalToConstant: 30),
                        titleText.widthAnchor.constraint(equalToConstant: 200)
                    
                    ])
                }
                //MARK: - Configure Title Field

                let titleInput = EATextField(placeholder: "Notes Title", isSecureTextEntry: false, textAlignment: .center)
                private func configureTitleField(){
                    mainView.addSubview(titleInput)
                    
                    let titleLogo = UIImageView(frame: CGRectMake(10, 0, 20, 20))
                    titleLogo.image = UIImage(named: "titleTag")?.resized(toWidth: 100)
                    
                    titleInput.backgroundColor = .systemGray6
                    titleInput.leftViewMode = .always
                    titleInput.leftView = titleLogo
                    titleInput.layer.borderWidth = 0
                    NSLayoutConstraint.activate([
                        
                        titleInput.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: 80),
                        
                        titleInput.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
                        titleInput.trailingAnchor.constraint(equalTo: titleSpeechButton.leadingAnchor, constant: -20),
                        titleInput.heightAnchor.constraint(equalToConstant: 50)
                        
                        
                    ])

                }
                //MARK: - Configure Title Speech Button
                let titleSpeechButton = EAButton(title: " ", backgroundColor: .clear, cornerRadius: 15)
                private func configureTitleSpeechButton(){
                    mainView.addSubview(titleSpeechButton)
                    
                    //Speech Button Config
                    titleSpeechButton.setImage(UIImage(named: "mic"), for: .normal)
                    NSLayoutConstraint.activate([
                    
                        titleSpeechButton.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: 80),
                        titleSpeechButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
                        titleSpeechButton.widthAnchor.constraint(equalToConstant: 50),
                        titleSpeechButton.heightAnchor.constraint(equalToConstant: 50)
                    
                    
                    ])
                    
                    
                    
                    titleSpeechButton.addTarget(self, action: #selector(titleSpeechButtonClicked), for: .touchUpInside)
                }

             
                @objc func titleSpeechButtonClicked(){
                  
                    speechRec.configureAudioEngine(textField: titleInput, button: titleSpeechButton, textView: nil)
                    
                }
    
    
    
    //MARK: - Set Task Add

    private func configureTaskAdd(){
        configureTaskText()
        configureTaskAddButton()
        configureTaskTextField()
        configureTableView()
    }
    
                    //MARK: - Task Add Button
                    let addButton = EAButton(title: "", backgroundColor: .clear, cornerRadius: 0)

                    private func configureTaskAddButton(){
                        addButton.setImage(UIImage(named: "add"), for: .normal)
                        
                        mainView.addSubview(addButton)
                        NSLayoutConstraint.activate([
                            
                          
                            addButton.topAnchor.constraint(equalTo: taskAddText.bottomAnchor, constant: 20),
                            addButton.leadingAnchor.constraint(equalTo: titleInput.leadingAnchor),
                            addButton.widthAnchor.constraint(equalToConstant: 60),
                            addButton.heightAnchor.constraint(equalToConstant: 60)
                        
                        
                        ])
                        
                        addButton.addTarget(self, action: #selector(todoAddClicked), for: .touchUpInside)

                    }
                    
                    
                    //MARK: - Task Text Field
                    let taskTextField = EATextField(placeholder: "Enter Your Task 🥹", isSecureTextEntry: false, textAlignment: .center)
                    private func configureTaskTextField(){
                        mainView.addSubview(taskTextField)
                        
                        NSLayoutConstraint.activate([
                        
                            taskTextField.topAnchor.constraint(equalTo: addButton.topAnchor),
                            taskTextField.trailingAnchor.constraint(equalTo: titleSpeechButton.trailingAnchor),
                            taskTextField.leadingAnchor.constraint(equalTo: addButton.trailingAnchor, constant: 20),
                            taskTextField.heightAnchor.constraint(equalToConstant: 40)
                        
                        
                        ])
                        
                        taskTextField.backgroundColor = .systemGray6
                        taskTextField.leftViewMode = .always
                        taskTextField.layer.borderWidth = 0
                    }
                    
                    //MARK: - Task Text
                    let taskAddText = EATitle(textAlignment: .left, fontSize: 24)

                    private func configureTaskText(){
                     
                        taskAddText.text = "Task Add"
                      
                        
                        mainView.addSubview(taskAddText)
                        
                        NSLayoutConstraint.activate([
                            
                            taskAddText.leadingAnchor.constraint(equalTo: titleInput.leadingAnchor),
                            taskAddText.topAnchor.constraint(equalTo: titleInput.bottomAnchor, constant: 20),
                            taskAddText.heightAnchor.constraint(equalToConstant: 28),
                            taskAddText.widthAnchor.constraint(equalToConstant: 200),
                       
                        
                        ])
                        

                    }

                    //MARK: - Todo Add Clicked

                    @objc func todoAddClicked(){
                        //TO MVVM

                        if let todo = taskTextField.text, !todo.isEmpty {
                            
                            toDoList.append(tasks(taskName: todo, taskStatus: false))
                            
                            
                            DispatchQueue.main.async {
                      
                                self.tableViewHeight?.constant = CGFloat(50 * self.toDoList.count)
                                UIView.animate(withDuration: 1.0) {
                                    
                                    self.mainView.layoutIfNeeded()
                                    
                                    self.taskTextField.text = ""
                                }
                                
                                self.tableView.reloadData()

                            }
                                
                            
                        }else{
                            makeEAAlert(alertTitle: "Text Is Empty", alertLabel: "Task Text Cannot Be Empty 🥲")
                        }
                    }
                    
                    
                    //MARK: - Todo Add
                    
                    let tableView = UITableView()

                    var tableViewHeight : NSLayoutConstraint?
                    var toDoList = [tasks]()
                    
                  
                    
                    //MARK: - Task TableView
                    private func configureTableView(){
                        

                        tableView.translatesAutoresizingMaskIntoConstraints = false
                        tableView.delegate = self
                        tableView.dataSource = self
                        tableView.backgroundColor = .white
                        tableView.register(toDoCell.self, forCellReuseIdentifier: toDoCell.id)
                        
                        mainView.addSubview(tableView)
                        NSLayoutConstraint.activate([
                        
                            tableView.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 20),
                            
                            tableView.leadingAnchor.constraint(equalTo: taskTextField.leadingAnchor),
                            tableView.trailingAnchor.constraint(equalTo: taskTextField.trailingAnchor),
                            
                        ])
                        
                        tableViewHeight = tableView.heightAnchor.constraint(equalToConstant: 0)
                        
                        tableViewHeight?.isActive = true
                    }
                    
                   
              
    
    
    //MARK: - Configure Note Input

    private func configureNoteInput(){
        noteInputText()
        noteInputImage()
        noteInputSpeech()
        noteInputField()
    
       
        
      
        
     
    }
    
                        //MARK: - Note Input Text
                        let descrText = EATitle(textAlignment: .left, fontSize: 24)

                        private func noteInputText(){
                            mainView.addSubview(descrText)
                            descrText.text = "Description"
                            NSLayoutConstraint.activate([
                            
                                descrText.leadingAnchor.constraint(equalTo: titleInput.leadingAnchor),
                                descrText.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
                                descrText.heightAnchor.constraint(equalToConstant: 28),
                                descrText.widthAnchor.constraint(equalToConstant: 200),
                            ])

                        }

                        //MARK: - Note Input Image
                        let image = UIImageView(image: UIImage(named: "description"))
                        
                        private func noteInputImage(){
                            
                            
                            mainView.addSubview(image)

                            image.translatesAutoresizingMaskIntoConstraints = false
                            
                            NSLayoutConstraint.activate([
                              
                                image.topAnchor.constraint(equalTo: descrText.bottomAnchor, constant: 5),
                                image.leadingAnchor.constraint(equalTo: descrText.leadingAnchor),
                                image.widthAnchor.constraint(equalToConstant: 35),
                                image.heightAnchor.constraint(equalToConstant: 35)
                         ])

                        }

    
    
                      //MARK: - Note Input Speech
                      let descrSpeechButton = EAButton(title: " ", backgroundColor: .clear, cornerRadius: 15)

                      private func noteInputSpeech(){
                          mainView.addSubview(descrSpeechButton)
                          descrSpeechButton.setImage(UIImage(named: "mic"), for: .normal)
                          NSLayoutConstraint.activate([
                          
                              descrSpeechButton.topAnchor.constraint(equalTo: image.topAnchor),
                              descrSpeechButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
                              descrSpeechButton.widthAnchor.constraint(equalToConstant: 50),
                              descrSpeechButton.heightAnchor.constraint(equalToConstant: 50)
                          ])
                          
                          descrSpeechButton.addTarget(self, action: #selector(descrSpeechButtonClicked), for: .touchUpInside)

                      }
                      
                      @objc func descrSpeechButtonClicked(){
                          self.speechRec.configureAudioEngine(textField: nil, button: descrSpeechButton, textView: noteInput)
                      }
                      
      
    
                        //MARK: - NoteInput
                        let noteInput = EATextView(placeholder: "")
                        private func noteInputField(){
                            mainView.addSubview(noteInput)
                            noteInput.backgroundColor = .systemGray6
                            noteInput.layer.borderWidth = 0
                            NSLayoutConstraint.activate([
                                
                            noteInput.topAnchor.constraint(equalTo: descrText.bottomAnchor, constant: 20),
                            noteInput.leadingAnchor.constraint(equalTo: titleInput.leadingAnchor,constant: 50),
                            noteInput.trailingAnchor.constraint(equalTo: descrSpeechButton.leadingAnchor, constant: -20),
                            noteInput.heightAnchor.constraint(equalToConstant: 200),

                        ])
                        }


    
                      
                       
    
                                          
                                           
                       
                        
                        
                       
  
    
    //MARK: - Start Date
    
    let startDate = EATextField(placeholder: "--/--", isSecureTextEntry: false, textAlignment: .center)
    let startDateText = EATitle(textAlignment: .left, fontSize: 16)
    
    private func configureStartDate(){
        startDate.delegate = self
        mainView.addSubview(startDateText)
        startDateText.text = "Start Date*"
       
        mainView.addSubview(startDate)
        startDate.backgroundColor = .clear
        startDate.layer.borderWidth = 1
        startDate.rightViewMode = .always
        startDate.rightView = UIImageView(image: UIImage(named: "calendar")?.resized(toWidth: 25))
        NSLayoutConstraint.activate([
            
            startDateText.topAnchor.constraint(equalTo: noteInput.bottomAnchor, constant: 20),
            startDateText.leadingAnchor.constraint(equalTo: startDate.leadingAnchor),
            startDateText.widthAnchor.constraint(equalToConstant: 100),
            startDateText.heightAnchor.constraint(equalToConstant: 20),

            
            startDate.topAnchor.constraint(equalTo: startDateText.bottomAnchor, constant: 20),
            startDate.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            startDate.widthAnchor.constraint(equalToConstant: 150),
            startDate.heightAnchor.constraint(equalToConstant: 60),
           
            
        ])
        
    }
    //MARK: - Start Time
    
    let startTime = EATextField(placeholder: "--:--", isSecureTextEntry: false, textAlignment: .center)
    let startTimeText = EATitle(textAlignment: .left, fontSize: 16)
    
    private func configureStartTime(){
        startTime.delegate = self
        mainView.addSubview(startTimeText)
        startTimeText.text = "Start Time*"
       
        mainView.addSubview(startTime)
        startTime.backgroundColor = .clear
        startTime.layer.borderWidth = 1
        startTime.rightViewMode = .always
        startTime.rightView = UIImageView(image: UIImage(named: "hourglass")?.resized(toWidth: 25))
        NSLayoutConstraint.activate([
            
            startTimeText.topAnchor.constraint(equalTo: startDate.bottomAnchor, constant: 20),
            startTimeText.leadingAnchor.constraint(equalTo: startDate.leadingAnchor),
            startTimeText.widthAnchor.constraint(equalToConstant: 100),
            startTimeText.heightAnchor.constraint(equalToConstant: 20),

            
            startTime.topAnchor.constraint(equalTo: startTimeText.bottomAnchor, constant: 20),
            
            startTime.leadingAnchor.constraint(equalTo: startTimeText.leadingAnchor),
            startTime.widthAnchor.constraint(equalToConstant: 150),
            startTime.heightAnchor.constraint(equalToConstant: 60),
           
            
        ])
        
    }
   
    //MARK: - End Date
    
    let endDate = EATextField(placeholder: "--/--", isSecureTextEntry: false, textAlignment: .center)

    let endDateText = EATitle(textAlignment: .left, fontSize: 16)

    private func configureEndDate(){
        endDate.delegate = self
        endTimeText.text = "End Date*"
        mainView.addSubview(endDate)
        mainView.addSubview(endDateText)
        endDate.backgroundColor = .clear
        endDate.layer.borderWidth = 1
        endDate.rightViewMode = .always

        endDate.rightView = UIImageView(image: UIImage(named: "calendar")?.resized(toWidth: 25))
        NSLayoutConstraint.activate([
            
            endDateText.topAnchor.constraint(equalTo: noteInput.bottomAnchor, constant: 20),
            endDateText.leadingAnchor.constraint(equalTo: endDate.leadingAnchor),
            endDateText.widthAnchor.constraint(equalToConstant: 100),
            endDateText.heightAnchor.constraint(equalToConstant: 20),

            
            
            endDate.topAnchor.constraint(equalTo: endDateText.bottomAnchor, constant: 20),
            
            endDate.widthAnchor.constraint(equalToConstant: 150),
            endDate.trailingAnchor.constraint(equalTo: descrSpeechButton.trailingAnchor),
            endDate.heightAnchor.constraint(equalToConstant: 60),
           
            
        ])
        
        
        
    }
    
    //MARK: - End Time

    let endTime = EATextField(placeholder: "--:--", isSecureTextEntry: false, textAlignment: .center)
    let endTimeText = EATitle(textAlignment: .left, fontSize: 16)
    
    private func configureEndTime(){
        endTime.delegate = self
        mainView.addSubview(endTimeText)
        endTimeText.text = "End Time*"
       
        mainView.addSubview(endTime)
        endTime.backgroundColor = .clear
        endTime.layer.borderWidth = 1
        endTime.rightViewMode = .always
        endTime.rightView = UIImageView(image: UIImage(named: "hourglas")?.resized(toWidth: 25))
        NSLayoutConstraint.activate([
            
            endTimeText.topAnchor.constraint(equalTo: endDate.bottomAnchor, constant: 20),
            endTimeText.leadingAnchor.constraint(equalTo: endDate.leadingAnchor),
            endTimeText.widthAnchor.constraint(equalToConstant: 100),
            endTimeText.heightAnchor.constraint(equalToConstant: 20),

            
            endTime.topAnchor.constraint(equalTo: endTimeText.bottomAnchor, constant: 20),
            
            endTime.leadingAnchor.constraint(equalTo: endTimeText.leadingAnchor),
            endTime.widthAnchor.constraint(equalToConstant: 150),
            endTime.heightAnchor.constraint(equalToConstant: 60),
           
            
        ])
        
    }
   
    //MARK: - DatePickerInputView
    
    var selectedField : UITextField?
    
    let datePicker = UIDatePicker()
    let toolbar = UIToolbar()
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        selectedField = textField
      

       
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClicked))
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelClicked))
        
        toolbar.setItems([doneButton, cancelButton], animated: true)
        
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        
        if selectedField?.placeholder == "--/--" {
            datePicker.datePickerMode = .date

        }else{
            datePicker.datePickerMode = .time

        }
        
    }
    
    @objc func doneClicked(){
        
        guard let selectedField = selectedField else { return }
        if selectedField.placeholder == "--/--" {

            selectedField.text = datePicker.date.formatted(date: .long , time: .omitted)


        }else{
            selectedField.text = datePicker.date.formatted(date: .omitted, time: .shortened)
            print(selectedField.text?.turnToHour())


        }
        self.view.endEditing(true)
        
    }
    
    @objc func cancelClicked(){
    
        self.view.endEditing(true)
        
    }
   
    
   //MARK: - RightBarButtons
    
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
        
        guard noteInput.text != "" else {
            makeEAAlert(alertTitle: "Error", alertLabel: "You must write a Note 📝")
            return
        }
        
        let firestore = Firestore.firestore()
        
        do{
            try firestore.collection("Users")
                .document((Auth.auth()
                .currentUser?.email)!)
                .collection("Notes")
                .addDocument(from: Notes(Title: titleInput.text!, Color: EditVC.selectedColor , Descr: noteInput.text!, Lock:EditVC.lock, Categ: self.selectedCateg ?? self.noteCategories[0], StartDate: startDate.text?.turnToDate() ?? Date(), EndDate : endDate.text?.turnToDate() ?? Date(), StartTime: startTime.text?.turnToHour() ?? Date(), EndTime: endTime.text?.turnToHour() ??  Date(), isCompleted: "doing", tasks: toDoList))
            
            
            
            
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
}
