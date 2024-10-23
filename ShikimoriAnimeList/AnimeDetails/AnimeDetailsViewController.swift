//
//  AnimeDetailsViewController.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 16.08.2024.
//

import UIKit
import Kingfisher

final class AnimeDetailsViewController: UIViewController {
    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var typeLabel: UILabel!
    @IBOutlet private var episodesLabel: UILabel!
    @IBOutlet private var episodeDurationLabel: UILabel!
    @IBOutlet private var statusLabel: UILabel!
    @IBOutlet private var genresLabel: UILabel!
    @IBOutlet private var ratingLabel: UILabel!
    
    var viewModel: AnimeDetailsViewModelProtocol! {
        didSet {
            viewModel.fetchAnimeDetails { [unowned self] in
                setupUI()
            }
        }
    }
    
    private func setupUI() {
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(with: viewModel.posterUrl)
        typeLabel.text = viewModel.type
        episodesLabel.text = viewModel.episodes
        episodeDurationLabel.text = viewModel.episodeDuration
        statusLabel.text = viewModel.status
        genresLabel.text = viewModel.genres
        ratingLabel.text = viewModel.rating
    }
}
