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
    @IBOutlet var russianAnimeName: UILabel!
    @IBOutlet var numberOfEpisodes: UILabel!
    
    func configure(with anime: Anime) {
        russianAnimeName.text = anime.russian != "" ? anime.russian : anime.name
        numberOfEpisodes.text = "[\(anime.episodesAired) из \(anime.episodes == 0 ? "?" : "\(anime.episodes)")]"
        let imageUrl = URL(string: "https://desu.shikimori.one\(anime.image.original)")!
        animeImageView.kf.indicatorType = .activity
        animeImageView.kf.setImage(with: imageUrl)
    }
}
