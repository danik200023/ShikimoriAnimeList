//
//  OngoingCellHeaderViewModel.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 25.10.2024.
//

import Foundation

protocol OngoingCellHeaderViewModelProtocol {
    var title: String { get }
    init(name: String)
}

final class OngoingCellHeaderViewModel: OngoingCellHeaderViewModelProtocol {
    var title: String {
        name
    }
    
    private let name: String
    
    init(name: String) {
        self.name = name
    }
    
    
}
