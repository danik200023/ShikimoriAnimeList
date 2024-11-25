//
//  ProfileViewModel.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 23.10.2024.
//

import Foundation

protocol ProfileViewModelProtocol {
    var username: String? { get }
    var url: URL { get }
    var avatarUrl: URL? { get }
    var isLoggedIn: Bool { get }
    
    func loadData(completion: @escaping () -> Void)
}

final class ProfileViewModel: ProfileViewModelProtocol {
    var username: String? {
        user?.nickname
    }
    
    var avatarUrl: URL? {
        user?.image.x160
    }
    
    var url: URL {
        URL(string: "https://shikimori.one/oauth/authorize?client_id=wfUWoNxEIwfseLQ5vGJfQjeVOAAELibJw5zbOmCVnrc&redirect_uri=shikimoriapp%3A%2F%2Fcallback&response_type=code&scope=user_rates")!
    }
    
    var isLoggedIn: Bool {
        UserDefaults.standard.getOAuthToken() != nil || UserDefaults.standard.string(forKey: "authCode") != nil
    }
    
    private var user: User?
    
    private func fetchUserProfile(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchWithAuthorization(
            User.self,
            from: "https://shikimori.one/api/users/whoami"
        ) { [unowned self] result in
            switch result {
            case .success(let loadedUser):
                user = loadedUser
                UserDefaults.standard.set(user?.id, forKey: "userId")
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getAccessToken(completion: @escaping () -> Void) {
        NetworkManager.shared.getAccessToken() { [unowned self] result in
            switch result {
            case .success(_):
                fetchUserProfile(completion: completion)
            case .failure(let error):
                print(error.responseCode ?? "Unknown error")
                if error.responseCode == 400 {
                    print("error 400")
                }
            }
        }
    }
    
    func loadData(completion: @escaping () -> Void) {
        if UserDefaults.standard.getOAuthToken() != nil {
            fetchUserProfile(completion: completion)
        } else if UserDefaults.standard.string(forKey: "authCode") != nil {
            getAccessToken(completion: completion)
        }
    }
}
