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
    
    func getAccessToken(completion: @escaping (Result<Any, AFError>) -> Void) {
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
        AF.request(url, method: .post, parameters: parameters, headers: headers)
            .validate()
            .responseJSON { response in
                completion(response.result)
            }
    }
    
    func fetch<T: Decodable>(
        _ type: T.Type,
        from url: URLConvertible,
        completion: @escaping(Result<T, AFError>) -> Void
    ) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var headers: HTTPHeaders = [
            "User-Agent": "Shikimori iOS App"
        ]
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            headers.add(HTTPHeader(name: "Authorization", value: "Bearer \(accessToken)"))
        }
        AF.request(url, headers: headers)
            .validate()
            .responseDecodable(of: type, decoder: decoder) { response in
                completion(response.result)
            }
    }
}
