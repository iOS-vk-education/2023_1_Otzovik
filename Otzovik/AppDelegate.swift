//
//  AppDelegate.swift
//  Otzovik
//
//  Created by Leonid Perlin on 10/22/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let factory = AppFactory()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        FirebaseApp.configure()
        window?.backgroundColor = .white
        let firebaseAuth = Auth.auth()
        var rootViewController: UIViewController?
//        if let user = firebaseAuth.currentUser {
//            rootViewController = factory.buildTabBar()
//        } else {
//            rootViewController = EntranceViewController()
//        }
        rootViewController = factory.buildTabBar()
        guard let rootViewController else { return false }
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        let root = navigationController
        window?.rootViewController = root
        window?.makeKeyAndVisible()
        
        return true
    }

}

