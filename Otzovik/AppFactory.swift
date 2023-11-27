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
            buildFavorites(),
            buildSearch(),
            buildProfile()
        ]
        
        tabBarController.selectedIndex = 0
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.unselectedItemTintColor = .gray
        
        return tabBarController
    }
    
    func buildFavorites() -> UIViewController {
        let favorites = FavoritesViewController()
        
        
        let favoritesItem = UITabBarItem(title: "Избранное", image: UIImage(systemName: "star"), selectedImage: nil)
        
        favorites.tabBarItem = favoritesItem
        
        return favorites
    }
    
    func buildSearch() -> UIViewController {
        let search = SearchViewController()
        let searchItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)
        search.tabBarItem = searchItem
        
        
        return search
    }
    
    func buildProfile() -> UINavigationController {
        let profile = ProfileViewController()
        let profileItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), selectedImage: nil)
        profile.tabBarItem = profileItem
        let profileNavigationController = UINavigationController(rootViewController: profile)
        
        return profileNavigationController
    }
    
    
}
