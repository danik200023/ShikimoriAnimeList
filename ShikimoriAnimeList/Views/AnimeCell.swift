//
//  CollectionViewCell.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 15.08.2024.
//

import UIKit

class AnimeCell: UICollectionViewCell {
    @IBOutlet var animeImageView: UIImageView!
    @IBOutlet var animeName: UILabel!
    @IBOutlet var russianAnimeName: UILabel!
    @IBOutlet var numberOfEpisodes: UILabel!
    
    private var spinnerView: UIActivityIndicatorView!
    
    func configure(with anime: Anime) {
        russianAnimeName.text = anime.russian
        animeName.text = anime.name
        numberOfEpisodes.text = "Эпизодов: \(anime.episodes)"
        showSpinner(in: animeImageView)
        let url = URL(string: "https://desu.shikimori.one\(anime.image.original)")!
        NetworkManager.shared.fetchImage(from: url, completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let imageData):
                self.animeImageView.image = UIImage(data: imageData)
                self.spinnerView.stopAnimating()
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func showSpinner(in view: UIView) {
        spinnerView = UIActivityIndicatorView()
        spinnerView.color = .white
        spinnerView.center = view.center
        spinnerView.startAnimating()
        spinnerView.hidesWhenStopped = true
        view.addSubview(spinnerView)
    }
}
