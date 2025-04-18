//
//  UserRateDetailsViewModel.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 07.11.2024.
//

import Combine
import Foundation
import ShikimoriAPI

protocol UserRateDetailsViewModelProtocol {
    var animeName: String? { get }
    var episodesWatched: String { get }
    var rewatches: String { get }
    var totalEpisodes: String { get }
    var status: UserRateStatusEnum { get }
    var statusPublisher: Published<UserRateStatusEnum>.Publisher { get }
    var numberOfWatchedEpisodesPublisher: Published<String>.Publisher { get }
    init(userRate: UserRateGraphQL)
    func isValidWatchedEpisodesCount(_ episodes: Int) -> Bool
    func isValidRewatchesCount(_ rewatches: Int) -> Bool
    func setStatus(_ status: UserRateStatusEnum)
    func setNumberOfRewatches(_ rewatches: Int)
    func setNumberOfWatchedEpisodes(_ watchedEpisodes: Int)
    func deleteRate(completion: @escaping () -> Void)
    func incrementWatchedEpisodes()
    func decrementWatchedEpisodes()
}

final class UserRateDetailsViewModel: UserRateDetailsViewModelProtocol {
    @Published private(set) var status: UserRateStatusEnum
    @Published private(set) var numberOfWatchedEpisodes: String

    var animeName: String? {
        userRate.animeData?.russian != ""
            ? userRate.animeData?.russian : userRate.animeData?.name
    }

    var episodesWatched: String {
        "\(userRate.episodes)"
    }

    var rewatches: String {
        "\(userRate.rewatches)"
    }
    
    var totalEpisodes: String {
        if let episodesAired = userRate.animeData?.episodesAired, episodesAired != 0 {
            return "/\(episodesAired)"
        } else {
            return "/\(userRate.animeData?.episodes ?? 0)"
        }
    }

    var statusPublisher: Published<UserRateStatusEnum>.Publisher {
        $status
    }

    var numberOfWatchedEpisodesPublisher: Published<String>.Publisher {
        $numberOfWatchedEpisodes
    }

    private let userRate: UserRateGraphQL

    init(userRate: UserRateGraphQL) {
        self.userRate = userRate
        self.status = userRate.status.value ?? .planned
        self.numberOfWatchedEpisodes = userRate.episodes.formatted()
    }

    func isValidWatchedEpisodesCount(_ episodes: Int) -> Bool {
        switch userRate.animeData?.status?.value {
        case .released:
            return episodes <= userRate.animeData?.episodes ?? 0
        case .ongoing:
            return episodes <= userRate.animeData?.episodesAired ?? 0
        case .anons:
            return episodes <= 0
        case .none:
            return false
        }
    }

    func isValidRewatchesCount(_ rewatches: Int) -> Bool {
        rewatches >= 0
    }

    func setStatus(_ status: UserRateStatusEnum) {
        NetworkManager.shared.patch(
            UserRate.self,
            to: "https://shikimori.one/api/v2/user_rates/\(userRate.id)",
            withParameters: [
                "user_rate": [
                    "status": status.rawValue
                ]
            ]
        ) { [unowned self] result in
            switch result {
            case .success(_):
                self.status = status
                NotificationCenter.default.post(
                    name: .userRateChanged, object: nil)
            case .failure(let error):
                print(error)
            }
        }
    }

    func setNumberOfRewatches(_ rewatches: Int) {
        NetworkManager.shared.patch(
            UserRate.self,
            to: "https://shikimori.one/api/v2/user_rates/\(userRate.id)",
            withParameters: [
                "user_rate": [
                    "rewatches": "\(rewatches)"
                ]
            ]
        ) { result in
            switch result {
            case .success(_):
                NotificationCenter.default.post(
                    name: .userRateChanged, object: nil)
            case .failure(let error):
                print(error)
            }
        }
    }

    func setNumberOfWatchedEpisodes(_ watchedEpisodes: Int) {
        NetworkManager.shared.patch(
            UserRate.self,
            to: "https://shikimori.one/api/v2/user_rates/\(userRate.id)",
            withParameters: [
                "user_rate": [
                    "episodes": "\(watchedEpisodes)"
                ]
            ]
        ) { result in
            switch result {
            case .success(_):
                NotificationCenter.default.post(
                    name: .userRateChanged, object: nil)
            case .failure(let error):
                print(error)
            }
        }
    }

    func deleteRate(completion: @escaping () -> Void) {
        NetworkManager.shared.delete(
            at: "https://shikimori.one/api/v2/user_rates/\(userRate.id)"
        ) { result in
            switch result {
            case .success(_):
                NotificationCenter.default.post(name: .userRateChanged, object: nil)
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }

    func incrementWatchedEpisodes() {
        NetworkManager.shared.post(
            UserRate.self,
            to:
                "https://shikimori.one/api/v2/user_rates/\(userRate.id)/increment"
        ) { [unowned self] result in
            switch result {
            case .success(let value):
                numberOfWatchedEpisodes = value.episodes.formatted()
                NotificationCenter.default.post(
                    name: .userRateChanged, object: nil)
            case .failure(let error):
                print(error)
            }
        }
    }

    func decrementWatchedEpisodes() {
        NetworkManager.shared.patch(
            UserRate.self,
            to: "https://shikimori.one/api/v2/user_rates/\(userRate.id)",
            withParameters: [
                "user_rate": [
                    "episodes": "\((Int(numberOfWatchedEpisodes) ?? 0) - 1)"
                ]
            ]

        ) { [unowned self] result in
            switch result {
            case .success(let value):
                numberOfWatchedEpisodes = value.episodes.formatted()
                NotificationCenter.default.post(
                    name: .userRateChanged, object: nil)
            case .failure(let error):
                print(error)
            }
        }
    }
}
