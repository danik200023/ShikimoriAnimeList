//
//  UserDefaults+OAuthToken.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 27.09.2024.
//

import Foundation

extension UserDefaults {
    func saveOAuthToken(_ token: OAuthToken) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(token) {
            set(encoded, forKey: "oauthToken")
        }
    }
    
    func getOAuthToken() -> OAuthToken? {
        if let savedData = data(forKey: "oauthToken") {
            let decoder = JSONDecoder()
            if let token = try? decoder.decode(OAuthToken.self, from: savedData) {
                return token
            }
        }
        return nil
    }
}
