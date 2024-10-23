//
//  CollectionViewCell.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 15.08.2024.
//

import UIKit
import Kingfisher

final class AnimeCell: UICollectionViewCell {
    @IBOutlet var animeImageView: UIImageView!
    @IBOutlet var animeNameLabel: UILabel!
    @IBOutlet var numberOfEpisodesLabel: UILabel!
    
    var viewModel: AnimeCellViewModelProtocol! {
        didSet {
            animeNameLabel.text = viewModel.animeName
            numberOfEpisodesLabel.text = viewModel.numberOfEpisodes
            animeImageView.kf.indicatorType = .activity
            animeImageView.kf.setImage(with: viewModel.posterUrl)
        }
    }
}
