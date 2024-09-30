//
//  AuthToken.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 27.09.2024.
//

import Foundation
import Alamofire

struct OAuthToken: AuthenticationCredential, Codable {
    let accessToken: String
    let refreshToken: String
    let tokenType: String
    let expiresIn: Int
    let scope: String
    let createdAt: TimeInterval
    
    var expirationDate: Date {
        return Date(timeIntervalSince1970: createdAt + TimeInterval(expiresIn))
    }
    
    var requiresRefresh: Bool {
        return Date() > expirationDate.addingTimeInterval(-300)
    }
}
