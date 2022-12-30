//
//  BFTabBarController.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/30/22.
//

import UIKit

class BFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor         = .systemIndigo
        UINavigationBar.appearance().tintColor  = .systemIndigo
        viewControllers                  = [createSearchNC(), createFavoritesNC()]
    }
    
    func createSearchNC() -> UINavigationController {
        let searchVC        = SearchVC()
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    
    func createFavoritesNC() -> UINavigationController {
        let favoritesVC         = FavoritesListVC()
        favoritesVC.tabBarItem  = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    
//    func createTabbar() -> UITabBarController {
//        let tabbar = UITabBarController()
//
//        return tabbar
//    }
//

 

}
