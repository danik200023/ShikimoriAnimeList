//
//  NetworkManager.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 15.08.2024.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func getAccessToken(completion: @escaping (Result<OAuthToken, AFError>) -> Void) {
        let url = "https://shikimori.one/oauth/token"
        let headers: HTTPHeaders = [
                "User-Agent": "Shikimori iOS App"
            ]
        guard let authCode = UserDefaults.standard.string(forKey: "authCode") else { return }
        let parameters: [String: String] = [
                "grant_type": "authorization_code",
                "client_id": "wfUWoNxEIwfseLQ5vGJfQjeVOAAELibJw5zbOmCVnrc",
                "client_secret": "YagZ3xAhnrbC5uNgjxv2QeAeeoPRgEsatQYz8UIF5x4",
                "code": authCode,
                "redirect_uri": "shikimoriapp://callback"
            ]
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(url, method: .post, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: OAuthToken.self, decoder: decoder) { response in
                switch response.result {
                case .success(let token):
                    completion(.success(token))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchWithAuthorization<T: Decodable>(
        _ type: T.Type,
        from url: URLConvertible,
        completion: @escaping(Result<T, AFError>) -> Void
    ) {
        let token = UserDefaults.standard.getOAuthToken()
        let interceptor = AuthenticationInterceptor(authenticator: OAuthAuthenticator(), credential: token)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(url, interceptor: interceptor)
            .validate()
            .responseDecodable(of: type, decoder: decoder) { response in
                completion(response.result)
            }
    }
    
    func fetchWithoutAuthorization<T: Decodable>(
        _ type: T.Type,
        from url: URLConvertible,
        completion: @escaping(Result<T, AFError>) -> Void
    ) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(url)
            .validate()
            .responseDecodable(of: type, decoder: decoder) { response in
                completion(response.result)
            }
    }
}
