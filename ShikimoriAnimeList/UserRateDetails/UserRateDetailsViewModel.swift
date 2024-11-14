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
    var status: UserRateStatusEnum { get }
    var statusPublisher: Published<UserRateStatusEnum>.Publisher { get }
    init(userRate: UserRatesQuery.Data.UserRate)
    func setStatus(_ status: UserRateStatusEnum)
}

final class UserRateDetailsViewModel: UserRateDetailsViewModelProtocol {
    @Published private(set) var status: UserRateStatusEnum
    
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
                    NotificationCenter.default.post(name: .userStatusChanged, object: nil)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
