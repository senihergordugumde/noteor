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
    
    
    
    let startDate = EALabel(textAlignment: .center, fontSize: 16)
    let endDate = EALabel(textAlignment: .center, fontSize: 16)
    private func configure(){
        
        self.addSubview(startDate)
        self.addSubview(endDate)

        NSLayoutConstraint.activate([
        
            startDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            startDate.centerYAnchor.constraint(equalTo: centerYAnchor),
            startDate.widthAnchor.constraint(equalToConstant: 60),
            startDate.heightAnchor.constraint(equalToConstant: 60)
        
        ])
        
        NSLayoutConstraint.activate([
        
            endDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            endDate.centerYAnchor.constraint(equalTo: centerYAnchor),
            endDate.widthAnchor.constraint(equalToConstant: 60),
            endDate.heightAnchor.constraint(equalToConstant: 60)
        
        ])
        
        
    
    }
    
    func set (note : Notes){
        
        startDate.text = note.StartDate.formatted(date: .complete, time: .omitted)
        endDate.text = note.EndDate.formatted(date: .complete, time: .omitted)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
