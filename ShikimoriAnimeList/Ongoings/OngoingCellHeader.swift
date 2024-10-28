//
//  OngoingCellHeader.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 25.10.2024.
//

import Foundation
import UIKit

final class OngoingCellHeader: UICollectionReusableView {
    @IBOutlet var titleLabel: UILabel!
    
    var viewModel: OngoingCellHeaderViewModelProtocol! {
        didSet {
            titleLabel.text = viewModel.title
        }
    }
}
