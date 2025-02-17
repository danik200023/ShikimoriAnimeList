//
//  OngoingAnimeCell.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 30.10.2024.
//

import UIKit
import Kingfisher

final class OngoingAnimeCell: UICollectionViewCell {
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
    
    private let opacityView: UIView = {
        let opacityView = UIView()
        opacityView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        opacityView.translatesAutoresizingMaskIntoConstraints = false
        return opacityView
    }()
    
    private let animeNameLabel: UILabel = {
        let animeNameLabel = UILabel()
        animeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        animeNameLabel.font = .systemFont(ofSize: 16)
        animeNameLabel.textColor = .white
        animeNameLabel.adjustsFontSizeToFitWidth = true
        animeNameLabel.minimumScaleFactor = 0.6
        animeNameLabel.numberOfLines = 0
        animeNameLabel.textAlignment = .center
        return animeNameLabel
    }()
    
    private let numberOfEpisodesLabel: UILabel = {
        let numberOfEpisodesLabel = UILabel()
        numberOfEpisodesLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfEpisodesLabel.font = .systemFont(ofSize: 14)
        numberOfEpisodesLabel.textColor = .white
        numberOfEpisodesLabel.adjustsFontSizeToFitWidth = true
        numberOfEpisodesLabel.minimumScaleFactor = 0.6
        numberOfEpisodesLabel.textAlignment = .center
        return numberOfEpisodesLabel
    }()
    
    var viewModel: OngoingAnimeCellViewModelProtocol! {
        didSet {
            animeNameLabel.text = viewModel.animeName
            numberOfEpisodesLabel.text = viewModel.numberOfEpisodes
            animeImageView.kf.indicatorType = .activity
            animeImageView.kf.setImage(with: viewModel.posterUrl)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAnimeImageView()
        configureOpacityView()
        configureLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureAnimeImageView() {
        contentView.addSubview(animeImageView)
        
        NSLayoutConstraint.activate([
            animeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            animeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            animeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            animeImageView.widthAnchor.constraint(equalTo: animeImageView.heightAnchor, multiplier: 7/10)
        ])
    }
    
    private func configureOpacityView() {
        animeImageView.addSubview(opacityView)
        
        NSLayoutConstraint.activate([
            opacityView.leadingAnchor.constraint(equalTo: animeImageView.leadingAnchor, constant: 0),
            opacityView.bottomAnchor.constraint(equalTo: animeImageView.bottomAnchor, constant: 0),
            opacityView.trailingAnchor.constraint(equalTo: animeImageView.trailingAnchor, constant: 0),
            opacityView.heightAnchor.constraint(equalTo: animeImageView.heightAnchor, multiplier: 4/10)
        ])
    }
    
    private func configureLabels() {
        opacityView.addSubview(animeNameLabel)
        opacityView.addSubview(numberOfEpisodesLabel)
        
        NSLayoutConstraint.activate([
            animeNameLabel.topAnchor.constraint(equalTo: opacityView.topAnchor, constant: 4),
            animeNameLabel.leadingAnchor.constraint(equalTo: opacityView.leadingAnchor, constant: 8),
            animeNameLabel.trailingAnchor.constraint(equalTo: opacityView.trailingAnchor, constant: -8),
            animeNameLabel.heightAnchor.constraint(equalTo: opacityView.heightAnchor, multiplier: 0.625),
            
            numberOfEpisodesLabel.centerXAnchor.constraint(equalTo: opacityView.centerXAnchor),
            numberOfEpisodesLabel.topAnchor.constraint(equalTo: animeNameLabel.bottomAnchor, constant: 4),
            numberOfEpisodesLabel.bottomAnchor.constraint(equalTo: opacityView.bottomAnchor, constant: -8)
        ])
    }
}
