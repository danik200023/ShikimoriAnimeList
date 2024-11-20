//
//  SearchViewModel.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 24.10.2024.
//

import ShikimoriAPI
import Foundation

protocol SearchViewModelProtocol {
    var numberOfItemsInSection: Int { get }
    func isInUserRates(id: Int) -> Bool
    func fetchAnimes(name: String, completion: @escaping() -> Void)
    func fetchUserRates()
    func addToList(_ animeId: Int)
    func getAnimeCellViewModel(at indexPath: IndexPath) -> AnimeCellViewModelProtocol
    func getAnimeDetailsViewModel(at indexPath: IndexPath) -> AnimeDetailsViewModelProtocol
}

final class SearchViewModel: SearchViewModelProtocol {
    private var animes: [AnimeSearchQuery.Data.Anime] = []
    private var userRates: [UserRate] = []
    private var searchName: String = ""
    
    var numberOfItemsInSection: Int {
        animes.count
    }
    
    func isInUserRates(id: Int) -> Bool {
        if userRates.contains(where: { userRate in
            userRate.targetId == id
        }) {
            return true
        } else {
            return false
        }
    }
    
    func addToList(_ animeId: Int) {
        let userId = UserDefaults.standard.integer(forKey: "userId")
        if userId != 0 && UserDefaults.standard.getOAuthToken() != nil {
            NetworkManager.shared.post(
                UserRate.self,
                to: "https://shikimori.one/api/v2/user_rates",
                withParameters: [
                    "user_rate" : [
                        "user_id": userId,
                        "target_id": animeId,
                        "target_type": "Anime"
                    ]
                ]
            ) { [unowned self] result in
                switch result {
                case .success(let userRate):
                    userRates.append(userRate)
                    NotificationCenter.default.post(name: .userRateChanged, object: nil)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func fetchAnimes(name: String, completion: @escaping () -> Void) {
        if name == "" {
            return
        }
        NetworkManager.shared.search(name) { [unowned self] result in
            switch result {
            case .success(let animes):
                self.animes = animes.data?.animes ?? []
                completion()
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func fetchUserRates() {
        let userId = UserDefaults.standard.integer(forKey: "userId")
        if userId != 0 && UserDefaults.standard.getOAuthToken() != nil {
            NetworkManager.shared.fetchWithAuthorization(
                [UserRate].self,
                from: "https://shikimori.one/api/v2/user_rates",
                withParameters: [
                    "user_id": userId
                ]
            ) { [unowned self] result in
                switch result {
                case .success(let userRates):
                    self.userRates = userRates
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getAnimeDetailsViewModel(at indexPath: IndexPath) -> AnimeDetailsViewModelProtocol {
        AnimeDetailsViewModel(animeId: Int(animes[indexPath.item].id) ?? 0)
    }
    
    func getAnimeCellViewModel(at indexPath: IndexPath) -> AnimeCellViewModelProtocol {
        AnimeCellViewModel(anime: animes[indexPath.item])
    }
}
