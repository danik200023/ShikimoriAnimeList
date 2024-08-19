//
//  DetailsViewController.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 16.08.2024.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet var posterImageView: UIImageView!
    
    var anime: Anime!
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = anime.russian
        
        let url = URL(string: "https://desu.shikimori.one\(anime.image.original)")!
        networkManager.fetchImage(from: url, completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let poster):
                self.posterImageView.image = UIImage(data: poster)
            case .failure(let error):
                print(error)
            }
        })
    }
}
