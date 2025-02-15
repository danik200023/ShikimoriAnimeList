//
//  NetworkManager.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 15.08.2024.
//

import ShikimoriAPI
import Foundation
import Apollo
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    private let apollo: ApolloClient = {
        let client = URLSessionClient()
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let provider = NetworkInterceptorProvider(client: client, store: store)
        let url = URL(string: "https://shikimori.one/api/graphql")!
        let transport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)
        
        return ApolloClient(networkTransport: transport, store: store)
    }()
    
    private init() {}
    
    func post<T: Decodable>(
        _ type: T.Type,
        to url: URLConvertible,
        withParameters parameters: Parameters? = nil,
        completion: @escaping(Result<T, AFError>) -> Void
    ) {
        let headers: HTTPHeaders = [
            "User-Agent": "Shikimori iOS App"
        ]
        let token = UserDefaults.standard.getOAuthToken()
        let interceptor = AuthenticationInterceptor(authenticator: OAuthAuthenticator(), credential: token)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers, interceptor: interceptor)
            .validate()
            .responseDecodable(of: type, decoder: decoder) { response in
                completion(response.result)
            }
    }
    
    func patch<T: Decodable>(
        _ type: T.Type,
        to url: URLConvertible,
        withParameters parameters: Parameters? = nil,
        completion: @escaping(Result<T, AFError>) -> Void
    ) {
        let headers: HTTPHeaders = [
            "User-Agent": "Shikimori iOS App"
        ]
        let token = UserDefaults.standard.getOAuthToken()
        let interceptor = AuthenticationInterceptor(authenticator: OAuthAuthenticator(), credential: token)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers, interceptor: interceptor)
            .validate()
            .responseDecodable(of: type, decoder: decoder) { response in
                completion(response.result)
            }
    }
    
    func delete(
        at url: URLConvertible,
        completion: @escaping(Result<Data?, AFError>) -> Void
    ) {
        let headers: HTTPHeaders = [
            "User-Agent": "Shikimori iOS App"
        ]
        let token = UserDefaults.standard.getOAuthToken()
        let interceptor = AuthenticationInterceptor(authenticator: OAuthAuthenticator(), credential: token)
        
        AF.request(url, method: .delete, headers: headers, interceptor: interceptor)
            .validate()
            .response { response in
                completion(response.result)
            }
    }
    
    func fetchWithAuthorization<T: Decodable>(
        _ type: T.Type,
        from url: URLConvertible,
        withParameters parameters: Parameters? = nil,
        completion: @escaping(Result<T, AFError>) -> Void
    ) {
        let headers: HTTPHeaders = [
            "User-Agent": "Shikimori iOS App"
        ]
        let token = UserDefaults.standard.getOAuthToken()
        let interceptor = AuthenticationInterceptor(authenticator: OAuthAuthenticator(), credential: token)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(url, parameters: parameters, headers: headers, interceptor: interceptor)
            .validate()
            .responseDecodable(of: type, decoder: decoder) { response in
                completion(response.result)
            }
    }
    
    func fetch<T: Decodable>(
        _ type: T.Type,
        from url: URLConvertible,
        withParameters parameters: Parameters? = nil,
        completion: @escaping(Result<T, AFError>) -> Void
    ) {
        let headers: HTTPHeaders = [
            "User-Agent": "Shikimori iOS App"
        ]
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(url, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: type, decoder: decoder) { response in
                completion(response.result)
            }
    }
    
    func fetchAnimeDetails(animeId: String, completion: @escaping (Result<GraphQLResult<AnimeDetailsQuery.Data>, any Error>) -> Void) {
        let query = AnimeDetailsQuery(ids: GraphQLNullable(stringLiteral: animeId))
        apollo.fetch(query: query) { result in
            switch result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchPosters(from ids: [Int], completion: @escaping (Result<GraphQLResult<AnimePostersQuery.Data>, any Error>) -> Void) {
        let convertedIds = ids.map { String($0) }.joined(separator: ", ")
        let query = AnimePostersQuery(ids: GraphQLNullable(stringLiteral: convertedIds))
        apollo.fetch(query: query) { result in
            switch result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchUserRates(page: Int, completion: @escaping (Result<GraphQLResult<UserRatesQuery.Data>, any Error>) -> Void) {
        let query = UserRatesQuery(page: GraphQLNullable<PositiveInt>(integerLiteral: page))
        apollo.fetch(query: query, cachePolicy: .fetchIgnoringCacheCompletely) { result in
            switch result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func search(_ name: String, completion: @escaping (Result<GraphQLResult<AnimeSearchQuery.Data>, any Error>) -> Void) {
        let query = AnimeSearchQuery(name: GraphQLNullable(stringLiteral: name))
        apollo.fetch(query: query, cachePolicy: .fetchIgnoringCacheCompletely) { result in
            switch result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAccessToken(completion: @escaping (Result<OAuthToken, AFError>) -> Void) {
        let url = "https://shikimori.one/oauth/token"
        let headers: HTTPHeaders = [
            "User-Agent": "Shikimori iOS App"
        ]
        guard let authCode = UserDefaults.standard.string(forKey: "authCode") else { return }
        let parameters: Parameters = [
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
                    UserDefaults.standard.saveOAuthToken(token)
                    completion(.success(token))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
