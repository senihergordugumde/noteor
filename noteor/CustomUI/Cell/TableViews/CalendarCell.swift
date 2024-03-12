//
//  CalendarCell.swift
//  noteor
//
//  Created by Emir AKSU on 3.03.2024.
//

import UIKit

class CalendarCell: UITableViewCell {
    
    static let id = "CalendarCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    
    let startTime = EALabel(textAlignment: .center, fontSize: 16)
    let endTime = EALabel(textAlignment: .center, fontSize: 16)
    let taskTitle = EATitle(textAlignment: .center, fontSize: 16)
    private func configure(){
        
        self.addSubview(startTime)
        self.addSubview(taskTitle)
        self.addSubview(endTime)

        NSLayoutConstraint.activate([
        
            startTime.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            startTime.centerYAnchor.constraint(equalTo: centerYAnchor),
            startTime.widthAnchor.constraint(equalToConstant: 60),
            startTime.heightAnchor.constraint(equalToConstant: 60)
        
        ])
        
        NSLayoutConstraint.activate([
        
            taskTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            taskTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            taskTitle.widthAnchor.constraint(equalToConstant: 100),
            taskTitle.heightAnchor.constraint(equalToConstant: 50)
        
        ])
        
        NSLayoutConstraint.activate([
        
            endTime.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            endTime.centerYAnchor.constraint(equalTo: centerYAnchor),
            endTime.widthAnchor.constraint(equalToConstant: 60),
            endTime.heightAnchor.constraint(equalToConstant: 60)
        
        ])
        
        
    
    }
    
    func set (note : Notes){
        
        startTime.text = note.StartTime.formatted(date: .omitted, time: .shortened)
        endTime.text = note.EndTime.formatted(date: .omitted, time: .shortened)
        taskTitle.text = note.Title
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
