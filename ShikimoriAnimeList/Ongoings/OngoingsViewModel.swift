//
//  OngoingsViewModel.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 18.10.2024.
//

import Foundation

protocol OngoingsViewModelProtocol {
    var numberOfSections: Int { get }
    func numberOfItemsInSection(_ section: Int) -> Int
    func fetchAnimes(completion: @escaping() -> Void)
    func fetchUser()
    func getAnimeCellViewModel(at indexPath: IndexPath) -> OngoingAnimeCellViewModelProtocol
    func getAnimeDetailsViewModel(at indexPath: IndexPath) -> AnimeDetailsViewModelProtocol
    func getOngoingCellHeaderViewModel(at indexPath: IndexPath) -> OngoingCellHeaderViewModelProtocol
   
}

final class OngoingsViewModel: OngoingsViewModelProtocol {
    private var calendar: [[OngoingCalendar]] = []
    private var user: User?
    private var posters: [String: String] = [:]
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        calendar[section].count
    }
    
    var numberOfSections: Int {
        calendar.count
    }
    
    private func groupAnimesByDate(_ ongoingCalendar: [OngoingCalendar]) -> [[OngoingCalendar]] {
        let calendar = Calendar.current
        var groupedAnimes: [DateComponents: [OngoingCalendar]] = [:]
        
        for anime in ongoingCalendar {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            let date = dateFormatter.date(from: anime.nextEpisodeAt)!
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
            
            if groupedAnimes[dateComponents] != nil {
                groupedAnimes[dateComponents]?.append(anime)
            } else {
                groupedAnimes[dateComponents] = [anime]
            }
        }
        let sortedSections = groupedAnimes.keys.sorted { first, second in
            let firstDate = calendar.date(from: first)!
            let secondDate = calendar.date(from: second)!
            return firstDate < secondDate
        }
#warning("remove force unwrap")
        return sortedSections.map { groupedAnimes[$0]! }
    }
    
    private func sectionTitle(from date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        let date = dateFormatter.date(from: date)!
        let calendar = Calendar.current
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        if calendar.isDateInToday(date) {
            dateFormatter.dateFormat = "d MMMM"
            return "Сегодня, \(dateFormatter.string(from: date).capitalized)"
        } else {
            dateFormatter.dateFormat = "EEEE, d MMMM"
            return dateFormatter.string(from: date).capitalized
        }
    }
    
    private func fetchPostersInChinks(_ chunks: [[Int]], completion: @escaping () -> Void) {
        var remainingChunks = chunks
        
        func fetchNextChunk() {
            guard let chunk = remainingChunks.first else {
                completion()
                return
            }
    
            remainingChunks.removeFirst()
            
            NetworkManager.shared.fetchPosters(from: chunk) { result in
                switch result {
                case .success(let value):
                    value.data?.animes.forEach { [weak self] anime in
                        self?.posters[anime.id] = anime.poster?.mainUrl
                    }
                case .failure(let error):
                    print(error)
                }
                fetchNextChunk()
            }
        }
        fetchNextChunk()
    }
    
    func fetchAnimes(completion: @escaping () -> Void) {
        NetworkManager.shared.fetch([OngoingCalendar].self,from: "https://shikimori.one/api/calendar") { [unowned self] result in
            switch result {
            case .success(let ongoings):
                let animeIds = ongoings.map({ $0.anime.id })
                calendar = groupAnimesByDate(ongoings)
                let chunkedIds = stride(from: 0, to: animeIds.count, by: 50).map {
                    Array(animeIds[$0..<min($0 + 50, animeIds.count)])
                }
                
                fetchPostersInChinks(chunkedIds) {
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
        AnimeDetailsViewModel(animeId: String(calendar[indexPath.section][indexPath.item].anime.id))
    }
    
    func getAnimeCellViewModel(at indexPath: IndexPath) -> OngoingAnimeCellViewModelProtocol {
        let anime = calendar[indexPath.section][indexPath.item].anime
        return OngoingAnimeCellViewModel(anime: anime, poster: posters[String(anime.id)] ?? "")
    }
    
    func getOngoingCellHeaderViewModel(at indexpath: IndexPath) -> OngoingCellHeaderViewModelProtocol {
        OngoingCellHeaderViewModel(name: sectionTitle(from: calendar[indexpath.section][indexpath.item].nextEpisodeAt))
    }
}
