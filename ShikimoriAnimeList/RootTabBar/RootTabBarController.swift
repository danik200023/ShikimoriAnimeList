//
//  RootTabBarController.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 13.12.2024.
//

import UIKit

class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let userRatesVC = UINavigationController(rootViewController: UserRatesViewController())
        let ongoingsVC = UINavigationController(rootViewController: OngoingsCollectionViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        let profileVC = ProfileViewController()
        
        userRatesVC.tabBarItem.image = UIImage(systemName: "list.clipboard")
        userRatesVC.tabBarItem.title = "Список"
        ongoingsVC.tabBarItem.image = UIImage(systemName: "clock")
        ongoingsVC.tabBarItem.title = "Онгоинги"
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        searchVC.tabBarItem.title = "Поиск"
        profileVC.tabBarItem.image = UIImage(systemName: "person")
        profileVC.tabBarItem.title = "Профиль"
        
//        viewControllers = [userRatesVC, detailsVC, profileVC]
        viewControllers = [userRatesVC, searchVC]
    }
}
