//
//  CalendarVC+Ext.swift
//  noteor
//
//  Created by Emir AKSU on 24.04.2024.
//

import Foundation
import FSCalendar

extension CalendarVC : FSCalendarDelegate, FSCalendarDataSource, UITableViewDelegate, UITableViewDataSource{
    
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        guard let notes = viewModel.notes else {
            print("calendar error")
            return 0 }
        
        if notes.contains(where: {$0.StartDate.formatted(date: .complete, time: .omitted) == date.formatted(date: .complete, time: .omitted)} ){
            
            return 1
        }
        
        return 0
            
        
        }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    
        guard let notes = viewModel.notes else {return}
        
        viewModel.selectedNotes = notes.filter{$0.StartDate.formatted(date: .complete, time: .omitted) == date.formatted(date: .complete, time: .omitted)}
        
        DispatchQueue.main.async {
            self.calendarView.tableView.reloadData()
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.selectedNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CalendarCell.id, for: indexPath) as! CalendarCell
        
        
        cell.set(note: viewModel.selectedNotes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}
