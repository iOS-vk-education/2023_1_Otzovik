//
//  AppDelegate.swift
//  Otzovik
//
//  Created by Leonid Perlin on 10/22/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let factory = AppFactory()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        window?.backgroundColor = .white
        
        //let root = factory.buildTabBar()
        let navigationController = UINavigationController(rootViewController: EntranceViewController())
        navigationController.setNavigationBarHidden(true, animated: false)
        let root = navigationController
        window?.rootViewController = root
        window?.makeKeyAndVisible()
        
        return true
    }

}

