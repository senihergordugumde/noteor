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
class CalendarVC: UIViewController {
    
    var viewModel : CalendarViewModel
    var calendarView : CalendarView! {
        return self.view as? CalendarView
    }
    
    init(viewModel: CalendarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = CalendarView()
        self.navigationController?.isNavigationBarHidden = false
       

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow-left")!.resized(toWidth: 40), style: .done, target: self, action: #selector(backButton))
        
        self.navigationItem.title = "Calendar"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        calendarView.tableView.dataSource = self
        calendarView.tableView.delegate = self
        calendarView.calendar.dataSource = self
        calendarView.calendar.delegate = self
 

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //self.tableView?.reloadData()
        
    }
    @objc func backButton(){
        self.navigationController?.popToRootViewController(animated: true)
    }

    
    
    

}
