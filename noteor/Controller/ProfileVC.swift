//
//  ProfileVC.swift
//  noteor
//
//  Created by Emir AKSU on 26.04.2024.
//

import UIKit
extension ProfileVC : UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        profileView.userImageView.image = tempImage
        viewModel.putPhoto(imageData: tempImage.jpegData(compressionQuality: 0.5)!)
        self.dismiss(animated: true)
    }
}


class ProfileVC: UIViewController, ProfileViewModelDelegate, ProfileViewDelegate, UINavigationControllerDelegate {
    func imageUpdateFails() {
        self.makeEAAlert(alertTitle: "Image Update Failed", alertLabel: "You cant change your profile photo when using Google SignIn method")
    }
    
    func updateUserInfo(url: URL) {
        viewModel.update(data: ["photoURL" : url.absoluteString])
    }
    
    
    func updateUserInfo() {
        print("Update succes")
    }
    
    func imagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    
    func logoutClicked() {
        
        self.viewModel.signOut()
    }
    
    func signOut() {
  
        let loginVC = SceneDelegate().createMainNC()
        loginVC.modalPresentationStyle = .overFullScreen
        self.present(loginVC, animated: true)
    }
    
    func setCompletedTaskCount(count: Int) {
        DispatchQueue.main.async {
            self.profileView.completedTaskTitle.text = String(count)
        }
    }
    
    func setUnCompletedTaskCount(count: Int) {
        DispatchQueue.main.async {
            self.profileView.notCompletedTaskTitle.text = String(count)
        }
    }
    
    
    func setUserImage(image: UIImage) {
        DispatchQueue.main.async {
            self.profileView.userImageView.image = image
        }
    }
    

    var profileView : ProfileView! {
        return self.view as? ProfileView
    }
    
    let viewModel : ProfileViewModel
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = ProfileView()
        self.viewModel.delegate = self
        self.profileView.delegate = self
        viewModel.userImage()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getTaskCounts()
    }
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
