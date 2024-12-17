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
    func moveCell(completion: @escaping () -> Void) -> Void
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
        print(userRates[tab].count)
        return userRates[tab].count
    }
    
    func fetchUserRates(completion: @escaping () -> Void) {
        fetchUserRates(page: 1, completion: completion)
    }
    
    // TODO: - Сделать нормальную реализацию, когда будет доступен метод на api
    func moveCell(completion: @escaping () -> Void) {
        userRates = [[],[],[],[]]
        fetchUserRates(completion: completion)
    }
    
    private func fetchUserRates(page: Int, completion: @escaping () -> Void) {
        NetworkManager.shared.fetchUserRates(page: page) { [unowned self] result in
            switch result {
            case .success(let value):
                value.data?.userRates.forEach({ userRate in
                    switch userRate.status.value {
                    case .watching, .rewatching:
                        userRates[0].append(userRate)
                    case .planned:
                        userRates[1].append(userRate)
                    case .completed:
                        userRates[2].append(userRate)
                    case .onHold, .dropped:
                        userRates[3].append(userRate)
                    case .none:
                        break
                    }
                })
                if value.data?.userRates.count == 50 {
                    fetchUserRates(page: page + 1, completion: completion)
                } else {
                    completion()
                }
            case .failure(let error):
                print(error)
                completion()
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

