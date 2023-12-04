//
//  AppFactory.swift
//  Otzovik
//
//  Created by Leonid Perlin on 10/22/23.
//

import UIKit

final class AppFactory {
    
    func buildTabBar() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            buildSearch(),
            buildProfile(),
            buildFavorites()
        ]
        
        tabBarController.selectedIndex = 2
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.unselectedItemTintColor = .gray
        
        return tabBarController
    }
    
    func buildFavorites() -> UIViewController {
        let favorites = FavoritesViewController()
                
        let navigationController = UINavigationController(rootViewController: favorites)
        
        let favoritesItem = UITabBarItem(title: "Избранное", image: UIImage(systemName: "star"), selectedImage: nil)
        
        navigationController.tabBarItem = favoritesItem
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationItem.largeTitleDisplayMode = .always
        
        return navigationController
    }
    
    func buildSearch() -> UIViewController {
        let search = SearchViewController()
        let searchItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)
        search.tabBarItem = searchItem
        let searchNavigationController = UINavigationController(rootViewController: search)
        return searchNavigationController
    }
    
    func buildProfile() -> UINavigationController {
        let profile = ProfileViewController()
        let profileItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), selectedImage: nil)
        profile.tabBarItem = profileItem
        UITabBar.appearance().backgroundColor = .systemBackground
        let profileNavigationController = UINavigationController(rootViewController: profile)
        return profileNavigationController
    }
    
    
}
