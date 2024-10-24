//
//  SearchCollectionViewController.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 24.10.2024.
//

import UIKit

final class SearchCollectionViewController: UICollectionViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var viewModel: SearchViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        viewModel = SearchViewModel()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

// MARK: UICollectionViewDataSource
extension SearchCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier:"searchCell",
            for: indexPath
        )
        guard let cell = cell as? AnimeCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel.getAnimeCellViewModel(at: indexPath)
        let interaction = UIContextMenuInteraction(delegate: self)
        cell.addInteraction(interaction)
        return cell
    }
}

//// MARK: UICollectionViewDelegate
//extension SearchCollectionViewController {
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "showDetails", sender: viewModel.getAnimeDetailsViewModel(at: indexPath))
//    }
//}

// MARK: UICollectionViewDelegateFlowLayout
extension SearchCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: view.bounds.width / 2 - 48, height: (view.bounds.width / 2 - 48) / 7 * 10)
    }
}

//// MARK: UIScrollViewDelegate
//extension SearchCollectionViewController {
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//        let height = scrollView.bounds.height
//        
//        if offsetY > contentHeight - height - 200 {
//            viewModel.fetchAnimes(query: "bb") { [unowned self] in
//                collectionView.reloadData()
//            }
//        }
//    }
//}

//MARK: - UIContextMenuInteractionDelegate
extension SearchCollectionViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        guard let cell = interaction.view as? AnimeCell else { return nil }
        let animeId = cell.viewModel.animeId
        var actions: [UIAction] = []
        return UIContextMenuConfiguration(actionProvider:  { [unowned self] _ in
            let addAction = UIAction(title: "Добавить в список", image: UIImage(systemName: "plus")) { [unowned self] action in
                viewModel.addToList(animeId)
            }
            if !viewModel.isInUserRates(id: animeId) {
                actions.append(addAction)
            }
            let shareAction = UIAction(title: "Поделиться", image: UIImage(systemName: "square.and.arrow.up")) { action in
                print("Действие 2")
            }
            actions.append(shareAction)
            return UIMenu(title: "", children: actions)
        })
    }
}

//MARK: - UISearchResultUpdating
extension SearchCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        viewModel.fetchAnimes(query: query) { [unowned self] in
            collectionView.reloadData()
        }
    }
}
