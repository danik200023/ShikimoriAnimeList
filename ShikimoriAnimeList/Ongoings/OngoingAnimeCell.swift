//
//  OngoingAnimeCell.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 30.10.2024.
//

import UIKit
import Kingfisher

final class OngoingAnimeCell: UICollectionViewCell {
    @IBOutlet var animeImageView: UIImageView!
    @IBOutlet var animeNameLabel: UILabel!
    @IBOutlet var numberOfEpisodesLabel: UILabel!
    
    var viewModel: OngoingAnimeCellViewModelProtocol! {
        didSet {
            animeNameLabel.text = viewModel.animeName
            numberOfEpisodesLabel.text = viewModel.numberOfEpisodes
            animeImageView.kf.indicatorType = .activity
            animeImageView.kf.setImage(with: viewModel.posterUrl)
        }
    }
}
