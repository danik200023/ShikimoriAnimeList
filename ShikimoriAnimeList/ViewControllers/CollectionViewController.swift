//
//  ViewController.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 13.08.2024.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    private var animes: [Anime] = []
    
    private let apiUrl = URL(
        string: "https://shikimori.one/api/animes?order=popularity&limit=10"
    )!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAnime()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsVC = segue.destination as? DetailsViewController {
            detailsVC.anime = sender as? Anime
        }
    }
    
    private func fetchAnime() {
        NetworkManager.shared.fetch(
            [Anime].self,
            from: apiUrl
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let animes):
                self.animes = animes
                collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: UICollectionViewDataSource
extension CollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        animes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier:"animeCell",
            for: indexPath
        )
        guard let cell = cell as? AnimeCell else { return UICollectionViewCell() }
        let anime = animes[indexPath.item]
        cell.configure(with: anime)
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension CollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: animes[indexPath.item])
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: view.bounds.width - 48, height: 170)
    }
}

