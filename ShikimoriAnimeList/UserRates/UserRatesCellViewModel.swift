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
}

final class UserRatesCellViewModel: UserRatesCellViewModelProtocol {
    var animeName: String {
        userRate.anime?.russian ?? userRate.anime?.name ?? ""
    }
    
    var details: String {
        if let year = userRate.anime?.airedOn?.year {
            return "\(year) • \(userRate.anime?.kind?.rawValue ?? "") • \(userRate.anime?.episodes ?? 0)"
        } else {
            return "\(userRate.anime?.status?.rawValue ?? "") • \(userRate.anime?.kind?.rawValue ?? "") • \(userRate.anime?.episodes ?? 0)"
        }
    }
    
    var watchedEpisodes: String {
        "\(userRate.episodes)"
    }
    
    var posterUrl: URL {
        URL(string: userRate.anime?.poster?.mainUrl ?? "https://shikimori.one/assets/globals/missing/main@2x.png")!
    }
    
    private let userRate: UserRatesQuery.Data.UserRate
    
    init(userRate: UserRatesQuery.Data.UserRate) {
        self.userRate = userRate
    }
    
    func getUserRateDetailsViewModel() -> UserRateDetailsViewModelProtocol {
        UserRateDetailsViewModel(userRate: userRate)
    }
}
