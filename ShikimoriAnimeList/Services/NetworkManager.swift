//
//  NetworkManager.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 15.08.2024.
//

import Foundation

final class NetworkManager {
    enum NetworkError: Error {
        case invalidUrl
        case noData
        case decodingError
    }
    
    static var shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(
        from url: URL,
        completion: @escaping(Result<Data, NetworkError>) -> Void
    ) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetch<T: Decodable>(
        _ type: T.Type,
        from url: URL,
        completion: @escaping(Result<T, NetworkError>) -> Void
    ) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let dataModel = try decoder.decode(type, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                completion(.failure(.noData))
            }
        }.resume()
    }
}
