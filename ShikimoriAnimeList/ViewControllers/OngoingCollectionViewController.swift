//
//  OngoingCollectionViewController.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 13.08.2024.
//

import UIKit

final class OngoingCollectionViewController: UICollectionViewController {
    
    private var animes: [Anime] = []
    private var userProfile: User?
    
    private let initialPage = 1
    private var currentPage = 1
    private var isLoading = false
    private var hasMorePages = true
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAnime()
        if UserDefaults.standard.getOAuthToken() != nil {
            fetchUserProfile()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsVC = segue.destination as? DetailsViewController {
            detailsVC.anime = sender as? Anime
            detailsVC.userProfile = userProfile
        }
    }
    
    private func fetchUserProfile() {
        networkManager.fetchWithAuthorization(
            User.self,
            from: "https://shikimori.one/api/users/whoami"
        ) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let loadedUser):
                userProfile = loadedUser
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchAnime() {
        guard !isLoading, hasMorePages else { return }
        isLoading = true
        
        NetworkManager.shared.fetchWithoutAuthorization(
            [Anime].self,
            from: "https://shikimori.one/api/animes",
            withParameters: [
                "status": "ongoing",
                "order":"ranked",
                "limit": 50,
                "page": currentPage
            ]
        ) { [weak self] result in
            guard let self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let newAnimes):
                if newAnimes.isEmpty {
                    self.hasMorePages = false
                } else {
                    self.animes.append(contentsOf: newAnimes)
                    self.currentPage += 1
                    self.collectionView.reloadData()
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: UICollectionViewDataSource
extension OngoingCollectionViewController {
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
extension OngoingCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: animes[indexPath.item])
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension OngoingCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: view.bounds.width / 2 - 48, height: (view.bounds.width / 2 - 48) / 7 * 10)
    }
}

// MARK: UIScrollViewDelegate
extension OngoingCollectionViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.bounds.height
        
        if offsetY > contentHeight - height - 100 {
            fetchAnime()
        }
    }
}
