//
//  SceneDelegate.swift
//  noteor
//
//  Created by Emir AKSU on 17.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabbar()
        window?.makeKeyAndVisible()
        
        
        
    }



    
    
    func createHomeNC() -> UINavigationController{
        let homeVC = HomeVC()
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        return UINavigationController(rootViewController: homeVC)
        
    }
    
    
    
    func createMainNC() -> UINavigationController{
        let mainViewController = ViewController()
        return UINavigationController(rootViewController: mainViewController)
        
    }
    
    
    func createNotesNC() -> UINavigationController{
        let NotesVC = NotesVC()
        
        NotesVC.tabBarItem = UITabBarItem(title: "Tasks", image: UIImage(systemName: "book.pages.fill"), tag: 1)
        return UINavigationController(rootViewController: NotesVC)
        
    }
    
    
     func createTabbar() -> UITabBarController{
        
        let tabbar = UITabBarController()
        tabbar.viewControllers = [createHomeNC(),createNotesNC()]
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

