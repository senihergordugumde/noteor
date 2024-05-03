//
//  CalendarView.swift
//  noteor
//
//  Created by Emir AKSU on 24.04.2024.
//

import UIKit
import FSCalendar
class CalendarView: UIView {

    
    private let dateView : UIView = {
        let view = UIView()
        
        view.backgroundColor = .secondarySystemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        return view
    }()
    
    public let calendar : FSCalendar = {
        let calendar = FSCalendar()
        calendar.backgroundColor = .secondarySystemBackground
     
        calendar.appearance.selectionColor = UIColor(named: "Red")
        calendar.appearance.headerTitleColor = .label
        calendar.appearance.weekdayTextColor = UIColor(named: "Red")
        calendar.appearance.weekdayFont = .boldSystemFont(ofSize: 16)
        calendar.appearance.titleDefaultColor = .label
        return calendar
    }()
    
    
    public let tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(CalendarCell.self, forCellReuseIdentifier: CalendarCell.id)
        return tableView
    }()
    
    private let tableViewBack : UIView = {
 

       let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .orange
        
        return view
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupUI(){
        
        backgroundColor = .secondarySystemBackground
        addSubview(dateView)
        NSLayoutConstraint.activate([
        
            
            dateView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dateView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dateView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
            
            
        ])
        
        
        dateView.addSubview(calendar)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            calendar.leadingAnchor.constraint(equalTo: dateView.leadingAnchor),
            calendar.topAnchor.constraint(equalTo: dateView.topAnchor),
            calendar.trailingAnchor.constraint(equalTo: dateView.trailingAnchor),
            calendar.bottomAnchor.constraint(equalTo: dateView.bottomAnchor)
        
        ])
        
        
        addSubview(tableViewBack)
        
        
        NSLayoutConstraint.activate([
            tableViewBack.topAnchor.constraint(equalTo: dateView.bottomAnchor),
            tableViewBack.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableViewBack.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableViewBack.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
       
        tableViewBack.addSubview(tableView)
       
 
        
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: tableViewBack.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: tableViewBack.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: tableViewBack.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: tableViewBack.bottomAnchor)

        
        ])
        
       
        
       
       
    }

}
