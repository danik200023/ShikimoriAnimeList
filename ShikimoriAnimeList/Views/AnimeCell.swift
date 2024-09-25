//
//  CollectionViewCell.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 15.08.2024.
//

import UIKit
import Kingfisher

class AnimeCell: UICollectionViewCell {
    @IBOutlet var animeImageView: UIImageView!
    @IBOutlet var animeName: UILabel!
    @IBOutlet var russianAnimeName: UILabel!
    @IBOutlet var numberOfEpisodes: UILabel!
    
    func configure(with anime: Anime) {
        russianAnimeName.text = anime.russian
        animeName.text = anime.name
        numberOfEpisodes.text = "Эпизодов: \(anime.episodes)"
        let imageUrl = URL(string: "https://desu.shikimori.one\(anime.image.original)")!
        animeImageView.kf.indicatorType = .activity
        animeImageView.kf.setImage(with: imageUrl)
    }
}
