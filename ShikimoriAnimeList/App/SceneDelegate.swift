//
//  SceneDelegate.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 13.08.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        fetchUserData()
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    private func fetchUserData() {
        if UserDefaults.standard.getOAuthToken() != nil {
            AuthManager.shared.isLoggedIn = true
        } else { return }
    }
}

