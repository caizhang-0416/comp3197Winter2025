//
//  SceneDelegate.swift
//  SmartShopper
//
//  Created by Cai Zhang on 2025-02-15.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        
        // Set the initial launch screen as root view controller
        let launchVC = LaunchScreenVC() // Custom launch screen view controller
        window?.rootViewController = launchVC
        window?.makeKeyAndVisible()
        
        // Transition to the main screen after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController")
            self.window?.rootViewController = mainVC
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Restart any tasks that were paused when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Handle temporary interruptions (ex: incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Undo changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Save data when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

