//
//  UserRatesCellViewModel.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 02.11.2024.
//

import Foundation
import ShikimoriAPI

protocol UserRatesCellViewModelProtocol {
    var animeName: String { get }
    var details: String { get }
    var watchedEpisodes: String { get }
    var posterUrl: URL { get }
    init(userRate: UserRatesQuery.Data.UserRate)
    func getUserRateDetailsViewModel() -> UserRateDetailsViewModelProtocol
    func getAnimeDetailsViewModel() -> AnimeDetailsViewModelProtocol
}

final class UserRatesCellViewModel: UserRatesCellViewModelProtocol {
    var animeName: String {
        userRate.anime?.russian ?? userRate.anime?.name ?? ""
    }
    
    var details: String {
        "\(yearOrStatus) • \(kind)"
    }
    
    var watchedEpisodes: String {
        let episodesAired = userRate.anime?.episodesAired ?? 0
        return "\(userRate.episodes)/\(episodesAired != 0 ? episodesAired : userRate.anime?.episodes ?? 0)"
    }
    
    var posterUrl: URL {
        URL(string: userRate.anime?.posterUrl ?? "https://shikimori.one/assets/globals/missing/main@2x.png")!
    }
    
    private var kind: String {
        switch userRate.anime?.kind?.value {
        case .tv:
            return "TV"
        case .movie:
            return "Фильм"
        case .ova:
            return "OVA"
        case .ona:
            return "ONA"
        case .special:
            return "Спецвыпуск"
        case .tvSpecial:
            return "TV спецвыпуск"
        case .music:
            return "Клип"
        case .pv:
            return "Проморолик"
        case .cm:
            return "Реклама"
        case .none:
            return ""
        }
    }
    
    private var yearOrStatus: String {
        if let year = userRate.anime?.airedOnYear {
            return "\(year)"
        } else {
            switch userRate.anime?.status?.value {
            case .anons:
                return "Анонс"
            case .ongoing:
                return "Онгоинг"
            case .released:
                return "Релиз"
            case .none:
                return ""
            }
        }
    }
    
    private let userRate: UserRatesQuery.Data.UserRate
    
    init(userRate: UserRatesQuery.Data.UserRate) {
        self.userRate = userRate
    }
    
    func getUserRateDetailsViewModel() -> UserRateDetailsViewModelProtocol {
        UserRateDetailsViewModel(userRate: UserRateGraphQL(from: userRate))
    }
    
    func getAnimeDetailsViewModel() -> AnimeDetailsViewModelProtocol {
        AnimeDetailsViewModel(animeId: userRate.anime?.id ?? "0")
    }
}
