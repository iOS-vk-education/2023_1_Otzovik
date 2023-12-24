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
        let firebaseOptions = FirebaseOptions(googleAppID: "1:494060081491:ios:593dc1edfdace69fb5d1a6",
                                                       gcmSenderID: "494060081491")
          firebaseOptions.apiKey = "AIzaSyDnpsNJ_rDaCU7wpIR0fUSzQM3rpCpghD8"
                  firebaseOptions.databaseURL = "https://otzovik-484f7-default-rtdb.europe-west1.firebasedatabase.app"
          firebaseOptions.projectID = "otzovik-484f7"
          FirebaseApp.configure(options: firebaseOptions)
        //FirebaseApp.configure()
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
    func applicationWillTerminate(_ application: UIApplication) {
        UserDefaults.standard.removeObject(forKey: "selectedUniversityPath")
        UserDefaults.standard.removeObject(forKey: "selectedCells")
        
    }

}

