//
//  SearchViewController.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 29.01.2025.
//

import UIKit

class SearchViewController: UIViewController {
    private let loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private lazy var searchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .init(top: 0, left: 32, bottom: 0, right: 32)
        
        let searchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        searchCollectionView.translatesAutoresizingMaskIntoConstraints = false
        searchCollectionView.dataSource = self
        searchCollectionView.delegate = self
        searchCollectionView.register(AnimeCell.self, forCellWithReuseIdentifier: "searchCell")
        return searchCollectionView
    }()
    
    var viewModel: SearchViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel = SearchViewModel()
        configureSearchController()
        configureSearchCollectionView()
        configureLoadingView()
    }
    
    private func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func configureSearchCollectionView() {
        view.addSubview(searchCollectionView)
        NSLayoutConstraint.activate([
            searchCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureLoadingView() {
        view.addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }

}

// MARK: UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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

// MARK: UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let animeDetailsVC = AnimeDetailsViewController()
        animeDetailsVC.viewModel = viewModel.getAnimeDetailsViewModel(at: indexPath)
        navigationController?.pushViewController(animeDetailsVC, animated: true)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
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
//            viewModel.fetchAnimes(name: "bb") { [unowned self] in
//                collectionView.reloadData()
//            }
//        }
//    }
//}

//MARK: - UIContextMenuInteractionDelegate
extension SearchViewController: UIContextMenuInteractionDelegate {
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
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        if query != "" {
            loadingView.isHidden = false
            viewModel.fetchAnimes(name: query) { [unowned self] in
                loadingView.isHidden = true
                searchCollectionView.reloadData()
            }
        }
    }
}

