//
//  UserRatesCell.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 02.11.2024.
//

import UIKit
import Kingfisher

protocol UserRatesCellDelegate: AnyObject {
    func editButtonButtonTapped(in cell: UserRatesCell)
}

final class UserRatesCell: UITableViewCell {
    private let animeImageView: UIImageView = {
        let animeImageView = UIImageView()
        animeImageView.translatesAutoresizingMaskIntoConstraints = false
        animeImageView.contentMode = .scaleAspectFit
        animeImageView.layer.cornerRadius = 15
        animeImageView.clipsToBounds = true
        animeImageView.layer.borderWidth = 1
        animeImageView.layer.borderColor = UIColor.secondarySystemFill.cgColor
        animeImageView.kf.indicatorType = .activity
        return animeImageView
    }()
    
    private let animeNameLabel: UILabel = {
        let animeNameLabel = UILabel()
        animeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        animeNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        animeNameLabel.adjustsFontSizeToFitWidth = true
        animeNameLabel.minimumScaleFactor = 0.6
        animeNameLabel.numberOfLines = 0
        return animeNameLabel
    }()
    
    private let detailsLabel: UILabel = {
        let detailsLabel = UILabel()
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.font = .systemFont(ofSize: 17)
        return detailsLabel
    }()
    
    private let watchedEpisodesLabel: UILabel = {
        let watchedEpisodesLabel = UILabel()
        watchedEpisodesLabel.translatesAutoresizingMaskIntoConstraints = false
        watchedEpisodesLabel.font = .systemFont(ofSize: 17)
        return watchedEpisodesLabel
    }()
    
    private lazy var editButton: UIButton = {
        let editButton = UIButton()
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.configuration = .tinted()
        editButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        editButton.addTarget(self, action: #selector(editButtonAction), for: .touchUpInside)
        return editButton
    }()
    
    weak var delegate: UserRatesCellDelegate?
    
    var viewModel: UserRatesCellViewModelProtocol! {
        didSet {
            animeNameLabel.text = viewModel.animeName
            detailsLabel.text = viewModel.details
            watchedEpisodesLabel.text = viewModel.watchedEpisodes
            animeImageView.kf.setImage(with: viewModel.posterUrl)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureAnimeImageView()
        configureAnimeNameLabel()
        configureDetailsLabel()
        configureWatchedEpisodesLabel()
        configureEditButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureAnimeImageView() {
        contentView.addSubview(animeImageView)
        NSLayoutConstraint.activate([
            animeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            animeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            animeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            animeImageView.widthAnchor.constraint(equalTo: animeImageView.heightAnchor, multiplier: 7/10)
        ])
    }
    
    private func configureAnimeNameLabel() {
        contentView.addSubview(animeNameLabel)
        NSLayoutConstraint.activate([
            animeNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            animeNameLabel.leadingAnchor.constraint(equalTo: animeImageView.trailingAnchor, constant: 16),
            animeNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            animeNameLabel.heightAnchor.constraint(lessThanOrEqualTo: contentView.heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func configureDetailsLabel() {
        contentView.addSubview(detailsLabel)
        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(equalTo: animeNameLabel.bottomAnchor, constant: 6),
            detailsLabel.leadingAnchor.constraint(equalTo: animeImageView.trailingAnchor, constant: 16),
            detailsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            detailsLabel.heightAnchor.constraint(equalToConstant: 21)
        ])
    }
    private func configureWatchedEpisodesLabel() {
        contentView.addSubview(watchedEpisodesLabel)
        NSLayoutConstraint.activate([
            watchedEpisodesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            watchedEpisodesLabel.leadingAnchor.constraint(equalTo: animeImageView.trailingAnchor, constant: 16),
            watchedEpisodesLabel.topAnchor.constraint(greaterThanOrEqualTo: detailsLabel.bottomAnchor, constant: 6),
            watchedEpisodesLabel.heightAnchor.constraint(equalToConstant: 21)
        ])
    }
    
    private func configureEditButton() {
        contentView.addSubview(editButton)
        NSLayoutConstraint.activate([
            editButton.leadingAnchor.constraint(equalTo: watchedEpisodesLabel.trailingAnchor, constant: 16),
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            editButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    @objc
    private func editButtonAction() {
        delegate?.editButtonButtonTapped(in: self)
    }
}


