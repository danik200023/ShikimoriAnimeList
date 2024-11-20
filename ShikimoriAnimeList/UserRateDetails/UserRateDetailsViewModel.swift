//
//  UserRateDetailsViewModel.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 07.11.2024.
//

import ShikimoriAPI
import Combine
import Foundation

protocol UserRateDetailsViewModelProtocol {
    var animeName: String? { get }
    var episodesWatched: String { get }
    var rewatches: String { get }
    var status: UserRateStatusEnum { get }
    var statusPublisher: Published<UserRateStatusEnum>.Publisher { get }
    init(userRate: UserRatesQuery.Data.UserRate)
    func setStatus(_ status: UserRateStatusEnum)
    func deleteRate(completion: @escaping () -> Void)
}

final class UserRateDetailsViewModel: UserRateDetailsViewModelProtocol {
    @Published private(set) var status: UserRateStatusEnum
    
    var animeName: String? {
        userRate.anime?.russian != "" ? userRate.anime?.russian : userRate.anime?.name
    }
    
    var episodesWatched: String {
        "\(userRate.episodes)"
    }
    
    var rewatches: String {
        "\(userRate.rewatches)"
    }
    
    var statusPublisher: Published<UserRateStatusEnum>.Publisher {
        $status
    }
    
    private let userRate: UserRatesQuery.Data.UserRate
    
    init(userRate: UserRatesQuery.Data.UserRate) {
        self.userRate = userRate
        self.status = userRate.status.value ?? .planned
    }
    
    func setStatus(_ status: UserRateStatusEnum) {
        NetworkManager.shared.patch(
            UserRate.self,
            to: "https://shikimori.one/api/v2/user_rates/\(userRate.id)",
            withParameters: [
                "user_rate" : [
                    "status": status.rawValue
                ]
            ]) { [unowned self] result in
                switch result {
                case .success(_):
                    self.status = status
                    NotificationCenter.default.post(name: .userRateChanged, object: nil)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func deleteRate(completion: @escaping () -> Void) {
        NetworkManager.shared.delete(at: "https://shikimori.one/api/v2/user_rates/\(userRate.id)") { result in
            switch result {
            case .success(_):
                NotificationCenter.default.post(name: .userRateChanged, object: nil)
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
}
