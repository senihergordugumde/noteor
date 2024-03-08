//
//  TaskCountCell.swift
//  noteor
//
//  Created by Emir AKSU on 4.03.2024.
//

import UIKit

class TaskCountCell: UITableViewCell {

    static let id = "TaskCountCell"
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    let view = UIView()
    let categTitle = EATitle(textAlignment: .left, fontSize: 16)
    let descrText = EALabel(textAlignment: .left, fontSize: 12)
    let counterText = EATitle(textAlignment: .center, fontSize: 12)
    let countView = UIView()
    let categImageView = UIImageView()

    
    private func configure(image : String, count : Int){
        
        categImageView.image = UIImage(named: image)
        addSubview(view)
        view.addSubview(categImageView)
        addSubview(countView)
        countView.addSubview(counterText)
        
        addSubview(categTitle)
        addSubview(descrText)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        countView.translatesAutoresizingMaskIntoConstraints = false
        categImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        //MARK: - Conf View
        NSLayoutConstraint.activate([
        
        
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            view.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            view.widthAnchor.constraint(equalToConstant: 40),
            view.heightAnchor.constraint(equalTo: view.widthAnchor)
        
        ])
        
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(named: image)
        
        //MARK: - Conf Image
        
        NSLayoutConstraint.activate([
        
            categImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            categImageView.widthAnchor.constraint(equalToConstant: 25),
            categImageView.heightAnchor.constraint(equalToConstant: 25)
        
        ])
        
        //MARK: - Conf Title

        categTitle.text = image
        
        NSLayoutConstraint.activate([
        
            categTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            categTitle.leadingAnchor.constraint(equalTo: categImageView.trailingAnchor, constant: 20),
            categTitle.widthAnchor.constraint(equalToConstant: 50),
            categTitle.heightAnchor.constraint(equalToConstant: 20)
        
        
        ])
        
        
        //MARK: - Conf Descr

        descrText.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        
        NSLayoutConstraint.activate([
        
            descrText.topAnchor.constraint(equalTo: categTitle.bottomAnchor, constant: 0),
            descrText.leadingAnchor.constraint(equalTo: categTitle.leadingAnchor),
            descrText.trailingAnchor.constraint(equalTo: countView.leadingAnchor, constant: -30),
            descrText.heightAnchor.constraint(equalToConstant: 40)
        
        
        ])
        descrText.numberOfLines = 2
        descrText.lineBreakMode = .byCharWrapping
        
        
        //MARK: - Conf Counter
        
        NSLayoutConstraint.activate([
        
        
            countView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            countView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            countView.widthAnchor.constraint(equalToConstant: 40),
            countView.heightAnchor.constraint(equalTo: countView.widthAnchor)
            
        
        ])
        countView.layer.cornerRadius = 5
        countView.backgroundColor = UIColor(named: image)

        //MARK: - Conf Counter Text
        
        NSLayoutConstraint.activate([
        
        
            counterText.centerXAnchor.constraint(equalTo: countView.centerXAnchor),
            counterText.centerYAnchor.constraint(equalTo: countView.centerYAnchor),
            counterText.widthAnchor.constraint(equalToConstant: 20),
            counterText.heightAnchor.constraint(equalToConstant: 20)
            
        
        ])
        
        counterText.text = String(count)
        
    }
    
    
        

    
    func set (categ : String, count: Int){
        
        configure(image: categ, count: count)
        
    }

}
