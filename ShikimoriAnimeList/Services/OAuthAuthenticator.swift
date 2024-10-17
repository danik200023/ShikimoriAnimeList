//
//  AuthInterceptor.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 27.09.2024.
//

import Foundation
import Alamofire

final class OAuthAuthenticator: Authenticator {
    typealias Credential = OAuthToken
    
    func apply(_ credential: OAuthToken, to urlRequest: inout URLRequest) {
        urlRequest.setValue("Bearer \(credential.accessToken)", forHTTPHeaderField: "Authorization")
    }
    
    func refresh(_ credential: OAuthToken, for session: Alamofire.Session, completion: @escaping (Result<OAuthToken, any Error>) -> Void) {
        let url = "https://shikimori.one/oauth/token"
        let parameters: Parameters = [
            "grant_type": "refresh_token",
            "client_id": "wfUWoNxEIwfseLQ5vGJfQjeVOAAELibJw5zbOmCVnrc",
            "client_secret": "YagZ3xAhnrbC5uNgjxv2QeAeeoPRgEsatQYz8UIF5x4",
            "refresh_token": credential.refreshToken
        ]
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(url, method: .post, parameters: parameters)
            .validate()
            .responseDecodable(of: OAuthToken.self, decoder: decoder) { response in
                switch response.result {
                case .success(let token):
                    UserDefaults.standard.saveOAuthToken(token)
                    completion(.success(token))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: OAuthToken) -> Bool {
        let bearerToken = "Bearer \(credential.accessToken)"
        return urlRequest.headers["Authorization"] == bearerToken
    }
    
    func didRequest(_ urlRequest: URLRequest, with response: HTTPURLResponse, failDueToAuthenticationError error: any Error) -> Bool {
        return response.statusCode == 401
    }
}
