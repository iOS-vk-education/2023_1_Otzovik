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
        
        tabBarController.selectedIndex = 1
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.unselectedItemTintColor = .gray
        
        return tabBarController
    }
    
    func buildFavorites() -> UIViewController {
        let favorites = FavoritesViewController()
        let favoritesItem = UITabBarItem(title: "Избранное", image: UIImage(systemName: "star"), selectedImage: nil)
        favorites.tabBarItem = favoritesItem
        //let favoritesNav = UINavigationController(rootViewController: favorites)
        return favorites
    }
    
    func buildSearch() -> UIViewController {
        let search = SearchViewController()
        let searchItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)
        search.tabBarItem = searchItem
        let searchNavigationController = UINavigationController(rootViewController: search)
        return searchNavigationController
    }
    
    func buildProfile() -> UIViewController {
        let profile = ProfileViewController()
        let profileItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), selectedImage: nil)
        profile.tabBarItem = profileItem
        
        return profile
    }
    
    
}

