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
    @IBOutlet var statusLabel: UILabel!
    
    var anime: Anime!
    var userProfile: User!
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = anime.russian
        
        let url = URL(string: "https://desu.shikimori.one\(anime.image.original)")!
        posterImageView.kf.setImage(with: url)
        
        if userProfile != nil {
            statusLabel.isHidden = false
            networkManager.fetchWithAuthorization(
                [UserRate].self,
                from: "https://shikimori.one/api/v2/user_rates/?user_id=\(userProfile.id)&target_id=\(anime.id)&target_type=Anime"
            ) { [unowned self] result in
                switch result {
                case .success(let userRates):
                    if let userRate = userRates.first {
                        statusLabel.text = "Статус: \(userRate.statusLocalized)"
                    } else {
                        statusLabel.text = "Добавить в список"
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
