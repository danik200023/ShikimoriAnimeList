//
//  OngoingsViewModel.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 18.10.2024.
//

import Foundation

protocol OngoingsViewModelProtocol {
    var numberOfItemsInSection: Int { get }
    func fetchAnimes(completion: @escaping() -> Void)
    func fetchUser()
    func getAnimeCellViewModel(at indexPath: IndexPath) -> AnimeCellViewModelProtocol
    func getAnimeDetailsViewModel(at indexPath: IndexPath) -> AnimeDetailsViewModelProtocol
   
}

final class OngoingsViewModel: OngoingsViewModelProtocol {
    private var animes: [Anime] = []
    private var user: User?
    private var isLoading = false
    private var hasMorePages = true
    private var currentPage = 1
    
    var numberOfItemsInSection: Int {
        animes.count
    }
    
    func fetchAnimes(completion: @escaping () -> Void) {
        guard !isLoading, hasMorePages else { return }
        isLoading = true
        NetworkManager.shared.fetchWithoutAuthorization(
            [Anime].self,
            from: "https://shikimori.one/api/animes",
            withParameters: [
                "status": "ongoing",
                "order":"ranked",
                "limit": 50,
                "page": currentPage
            ]
        ) { [unowned self] result in
            isLoading = false
            switch result {
            case .success(let newAnimes):
                if newAnimes.isEmpty {
                    hasMorePages = false
                } else {
                    animes.append(contentsOf: newAnimes)
                    currentPage += 1
                    completion()
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func fetchUser() {
        if UserDefaults.standard.getOAuthToken() != nil {
            NetworkManager.shared.fetchWithAuthorization(
                User.self,
                from: "https://shikimori.one/api/users/whoami"
            ) { [unowned self] result in
                switch result {
                case .success(let loadedUser):
                    user = loadedUser
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getAnimeDetailsViewModel(at indexPath: IndexPath) -> AnimeDetailsViewModelProtocol {
        AnimeDetailsViewModel(animeId: animes[indexPath.item].id, user: user)
    }
    
    func getAnimeCellViewModel(at indexPath: IndexPath) -> AnimeCellViewModelProtocol {
        AnimeCellViewModel(anime: animes[indexPath.item])
    }
}
