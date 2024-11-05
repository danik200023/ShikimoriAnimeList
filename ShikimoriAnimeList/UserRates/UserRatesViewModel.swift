//
//  UserRatesViewModel.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 02.11.2024.
//

import Foundation
import ShikimoriAPI

protocol UserRatesViewModelProtocol {
    var isLoggedIn: Bool { get }
    var url: URL { get }
    func loginButtonAction() -> Void
    func numberOfRowsInSection(_ section: Int, andTab tab: Int) -> Int
    func fetchUserRates(completion: @escaping () -> Void)
    func getUserRateCellViewModel(at indexPath: IndexPath, andSegment segment: Int) -> UserRatesCellViewModelProtocol
}

final class UserRatesViewModel: UserRatesViewModelProtocol {
    private var user: User?
    private var userRates: [[UserRatesQuery.Data.UserRate]] = [[],[],[],[]]
    var isLoggedIn: Bool {
        AuthManager.shared.isLoggedIn
    }
    
    var url: URL {
        URL(string: "https://shikimori.one/oauth/authorize?client_id=wfUWoNxEIwfseLQ5vGJfQjeVOAAELibJw5zbOmCVnrc&redirect_uri=shikimoriapp%3A%2F%2Fcallback&response_type=code&scope=user_rates")!
    }
    
    func numberOfRowsInSection(_ section: Int, andTab tab: Int) -> Int {
        userRates[tab].count
    }
    
    func fetchUserRates(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchUserRates { [unowned self] result in
            switch result {
            case .success(let value):
                value.data?.userRates.forEach({ userRate in
                    switch userRate.status {
                    case .case(let status):
                        switch status {
                        case .watching, .rewatching:
                            userRates[0].append(userRate)
                        case .planned:
                            userRates[1].append(userRate)
                        case .completed:
                            userRates[2].append(userRate)
                        case .onHold, .dropped:
                            userRates[3].append(userRate)
                        }
                    case .unknown(_):
                        break
                    }
                })
//                userRates = value.data?.userRates ?? []
//                print(userRates)
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loginButtonAction() {
        AuthManager.shared.startAuthentication { result in
            switch result {
            case .success(_): break
            case .failure(_): break
            }
        }
    }
    
    func getUserRateCellViewModel(at indexPath: IndexPath, andSegment segment: Int) -> UserRatesCellViewModelProtocol {
        UserRatesCellViewModel(userRate: userRates[segment][indexPath.row])
    }
}

