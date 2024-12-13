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

        let userRatesVC = UserRatesViewController()
        let ongoingsVC = OngoingsCollectionViewController()
        let searchVC = SearchCollectionViewController()
        let profileVC = ProfileViewController()
        
        let loadingVC = LoadingViewController()
        
        userRatesVC.tabBarItem.image = UIImage(systemName: "person.circle")
        ongoingsVC.tabBarItem.image = UIImage(systemName: "clock")
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        profileVC.tabBarItem.image = UIImage(systemName: "person")
        
        viewControllers = [loadingVC, profileVC]
    }
}
