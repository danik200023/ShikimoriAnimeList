//
//  OngoingsViewController.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 13.08.2024.
//

import UIKit

final class OngoingsViewController: UIViewController {
    private lazy var ongoingsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .init(top: 0, left: 32, bottom: 0, right: 32)
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
        
        let ongoingsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        ongoingsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        ongoingsCollectionView.dataSource = self
        ongoingsCollectionView.delegate = self
        ongoingsCollectionView.register(OngoingAnimeCell.self, forCellWithReuseIdentifier: "ongoingCell")
        ongoingsCollectionView.register(OngoingCellHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "sectionHeader")
        return ongoingsCollectionView
    }()
    
    var viewModel: OngoingsViewModelProtocol! {
        didSet {
            viewModel.fetchUser()
            viewModel.fetchAnimes { [unowned self] in
                ongoingsCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Онгоинги"
        view.backgroundColor = .systemBackground
        viewModel = OngoingsViewModel()
        configureSearchCollectionView()
    }
    
    private func configureSearchCollectionView() {
        view.addSubview(ongoingsCollectionView)
        NSLayoutConstraint.activate([
            ongoingsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            ongoingsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            ongoingsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ongoingsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: UICollectionViewDataSource
extension OngoingsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection(section)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "sectionHeader",
            for: indexPath
        ) as? OngoingCellHeader else { return UICollectionReusableView() }
        sectionHeader.viewModel = viewModel.getOngoingCellHeaderViewModel(at: indexPath)
        return sectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier:"ongoingCell",
            for: indexPath
        )
        guard let cell = cell as? OngoingAnimeCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel.getAnimeCellViewModel(at: indexPath)
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension OngoingsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let animeDetailsVC = AnimeDetailsViewController()
        animeDetailsVC.viewModel = viewModel.getAnimeDetailsViewModel(at: indexPath)
        navigationController?.pushViewController(animeDetailsVC, animated: true)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension OngoingsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: view.bounds.width / 2 - 48, height: (view.bounds.width / 2 - 48) / 7 * 10)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           referenceSizeForHeaderInSection section: Int) -> CGSize {
            CGSize(width: collectionView.bounds.width, height: 50)
        }
}
