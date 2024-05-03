//
//  SceneDelegate.swift
//  noteor
//
//  Created by Emir AKSU on 17.02.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
         Auth.auth().addStateDidChangeListener { (auth, user) in
             guard let user = user else {
                 self.window?.rootViewController = self.createMainNC()
                 self.window?.makeKeyAndVisible()
                 return
                 
             }
             for info in user.providerData {
                 if info.providerID == "apple.com"{
                     let appleUser = User(displayName: user.displayName ?? "", photoURL: user.photoURL ?? URL(string: "g")!, userID: user.uid)
                     UserManager.shared.setUser(user: appleUser)
                     self.window?.rootViewController = self.createTabbar()
                     self.window?.makeKeyAndVisible()
                 }
                 else if info.providerID == "google.com"{
                     let googleUser = User(displayName: user.displayName ?? "", photoURL: (user.photoURL ?? URL(string: ""))!, userID: user.uid)
                     UserManager.shared.setUser(user: googleUser)
                     self.window?.rootViewController = self.createTabbar()
                     self.window?.makeKeyAndVisible()
                 }
                 else{
                     let firestore = Firestore.firestore()
                     firestore.collection("Accounts").document(user.uid).getDocument { snap, error in
                         
                         print("ID : \(user.uid)")
                         
                         guard let snap = snap else {
                             
                             return
                         }
                         
                         do {
                             var firebaseUser = try snap.data(as: User.self)
                             UserManager.shared.setUser(user: firebaseUser)
                             
                             self.window?.rootViewController = self.createTabbar()
                             self.window?.makeKeyAndVisible()
                         }catch{
                             
                             print("firebase login error")
                             
                         }
                     }
                     
                 }
             }
            
        }
        
    }



    
    
    func createHomeNC() -> UINavigationController{
        let homeVC = HomeVC()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        return UINavigationController(rootViewController: homeVC)
        
    }
    
    
    
    func createMainNC() -> UINavigationController{
        let authService : AuthService = Authentication()
        let viewModel = LoginViewModel(Authentication: authService)
        let mainViewController = LoginVC(loginViewModel: viewModel)
        return UINavigationController(rootViewController: mainViewController)
        
    }
    
    
    func createNotesNC() -> UINavigationController{
        let getService : GetService = Get()
        let updateService : UpdateService = Update()
        let viewModel = NotesViewModel(getService: getService, updateService: updateService)
        let NotesVC = NotesVC(viewModel: viewModel)
        
        NotesVC.tabBarItem = UITabBarItem(title: "Tasks", image: UIImage(systemName: "book.pages.fill"), tag: 1)
        return UINavigationController(rootViewController: NotesVC)
        
    }
    
    func createProfileNC() -> UINavigationController {
        let authService : AuthService = Authentication()
        let getService : GetService = Get()
        let updateService : UpdateService = Update()
        let postService :PostService = Post()
        let viewModel = ProfileViewModel(getService: getService, authService: authService, updateService: updateService, postService: postService)
        let profileVC = ProfileVC(viewModel: viewModel)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 2)
        
        return UINavigationController(rootViewController: profileVC)
    }
    
    
    func createSettingsNC() -> UINavigationController {
        
        let settingsTVC = SettingsTVC()
        settingsTVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag : 3)
        
        return UINavigationController(rootViewController: settingsTVC)
    }
    
    
     func createTabbar() -> UITabBarController{
        
        let tabbar = UITabBarController()
        tabbar.viewControllers = [createHomeNC(),createNotesNC(), createProfileNC(),createSettingsNC()]
         UITabBar.appearance().tintColor = UIColor(named: "Red")
         UITabBar.appearance().backgroundColor =  .secondarySystemBackground
         UITabBar.appearance().layer.cornerRadius = 10
         UITabBar.appearance()
    
        return tabbar
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

