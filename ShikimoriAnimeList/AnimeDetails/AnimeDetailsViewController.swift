//
//  AnimeDetailsViewController.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 16.08.2024.
//

import UIKit
import Kingfisher

final class AnimeDetailsViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let posterImageView: UIImageView = {
        let posterImageView = UIImageView()
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.layer.cornerRadius = 15
        posterImageView.clipsToBounds = true
        posterImageView.layer.borderWidth = 1
        posterImageView.layer.borderColor = UIColor.secondarySystemFill.cgColor
        posterImageView.kf.indicatorType = .activity
        return posterImageView
    }()

    private let russianNameLabel: UILabel = {
        let russianNameLabel = UILabel()
        russianNameLabel.translatesAutoresizingMaskIntoConstraints = false
        russianNameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        russianNameLabel.textColor = .label
        russianNameLabel.textAlignment = .center
        russianNameLabel.numberOfLines = 0
        return russianNameLabel
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 11)
        nameLabel.textColor = .label
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    private let propertiesScrollView: UIScrollView = {
        let propertiesScrollView = UIScrollView()
        propertiesScrollView.translatesAutoresizingMaskIntoConstraints = false
        propertiesScrollView.showsVerticalScrollIndicator = false
        propertiesScrollView.backgroundColor = .systemBackground
        return propertiesScrollView
    }()
    
    private let propertiesContentView: UIView = {
        let propertiesContentView = UIView()
        propertiesContentView.translatesAutoresizingMaskIntoConstraints = false
        return propertiesContentView
    }()
    
    private let statusDetailsLabel: UILabel = {
        let statusDetailsLabel = UILabel()
        return statusDetailsLabel
    }()
    
    private let statuslabel: UILabel = {
        let statuslabel = UILabel()
        statuslabel.font = .systemFont(ofSize: 11)
        return statuslabel
    }()
    
    private lazy var statusStackView: UIStackView = {
        let statusStackView = UIStackView(arrangedSubviews: [statusDetailsLabel, statuslabel])
        statusStackView.translatesAutoresizingMaskIntoConstraints = false
//        statusStackView.isLayoutMarginsRelativeArrangement = true
//        statusStackView.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
//        statusStackView.clipsToBounds = true
//        statusStackView.layer.cornerRadius = 10
//        statusStackView.layer.borderWidth = 1
//        statusStackView.layer.borderColor = UIColor.gray.cgColor
        statusStackView.axis = .vertical
        statusStackView.spacing = 5
        return statusStackView
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = .systemFont(ofSize: 11)
        descriptionLabel.textColor = .label
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
//    @IBOutlet private var typeLabel: UILabel!
//    @IBOutlet private var episodesLabel: UILabel!
//    @IBOutlet private var episodeDurationLabel: UILabel!
//    @IBOutlet private var statusLabel: UILabel!
//    @IBOutlet private var genresLabel: UILabel!
//    @IBOutlet private var ratingLabel: UILabel!
    
    var viewModel: AnimeDetailsViewModelProtocol! {
        didSet {
            viewModel.fetchAnimeDetails { [weak self] in
                self?.setupUI()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel = AnimeDetailsViewModel(animeId: 57635)
        viewModel = AnimeDetailsViewModel(animeId: 20)
        configureScrollView()
        configurePosterImageView()
        configureRussianNameLabel()
        configureNameLabel()
        configurePropertiesScrollView()
        configurePropertiesContentView()
        configureStatusStackView()
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configurePosterImageView() {
        scrollView.addSubview(posterImageView)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            posterImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.4),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 10/7)
        ])
    }
    
    private func configureRussianNameLabel() {
        scrollView.addSubview(russianNameLabel)
        
        NSLayoutConstraint.activate([
            russianNameLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10),
            russianNameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            russianNameLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.8)
        ])
    }
    
    private func configureNameLabel() {
        scrollView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: russianNameLabel.bottomAnchor, constant: 6),
            nameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.8)
        ])
    }
    
    private func configurePropertiesScrollView() {
        scrollView.addSubview(propertiesScrollView)
        
        NSLayoutConstraint.activate([
            propertiesScrollView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            propertiesScrollView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 16),
            propertiesScrollView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16),
            propertiesScrollView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func configurePropertiesContentView() {
        propertiesScrollView.addSubview(propertiesContentView)
        
        NSLayoutConstraint.activate([
            propertiesContentView.topAnchor.constraint(equalTo: propertiesScrollView.topAnchor),
            propertiesContentView.leadingAnchor.constraint(equalTo: propertiesScrollView.leadingAnchor),
            propertiesContentView.trailingAnchor.constraint(equalTo: propertiesScrollView.trailingAnchor),
            propertiesContentView.bottomAnchor.constraint(equalTo: propertiesScrollView.bottomAnchor)
            
        ])
    }
    
    private func configureStatusStackView() {
        propertiesContentView.addSubview(statusStackView)
        
        NSLayoutConstraint.activate([
            statusStackView.topAnchor.constraint(equalTo: propertiesContentView.topAnchor),
            statusStackView.leadingAnchor.constraint(equalTo: propertiesContentView.leadingAnchor),
            statusStackView.bottomAnchor.constraint(equalTo: propertiesContentView.bottomAnchor),
            statusStackView.trailingAnchor.constraint(equalTo: propertiesContentView.trailingAnchor)
        ])
    }
    
    private func setupUI() {
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(with: viewModel.posterUrl)
        russianNameLabel.text = viewModel.russianName
        nameLabel.text = viewModel.name
//        typeLabel.text = viewModel.type
//        episodesLabel.text = viewModel.episodes
//        episodeDurationLabel.text = viewModel.episodeDuration
        statusDetailsLabel.text = viewModel.statusDetails
        statuslabel.text = viewModel.status
//        genresLabel.text = viewModel.genres
//        ratingLabel.text = viewModel.rating
    }
}
