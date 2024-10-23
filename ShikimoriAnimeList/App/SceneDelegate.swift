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
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        if url.scheme == "shikimoriapp" {
            let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
            let code = queryItems?.first(where: { $0.name == "code" })?.value
            if let code = code {
                UserDefaults.standard.setValue(code, forKey: "authCode")
                guard let tabBarVC = window?.rootViewController as? UITabBarController else { return }
                if let loginVC = tabBarVC.viewControllers?.last as? LoginViewController {
                    if loginVC.presentedViewController == loginVC.oAuthVC {
                        loginVC.oAuthVC?.dismiss(animated: true) {
                            loginVC.refreshUI()
                        }
                    }
                }
            } else {
                print("No code found in URL")
            }
        } else {
            print("Incorrect scheme detected")
        }
    }
}

