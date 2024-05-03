//
//  AddItemView.swift
//  noteor
//
//  Created by Emir AKSU on 22.04.2024.
//

import UIKit

protocol AddItemViewDelegate : AnyObject {
    func didTapAddButton()
    func titleSpeechClicked(textField : UITextField, button : UIButton)
    func descrSpeechClicked(textField : UITextView ,button : UIButton)
}

class AddItemView: UIView {
    
    weak var delegate : AddItemViewDelegate?
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var yellowTopImage : UIImageView={
        let imageView = UIImageView(image: UIImage(named: "back-blur"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
  
    var redTopImage : UIImageView={
        let imageView = UIImageView(image: UIImage(named: "red-blur"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    var redBottomImage : UIImageView={
        let imageView = UIImageView(image: UIImage(named: "redBottom"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
   


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
        view.backgroundColor = UIColor(named: "DarkGray")
        return view
       
        
        
    }()
    
    
    let titleText = EATitle(textAlignment: .left, fontSize: 24)
    let titleInput = EATextField(placeholder: "Notes Title", isSecureTextEntry: false, textAlignment: .center)
    let titleSpeechButton = EAButton(title: " ", backgroundColor: .clear, cornerRadius: 15)
    
    
    let addButton = EAButton(title: "", backgroundColor: .clear, cornerRadius: 0)
    let taskAddText = EATitle(textAlignment: .left, fontSize: 24)
    let taskTextField = EATextField(placeholder: "Enter Your Task 🥹", isSecureTextEntry: false, textAlignment: .center)
    
    
    
    
    let tableView = UITableView()
    var tableViewHeight : NSLayoutConstraint?
    
    let descrText = EATitle(textAlignment: .left, fontSize: 24)
    let descrSpeechButton = EAButton(title: " ", backgroundColor: .clear, cornerRadius: 15)
    let image = UIImageView(image: UIImage(named: "description"))
    let noteInput = EATextView(placeholder: "")

    //START DATE
   
    let startDateText = EATitle(textAlignment: .left, fontSize: 16)
    let startDate : EATextField = {
        let startDate = EATextField(placeholder: "--/--", isSecureTextEntry: false, textAlignment: .center)
        
        startDate.makeDatePicker()
        
        return startDate

    }()
    
    
   
    
    //Start Time
    let startTimeText = EATitle(textAlignment: .left, fontSize: 16)
    let startTime : EATextField = {
        let startTime = EATextField(placeholder: "--:--", isSecureTextEntry: false, textAlignment: .center)
        
        startTime.makeTimePicker()
        
        return startTime
    }()
    
   
    
    //END DATE
    let endDateText = EATitle(textAlignment: .left, fontSize: 16)
    let endDate : EATextField = {
        let endDate = EATextField(placeholder: "--/--", isSecureTextEntry: false, textAlignment: .center)
        
        endDate.makeDatePicker()
        
        return endDate

    }()
    
    
   

    
    //END TİME
    
    let endTimeText = EATitle(textAlignment: .left, fontSize: 16)
    
    let endTime : EATextField = {
        let endTime = EATextField(placeholder: "--:--", isSecureTextEntry: false, textAlignment: .center)
        
        endTime.makeTimePicker()
        
        return endTime
    }()

    //MARK: - Setup
    
    func setupUI(){
       
        /*
        insertSubview(yellowTopImage, at: 0)
        
        UIKit.NSLayoutConstraint.activate([
            
            yellowTopImage.topAnchor.constraint(equalTo: topAnchor, constant: -150),
            yellowTopImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            yellowTopImage.widthAnchor.constraint(equalToConstant: 250),
            yellowTopImage.heightAnchor.constraint(equalToConstant: 200)
            
        ])
        
       insertSubview(redTopImage, at: 0)

        
        NSLayoutConstraint.activate([
            
            redTopImage.topAnchor.constraint(equalTo: topAnchor, constant: -150),
            redTopImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            redTopImage.widthAnchor.constraint(equalToConstant: 250),
            redTopImage.heightAnchor.constraint(equalToConstant: 300)
            
        ])
        
        
        insertSubview(redBottomImage, at: 0)
        NSLayoutConstraint.activate([
            
            redBottomImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            redBottomImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            redBottomImage.widthAnchor.constraint(equalToConstant: 250),
            redBottomImage.heightAnchor.constraint(equalToConstant: 120)
            
        ])
        
        */
        //SCROLL VİEW
        addSubview(scrollView)
        scrollView.addSubview(mainView)
        
        UIKit.NSLayoutConstraint.activate([
        
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        
        ])
        
        UIKit.NSLayoutConstraint.activate([
        
            mainView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        
        ])
        
        //TİTLE SPEECH BUTTON
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
       
        // TİTLE INPUT
        mainView.addSubview(titleInput)
        
        let titleLogo = UIImageView(frame: CGRectMake(10, 0, 20, 20))
        titleLogo.image = UIImage(named: "titleTag")?.resized(toWidth: 100)
        
        titleInput.backgroundColor = UIColor(named: "Gray")
        titleInput.leftViewMode = .always
        titleInput.leftView = titleLogo
        titleInput.layer.borderWidth = 0
        NSLayoutConstraint.activate([
            
            titleInput.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: 80),
            
            titleInput.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            titleInput.trailingAnchor.constraint(equalTo: titleSpeechButton.leadingAnchor, constant: -20),
            titleInput.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
        
        //TASK TİTLE
        titleText.text = "Task Title*"
        mainView.addSubview(titleText)
        
        
        NSLayoutConstraint.activate([
            
            titleText.bottomAnchor.constraint(equalTo: titleInput.topAnchor, constant: -20),
            titleText.leadingAnchor.constraint(equalTo: titleInput.leadingAnchor),
            titleText.heightAnchor.constraint(equalToConstant: 30),
            titleText.widthAnchor.constraint(equalToConstant: 200)
        
        ])
        
        
            // TASK ADD TEXT
            taskAddText.text = "Task Add"
          
            
            mainView.addSubview(taskAddText)
            
            NSLayoutConstraint.activate([
                
                taskAddText.leadingAnchor.constraint(equalTo: titleInput.leadingAnchor),
                taskAddText.topAnchor.constraint(equalTo: titleInput.bottomAnchor, constant: 20),
                taskAddText.heightAnchor.constraint(equalToConstant: 28),
                taskAddText.widthAnchor.constraint(equalToConstant: 200),
           
            
            ])
       
        
        //TASK ADD BUTTON
        addButton.setImage(UIImage(named: "add"), for: .normal)
        
        mainView.addSubview(addButton)
        NSLayoutConstraint.activate([
            
          
            addButton.topAnchor.constraint(equalTo: taskAddText.bottomAnchor, constant: 20),
            addButton.leadingAnchor.constraint(equalTo: titleInput.leadingAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 60),
            addButton.heightAnchor.constraint(equalToConstant: 60)
        
        
        ])
        
        addButton.addTarget(self, action: #selector(todoAddClicked), for: .touchUpInside)
        
        
    
        // TASK TEXT FİELD
        mainView.addSubview(taskTextField)
        
        NSLayoutConstraint.activate([
        
            taskTextField.topAnchor.constraint(equalTo: addButton.topAnchor),
            taskTextField.trailingAnchor.constraint(equalTo: titleSpeechButton.trailingAnchor),
            taskTextField.leadingAnchor.constraint(equalTo: addButton.trailingAnchor, constant: 20),
            taskTextField.heightAnchor.constraint(equalToConstant: 40)
        
        
        ])
        
        taskTextField.backgroundColor = UIColor(named: "Gray")
        taskTextField.leftViewMode = .always
        taskTextField.layer.borderWidth = 0
        
        //TABLEVİEW (TASK)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        
        //DESCR TEXT
        
        mainView.addSubview(descrText)
        descrText.text = "Description"
        NSLayoutConstraint.activate([
        
            descrText.leadingAnchor.constraint(equalTo: titleInput.leadingAnchor),
            descrText.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            descrText.heightAnchor.constraint(equalToConstant: 28),
            descrText.widthAnchor.constraint(equalToConstant: 200),
        ])

        
        //DESCR IMAGE
        mainView.addSubview(image)

        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
          
            image.topAnchor.constraint(equalTo: descrText.bottomAnchor, constant: 5),
            image.leadingAnchor.constraint(equalTo: descrText.leadingAnchor),
            image.widthAnchor.constraint(equalToConstant: 35),
            image.heightAnchor.constraint(equalToConstant: 35)
     ])
        
        
        
        mainView.addSubview(descrSpeechButton)
        descrSpeechButton.setImage(UIImage(named: "mic"), for: .normal)
        NSLayoutConstraint.activate([
        
            descrSpeechButton.topAnchor.constraint(equalTo: image.topAnchor),
            descrSpeechButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            descrSpeechButton.widthAnchor.constraint(equalToConstant: 50),
            descrSpeechButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        descrSpeechButton.addTarget(self, action: #selector(descrSpeechButtonClicked), for: .touchUpInside)
        
        
        //DESCR INPUT
        mainView.addSubview(noteInput)
        noteInput.backgroundColor = UIColor(named: "Gray")
        noteInput.layer.borderWidth = 0
        NSLayoutConstraint.activate([
            
        noteInput.topAnchor.constraint(equalTo: descrText.bottomAnchor, constant: 20),
        noteInput.leadingAnchor.constraint(equalTo: titleInput.leadingAnchor,constant: 50),
        noteInput.trailingAnchor.constraint(equalTo: descrSpeechButton.leadingAnchor, constant: -20),
        noteInput.heightAnchor.constraint(equalToConstant: 200),

    ])
        
        //START DATE
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
        
        //START TİME
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
            startTime.heightAnchor.constraint(equalToConstant: 60)
            ])
        
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
        
        //END TİME
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
    
    
    
    @objc func titleSpeechButtonClicked(){
        self.delegate?.titleSpeechClicked(textField: titleInput, button: titleSpeechButton)
    }
    @objc func todoAddClicked(){
        self.delegate?.didTapAddButton()
    }
    
    @objc func descrSpeechButtonClicked(){
        self.delegate?.descrSpeechClicked(textField: noteInput, button: descrSpeechButton)
    }
    
  
}
