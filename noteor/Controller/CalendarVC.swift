//
//  CalendarVC.swift
//  noteor
//
//  Created by Emir AKSU on 3.03.2024.
//

import UIKit
import FSCalendar
import FirebaseFirestore
import FirebaseAuth
class CalendarVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UITableViewDelegate, UITableViewDataSource {
    
  
   
    var notes : [Notes]?
    var selectedNotes = [Notes]()

    
   
        

    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
       

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow-left")!.resized(toWidth: 40), style: .done, target: self, action: #selector(backButton))
        
        self.navigationItem.title = "Calendar"
        self.navigationController?.navigationBar.prefersLargeTitles = true
  
        view.backgroundColor = .white

        configureCalendar()
        configureTableView()
   
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        guard let notes = notes else {return}
        
        self.tableView?.reloadData()
        
    }
    @objc func backButton(){
        self.navigationController?.popToRootViewController(animated: true)
    }
   
    
    
    
    //MARK: - Calendar
    var calendar : FSCalendar?
    
    
    private let dateView : UIView = {
        let view = UIView()
        
        view.backgroundColor = .secondarySystemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        return view
    }()
    
    
    private func configureCalendar(){
        //MARK: - Configure Calendar

        view.addSubview(dateView)
        NSLayoutConstraint.activate([
        
            
            dateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            
            
        ])

        calendar = FSCalendar()
        guard let calendar = calendar else {return}
        dateView.addSubview(calendar)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            calendar.leadingAnchor.constraint(equalTo: dateView.leadingAnchor),
            calendar.topAnchor.constraint(equalTo: dateView.topAnchor),
            calendar.trailingAnchor.constraint(equalTo: dateView.trailingAnchor),
            calendar.bottomAnchor.constraint(equalTo: dateView.bottomAnchor)
        
        ])
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.backgroundColor = .white
     
        calendar.appearance.selectionColor = UIColor(named: "Red")
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.weekdayTextColor = UIColor(named: "Red")
        calendar.appearance.weekdayFont = .boldSystemFont(ofSize: 16)
        

    }
    
    //MARK: - Calendar Delegates

    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        guard let notes = self.notes else {
            print("calendar error")
            return 0 }
        
        if notes.contains(where: {$0.StartDate.formatted(date: .complete, time: .omitted) == date.formatted(date: .complete, time: .omitted)} ){
            
            return 1
        }
        
        return 0
            
        
        }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    
        guard let notes = notes else {return}
        
        selectedNotes = notes.filter{$0.StartDate.formatted(date: .complete, time: .omitted) == date.formatted(date: .complete, time: .omitted)}
        
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    //MARK: - Table View

    var tableView : UITableView?
    
    private let tableViewBack : UIView = {
        //MARK: - Table View Back

       let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .orange
        
        return view
    }()
    

    private func configureTableView(){
        //MARK: - Configure Table View

      
        view.addSubview(tableViewBack)
        
        
        NSLayoutConstraint.activate([
            tableViewBack.topAnchor.constraint(equalTo: dateView.bottomAnchor),
            tableViewBack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewBack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViewBack.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
        
        tableView = UITableView()
        guard let tableView = tableView else {return}
        tableViewBack.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(CalendarCell.self, forCellReuseIdentifier: CalendarCell.id)

        
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: tableViewBack.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: tableViewBack.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: tableViewBack.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: tableViewBack.bottomAnchor)

        
        ])
        
       
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CalendarCell.id, for: indexPath) as! CalendarCell
        
        
        cell.set(note: selectedNotes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    

   
    
  
    
    
    
    

}
