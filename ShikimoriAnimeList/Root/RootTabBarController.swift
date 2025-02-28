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
        let ongoingsVC = UINavigationController(rootViewController: OngoingsViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController())
//        let profileVC = ProfileViewController()
        
        userRatesVC.tabBarItem = UITabBarItem(title: "Список", image: UIImage(systemName: "list.clipboard"), tag: 0)
        ongoingsVC.tabBarItem = UITabBarItem(title: "Онгоинги", image: UIImage(systemName: "clock"), tag: 1)
        searchVC.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"), tag: 2)
//        profileVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), tag: 3)
        
        let controllers = [userRatesVC, ongoingsVC, searchVC]
        controllers.forEach {
            $0.loadViewIfNeeded()
        }
        
        viewControllers = controllers
    }
}
