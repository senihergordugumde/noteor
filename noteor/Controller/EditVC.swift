//
//  EditVC.swift
//  noteor
//
//  Created by Emir AKSU on 17.02.2024.
//

import UIKit

class EditVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    let colorList = ["Pink","Gym","Food","Work","School","Purple"]
    let customTitle = EATitle(textAlignment: .left, fontSize: 16)
    let colorView = UIView()
    static var selectedColor = "Work"
    static var lock = false
    var collectionView : UICollectionView!
    
    
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return colorList.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.id, for: indexPath) as! ColorCell
          cell.backgroundColor = UIColor(named: colorList[indexPath.row])
          return cell
      }
      
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
          EditVC.selectedColor = colorList[indexPath.row]
          colorView.backgroundColor = UIColor(named:EditVC.selectedColor)

          

      }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       
        view.backgroundColor = .systemBackground
       
        configure()
    }

    
    private func configure(){
        
        
        self.navigationItem.title = "Edit"
        
        let lock = UIBarButtonItem(image: UIImage(systemName: "lock.open"), style: .done, target: self, action: #selector(lockClicked))
      
        let rightBarItems = [lock]
        
        
        
        self.navigationItem.rightBarButtonItems = rightBarItems
        
        
        configureCollectionView()
        configureTitle()
        
    }
    
    
    private func configureTitle(){
        view.addSubview(customTitle)
        view.addSubview(colorView)
        colorView.translatesAutoresizingMaskIntoConstraints = false
        customTitle.text = "Pick your favorite color 😊"
        NSLayoutConstraint.activate([
            
            colorView.bottomAnchor.constraint(equalTo: customTitle.bottomAnchor, constant: 10),
            colorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            colorView.widthAnchor.constraint(equalToConstant: 3),
            colorView.heightAnchor.constraint(equalToConstant: 40),
            
            customTitle.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -10),
            customTitle.leadingAnchor.constraint(equalTo: colorView.leadingAnchor, constant: 15),
            customTitle.widthAnchor.constraint(equalTo : view.widthAnchor),
            customTitle.heightAnchor.constraint(equalToConstant: 20)
        
        ])
        
        colorView.backgroundColor = UIColor(named:EditVC.selectedColor)
    }
    
    
    private func configureCollectionView(){
  
        collectionView = UICollectionView(frame: .null, collectionViewLayout: createFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.id)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        view.addSubview(collectionView)
        
        
        NSLayoutConstraint.activate([
        
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalTo : view.widthAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
        
        ])
        
    }
    
    
    
    
    
    func createFlowLayout() -> UICollectionViewFlowLayout{
        
        let layout = UICollectionViewFlowLayout()
        
        let width = view.bounds.width
        let padding : CGFloat = 20
        let minimumItemSpace : CGFloat = 12
        let newWidth =  width - (padding * 2) - (minimumItemSpace * 2)
        let itemWidth = newWidth / 5
        layout.itemSize = .init(width: itemWidth, height: itemWidth)
        layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        
        
        layout.scrollDirection = .horizontal
        return layout
        
    }
    
    @objc func lockClicked(){
        
        
        if EditVC.lock == false{
            EditVC.lock = true
            self.navigationItem.rightBarButtonItems![0].image = UIImage(systemName: "lock")
            print(EditVC.lock)
        }else{
            EditVC.lock = false
            self.navigationItem.rightBarButtonItems![0].image = UIImage(systemName: "lock.open")
            print(EditVC.lock)

        }
        
       
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
