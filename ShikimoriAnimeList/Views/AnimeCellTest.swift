//
//  CollectionViewCell.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 15.08.2024.
//

import UIKit
import Kingfisher

class AnimeCellTest: UICollectionViewCell {
    @IBOutlet var animeImageView: UIImageView!
    
    func configure(with anime: Anime) {
        let imageUrl = URL(string: "https://desu.shikimori.one\(anime.image.original)")!
        animeImageView.kf.indicatorType = .activity
        animeImageView.kf.setImage(with: imageUrl)
    }
}
