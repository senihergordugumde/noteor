//
//  ProfileViewModel.swift
//  noteor
//
//  Created by Emir AKSU on 26.04.2024.
//

import Foundation
import UIKit

protocol ProfileViewModelDelegate : AnyObject{
    func setUserImage(image : UIImage)
    func setCompletedTaskCount(count : Int)
    func setUnCompletedTaskCount(count : Int)
    func updateUserInfo(url : URL)
    func imageUpdateFails()
    func signOut()

}

class ProfileViewModel {
    weak var delegate : ProfileViewModelDelegate?
    
    let getService : GetService
    let authService : AuthService
    let updateService : UpdateService
    let postService : PostService
    
    let user = UserManager.shared.getUser()
    
    init(getService: GetService, authService : AuthService, updateService : UpdateService,postService :PostService) {
        self.getService = getService
        self.authService = authService
        self.updateService = updateService
        self.postService = postService
    }
    
    func update(data : [AnyHashable : Any]){
        
        guard let user = user else {
            self.delegate?.imageUpdateFails()
            return
        }
        
        updateService.updateUserInfo(id: user.userID, data: data) { result in
            
            
            switch result {
            case .success(_):
                print("image update başarılı")
            case .failure(_):
                print("image update başarısız")
            }
        }
    }
    
    func putPhoto(imageData : Data){
        guard let user = user else {return}
        postService.postImage(imageData: imageData, id: user.userID) { result in
            switch result{
                
            case .success(let url):
                self.delegate?.updateUserInfo(url: url)
            
            case .failure(let error):
                print("image put error")
            }
        }
        
    }
    
    func userImage(){
       var user = UserManager.shared.getUser()
        print(user?.photoURL)
        print(user?.displayName)
        print(user?.userID)
    
        guard let user = user else {return}
        getService.getUserImage(Url: user.photoURL) { result in
            
            switch result {
                
            case .success(let image):
                print("image taked")
                self.delegate?.setUserImage(image: image)
            case .failure(_):
                self.delegate?.setUserImage(image: UIImage(named: "placeholder")!)
            }
        }
        
    }
  
    
    func getTaskCounts(){
        getService.getStatusCount(field: "isCompleted", isEqualTo: "doing") { result in
            switch result {
                case .success(let doing):
                    print(doing)
                self.delegate?.setUnCompletedTaskCount(count: doing)
                case .failure(let error):
                    print("error")
            }
        }
        getService.getStatusCount(field: "isCompleted", isEqualTo: "done") { result in
            switch result {
                case .success(let done):
                self.delegate?.setCompletedTaskCount(count: done)
                    print(done)
                case .failure(let error):
                    print("error")
            }
        }
    }
    
    func signOut(){
        authService.logout { result in
            switch result {
                
            case .success():
                self.delegate?.signOut()
            case .failure(_):
                print("error")
            }
        }
    }

}
