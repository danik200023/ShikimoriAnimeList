//
//  OngoingsCollectionViewController.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 13.08.2024.
//

import UIKit

final class OngoingsCollectionViewController: UICollectionViewController {
    var viewModel: OngoingsViewModelProtocol! {
        didSet {
            viewModel.fetchUser()
            viewModel.fetchAnimes { [unowned self] in
                collectionView.reloadData()
            }
        }
    }
    
    private var userProfile: User?
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = OngoingsViewModel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsVC = segue.destination as? AnimeDetailsViewController {
            detailsVC.viewModel = sender as? AnimeDetailsViewModel
        }
    }
}

// MARK: UICollectionViewDataSource
extension OngoingsCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier:"animeCell",
            for: indexPath
        )
        guard let cell = cell as? AnimeCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel.getAnimeCellViewModel(at: indexPath)
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension OngoingsCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: viewModel.getAnimeDetailsViewModel(at: indexPath))
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension OngoingsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: view.bounds.width / 2 - 48, height: (view.bounds.width / 2 - 48) / 7 * 10)
    }
}

// MARK: UIScrollViewDelegate
extension OngoingsCollectionViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.bounds.height
        
        if offsetY > contentHeight - height - 200 {
            viewModel.fetchAnimes { [unowned self] in
                collectionView.reloadData()
            }
        }
    }
}
