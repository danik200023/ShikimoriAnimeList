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
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        if let token = UserDefaults.standard.getOAuthToken() {
            if token.requiresRefresh {
                
                let loadingVC = LoadingViewController()
                window.rootViewController = loadingVC
                window.makeKeyAndVisible()
                
                NetworkManager.shared.fetchWithAuthorization(
                    User.self,
                    from: "https://shikimori.one/api/users/whoami"
                ) { result in
                    switch result {
                    case .success(let loadedUser):
                        UserDefaults.standard.set(loadedUser.id, forKey: "userId")
                        AuthManager.shared.isLoggedIn = true
                    case .failure(_): break
                    }
                    
                    let tabBarVC = RootTabBarController()
                    UIView.transition(with: window, duration: 0.3) {
                        window.rootViewController = tabBarVC
                    }
                }
            } else {
                AuthManager.shared.isLoggedIn = true
                let tabBarVC = RootTabBarController()
                window.rootViewController = tabBarVC
                window.makeKeyAndVisible()
            }
        } else {
            let tabBarVC = RootTabBarController()
            window.rootViewController = tabBarVC
            window.makeKeyAndVisible()
        }
    }
}

