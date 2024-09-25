//
//  DetailsViewController.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 16.08.2024.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    @IBOutlet var posterImageView: UIImageView!
    
    var anime: Anime!
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = anime.russian
        
        let url = URL(string: "https://desu.shikimori.one\(anime.image.original)")!
        posterImageView.kf.setImage(with: url)
    }
}
