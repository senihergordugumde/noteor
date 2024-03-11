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

class AddItemVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, SFSpeechRecognizerDelegate{
  
    let speechButton = EAButton(title: " ", backgroundColor: .clear, cornerRadius: 15)
    
    let noteCategories = ["Work","Food","Gym"]
    var selectedCateg : String?
    
    
    
    var note : Notes?
  
    let pickerView = UIPickerView()
    
    let speechRec = SpeechRecognitionManager()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
        
        configure()
        setData()
        
      

    }
    

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
    
    
    //MARK: - Configure UI
    private func configure(){
        let saveButton =  UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .done, target: self, action:  #selector(saveClicked))
        
        let editButton =  UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .done, target: self, action:  #selector(editClicked))

        let trashButton =  UIBarButtonItem(image: UIImage(systemName: "trash"), style: .done, target: self, action: #selector(trashClicked))
        let topRightButtons = [saveButton,editButton,trashButton]

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Add Note"
        
        view.backgroundColor = .systemBackground
        
  
        
        self.navigationItem.rightBarButtonItems = topRightButtons
        self.navigationController?.isNavigationBarHidden = false
       
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow-left")!.resized(toWidth: 40), style: .done, target: self, action: #selector(backButton))
        configureBackground(view: mainView)
        configureTitleInput()
        configureTodoAdd()
        configureNoteInput()
        //configurePickerView()
        configureScrollView()
        configureStartDate()
        configureEndDate()
        configureStartTime()
        configureEndTime()
    }
    
    @objc func backButton(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
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
    
    //MARK: - MainView
    private let mainView : UIView = {
     
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1000).isActive = true
        return view
        
    }()
    
    //MARK: - SetDATA

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
    //MARK: - PickerView

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
    
    
    
    private func configurePickerView(){
        
    
        mainView.addSubview(pickerView)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            pickerView.trailingAnchor.constraint(equalTo: noteInput.trailingAnchor),
            pickerView.topAnchor.constraint(equalTo: noteInput.bottomAnchor, constant: 20),
            pickerView.leadingAnchor.constraint(equalTo: noteInput.leadingAnchor, constant: 100),
            pickerView.heightAnchor.constraint(equalToConstant: 60)
        
        ])
        
        guard let selectedCateg = selectedCateg else { return }
        
        
        
    }
    
  
    
    //MARK: - TitleInput
    let titleText = EATitle(textAlignment: .left, fontSize: 24)

    let titleInput = EATextField(placeholder: "Notes Title", isSecureTextEntry: false, textAlignment: .center)
    private func configureTitleInput(){
        titleText.text = "Task Title*"
        mainView.addSubview(titleText)
        mainView.addSubview(titleInput)
        mainView.addSubview(speechButton)
        NSLayoutConstraint.activate([
            
            titleText.bottomAnchor.constraint(equalTo: titleInput.topAnchor, constant: -20),
            titleText.leadingAnchor.constraint(equalTo: titleInput.leadingAnchor),
            titleText.heightAnchor.constraint(equalToConstant: 30),
            titleText.widthAnchor.constraint(equalToConstant: 200)
        
        ])
        
        let titleLogo = UIImageView(frame: CGRectMake(10, 0, 20, 20))
        titleLogo.image = UIImage(named: "titleTag")?.resized(toWidth: 100)
        
      

        titleInput.backgroundColor = .systemGray6
        titleInput.leftViewMode = .always
        titleInput.leftView = titleLogo
        titleInput.layer.borderWidth = 0
        
        speechButton.setImage(UIImage(named: "mic"), for: .normal)
        NSLayoutConstraint.activate([
        
            speechButton.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: 80),
            speechButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            speechButton.widthAnchor.constraint(equalToConstant: 50),
            speechButton.heightAnchor.constraint(equalToConstant: 50)
        
        
        ])
        
        NSLayoutConstraint.activate([
            
            titleInput.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: 80),
            
            titleInput.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            titleInput.trailingAnchor.constraint(equalTo: speechButton.leadingAnchor, constant: -20),
            titleInput.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
        
        speechButton.addTarget(self, action: #selector(speech), for: .touchUpInside)
       
    }
     
    
    @objc func speech(){
      
        speechRec.configureAudioEngine(textField: titleInput, button: speechButton)
        
    }
    
    //MARK: - Todo Add
    
    let tableView = UITableView()

    var tableViewHeight : NSLayoutConstraint?
    var toDoList = [tasks]()
    
    let addButton = EAButton(title: "", backgroundColor: .clear, cornerRadius: 0)
    
    let todoTextField = EATextField(placeholder: "Enter Your Task 🥹", isSecureTextEntry: false, textAlignment: .center)
    
    
    private func configureTableView(){
        //MARK: - Configure Todo tableView

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(toDoCell.self, forCellReuseIdentifier: toDoCell.id)
        
        mainView.addSubview(tableView)
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: todoTextField.bottomAnchor, constant: 20),
            
            tableView.leadingAnchor.constraint(equalTo: todoTextField.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: todoTextField.trailingAnchor),
            
        ])
        
        tableViewHeight = tableView.heightAnchor.constraint(equalToConstant: 0)
        
        tableViewHeight?.isActive = true
    }
    
    
    
    //MARK: -  Todo Table View Delegate

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: toDoCell.id, for: indexPath) as! toDoCell
        
        cell.set(task: toDoList[indexPath.row])
        
        cell.action = {
            
            if self.toDoList[indexPath.row].taskStatus {
                self.toDoList[indexPath.row].taskStatus = false
                
                DispatchQueue.main.async {
                    cell.deleteButton.setImage(UIImage(named: "closeDetail"), for: .normal)

                }

            }
            
            else {
                self.toDoList[indexPath.row].taskStatus = true
                
                DispatchQueue.main.async {
                    cell.deleteButton.setImage(UIImage(named: "checkDetail"), for: .normal)

                }


            }

        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        
        if editingStyle == .delete{
            
            
            
            self.toDoList.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            self.tableViewHeight?.constant = CGFloat(50 * self.toDoList.count)
            UIView.animate(withDuration: 1.0) {
                
                self.mainView.layoutIfNeeded()
                
    
            
            }
            
            
            
        }
        self.tableView.reloadData()
    }
    
    
    let taskAddText = EATitle(textAlignment: .left, fontSize: 24)

    private func configureTodoAdd(){
        //MARK: - Configure Todo Add
        taskAddText.text = "Task Add"
        addButton.setImage(UIImage(named: "add"), for: .normal)
        
        mainView.addSubview(addButton)
        mainView.addSubview(todoTextField)
        mainView.addSubview(taskAddText)
        
        NSLayoutConstraint.activate([
            
            taskAddText.leadingAnchor.constraint(equalTo: titleInput.leadingAnchor),
            taskAddText.topAnchor.constraint(equalTo: titleInput.bottomAnchor, constant: 20),
            taskAddText.heightAnchor.constraint(equalToConstant: 28),
            taskAddText.widthAnchor.constraint(equalToConstant: 200),
        
            addButton.topAnchor.constraint(equalTo: taskAddText.bottomAnchor, constant: 20),
            addButton.leadingAnchor.constraint(equalTo: titleInput.leadingAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 60),
            addButton.heightAnchor.constraint(equalToConstant: 60)
        
        
        ])
        
        addButton.addTarget(self, action: #selector(todoAddClicked), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
        
            todoTextField.topAnchor.constraint(equalTo: addButton.topAnchor),
            todoTextField.trailingAnchor.constraint(equalTo: titleInput.trailingAnchor),
            todoTextField.leadingAnchor.constraint(equalTo: addButton.trailingAnchor, constant: 20),
            todoTextField.heightAnchor.constraint(equalToConstant: 40)
        
        
        ])
        
        todoTextField.backgroundColor = .systemGray6
        todoTextField.leftViewMode = .always
        todoTextField.layer.borderWidth = 0
        
     
        configureTableView()
        
    }

    
    @objc func todoAddClicked(){
        //MARK: - Todo Add Clicked

        if let todo = todoTextField.text, !todo.isEmpty {
            
            toDoList.append(tasks(taskName: todo, taskStatus: false))
            
            
            DispatchQueue.main.async {
      
                self.tableViewHeight?.constant = CGFloat(50 * self.toDoList.count)
                UIView.animate(withDuration: 1.0) {
                    
                    self.mainView.layoutIfNeeded()
                }
                
                self.tableView.reloadData()

            }
                
            
        }else{
            makeEAAlert(alertTitle: "Text Is Empty", alertLabel: "Task Text Cannot Be Empty 🥲")
        }
    }
    
    
        
    //MARK: - NoteInput
    let noteInput = EATextView(placeholder: "")
    let descrText = EATitle(textAlignment: .left, fontSize: 24)
    let image = UIImageView(image: UIImage(named: "description"))
    
    private func configureNoteInput(){
        descrText.text = "Description"
        
        mainView.addSubview(noteInput)
        mainView.addSubview(image)
        mainView.addSubview(descrText)
        image.translatesAutoresizingMaskIntoConstraints = false
        noteInput.backgroundColor = .systemGray6
        noteInput.layer.borderWidth = 0
        NSLayoutConstraint.activate([
            
            descrText.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            descrText.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            descrText.heightAnchor.constraint(equalToConstant: 28),
            descrText.widthAnchor.constraint(equalToConstant: 200),
            
            
            noteInput.topAnchor.constraint(equalTo: descrText.bottomAnchor, constant: 20),
            noteInput.leadingAnchor.constraint(equalTo: titleInput.leadingAnchor,constant: 50),
            noteInput.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            noteInput.heightAnchor.constraint(equalToConstant: 200),
            
            image.topAnchor.constraint(equalTo: noteInput.topAnchor),
            image.leadingAnchor.constraint(equalTo: titleInput.leadingAnchor),
            image.widthAnchor.constraint(equalToConstant: 35),
            image.heightAnchor.constraint(equalToConstant: 35)
            
            
            
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
            endDate.trailingAnchor.constraint(equalTo: noteInput.trailingAnchor),
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
                .addDocument(from: Notes(Title: titleInput.text!, Color: EditVC.selectedColor , Descr: noteInput.text!, Lock:EditVC.lock, Categ: self.selectedCateg ?? self.noteCategories[0], StartDate: startDate.text?.turnToDate() ?? Date(), EndDate : endDate.text?.turnToDate() ?? Date(), StartTime: startTime.text?.turnToHour() ?? Date(), EndTime: endTime.text?.turnToHour() ??  Date(), tasks: toDoList))
            
            
            
            
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
