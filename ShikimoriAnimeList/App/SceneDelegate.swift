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
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        if let token = UserDefaults.standard.getOAuthToken() {
            if token.requiresRefresh {
                let window = UIWindow(windowScene: windowScene)
                self.window = window
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loadingVC = storyboard.instantiateViewController(withIdentifier: "LoadingViewController")
                window.rootViewController = loadingVC
                window.makeKeyAndVisible()
                
                NetworkManager.shared.fetchWithAuthorization(
                    User.self,
                    from: "https://shikimori.one/api/users/whoami"
                ) { result in
                    switch result {
                    case .success(_):
                        AuthManager.shared.isLoggedIn = true
                    case .failure(_): break
                    }
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabBarVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
                    window.rootViewController = tabBarVC
                }
            } else {
                AuthManager.shared.isLoggedIn = true
            }
        }
    }
}

