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

    private lazy var editButton: UIButton = {
        let editButton = UIButton()
        editButton.configuration = .gray()
        editButton.clipsToBounds = true
        editButton.setImage(UIImage(systemName: "pencil"), for: .normal)
//        editButton.addTarget(self, action: #selector(editButtonAction), for: .touchUpInside)
        return editButton
    }()
    
    private lazy var statusButton: UIButton = {
        let statusButton = UIButton()
        statusButton.configuration = .gray()
        statusButton.clipsToBounds = true
        statusButton.setImage(UIImage(systemName: "pencil"), for: .normal)
//        statusButton.addTarget(self, action: #selector(editButtonAction), for: .touchUpInside)
        return statusButton
    }()
    
    private lazy var editButtonsStackView: UIStackView = {
        let editButtonsStackView = UIStackView(arrangedSubviews: [editButton, statusButton])
        editButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        editButtonsStackView.axis = .vertical
        editButtonsStackView.distribution = .fillEqually
        return editButtonsStackView
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
        return propertiesScrollView
    }()
    
    private let propertiesContentView: UIView = {
        let propertiesContentView = UIView()
        propertiesContentView.translatesAutoresizingMaskIntoConstraints = false
        return propertiesContentView
    }()
    
    private let topBorderView: UIView = {
        let topBorderView = UIView()
        topBorderView.translatesAutoresizingMaskIntoConstraints = false
        topBorderView.backgroundColor = .systemGray
        return topBorderView
    }()
    
    private let bottomBorderView: UIView = {
        let bottomBorderView = UIView()
        bottomBorderView.translatesAutoresizingMaskIntoConstraints = false
        bottomBorderView.backgroundColor = .systemGray
        return bottomBorderView
    }()
    
    private let statusDetailsLabel: UILabel = {
        let statusDetailsLabel = UILabel()
        statusDetailsLabel.font = .systemFont(ofSize: 14, weight: .medium)
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
        statusStackView.axis = .vertical
        statusStackView.spacing = 5
        return statusStackView
    }()
    
    private let typeDetailsLabel: UILabel = {
        let typeDetailsLabel = UILabel()
        typeDetailsLabel.font = .systemFont(ofSize: 14, weight: .medium)
        typeDetailsLabel.text = "TV"
        return typeDetailsLabel
    }()
    
    private let typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.font = .systemFont(ofSize: 11)
        typeLabel.text = "Тип"
        return typeLabel
    }()
    
    private lazy var typeStackView: UIStackView = {
        let typeStackView = UIStackView(arrangedSubviews: [typeDetailsLabel, typeLabel])
        typeStackView.translatesAutoresizingMaskIntoConstraints = false
        typeStackView.axis = .vertical
        typeStackView.spacing = 5
        return typeStackView
    }()
    
    private let episodesDetailsLabel: UILabel = {
        let episodesDetailsLabel = UILabel()
        episodesDetailsLabel.font = .systemFont(ofSize: 14, weight: .medium)
        episodesDetailsLabel.text = "12"
        return episodesDetailsLabel
    }()
    
    private let episodesLabel: UILabel = {
        let episodesLabel = UILabel()
        episodesLabel.font = .systemFont(ofSize: 11)
        episodesLabel.text = "Эпизоды"
        return episodesLabel
    }()
    
    private lazy var episodesStackView: UIStackView = {
        let episodesStackView = UIStackView(arrangedSubviews: [episodesDetailsLabel, episodesLabel])
        episodesStackView.translatesAutoresizingMaskIntoConstraints = false
        episodesStackView.axis = .vertical
        episodesStackView.spacing = 5
        return episodesStackView
    }()
    
    private let episodeDurationDetailsLabel: UILabel = {
        let episodeDurationDescriptionLabel = UILabel()
        episodeDurationDescriptionLabel.font = .systemFont(ofSize: 14, weight: .medium)
        episodeDurationDescriptionLabel.text = "23 мин"
        return episodeDurationDescriptionLabel
    }()
    
    private let episodesDurationLabel: UILabel = {
        let episodesDurationLabel = UILabel()
        episodesDurationLabel.font = .systemFont(ofSize: 11)
        episodesDurationLabel.text = "Длительность эпизода"
        return episodesDurationLabel
    }()
    
    private lazy var episodesDurationStackView: UIStackView = {
        let episodesDurationStackView = UIStackView(arrangedSubviews: [episodeDurationDetailsLabel, episodesDurationLabel])
        episodesDurationStackView.translatesAutoresizingMaskIntoConstraints = false
        episodesDurationStackView.axis = .vertical
        episodesDurationStackView.spacing = 5
        return episodesDurationStackView
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Описание"
        descriptionLabel.font = .systemFont(ofSize: 17, weight: .medium)
        return descriptionLabel
    }()
    
    private let descriptionDetailsLabel: UILabel = {
        let descriptionDetailsLabel = UILabel()
        descriptionDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionDetailsLabel.font = .systemFont(ofSize: 14)
        descriptionDetailsLabel.numberOfLines = 0
        descriptionDetailsLabel.text = "«Это мой путь ниндзя!»\n\nВ день рождения Наруто Узумаки на деревню под названием Коноха напал легендарный демон, [character=7407]Девятихвостый лис[/character]. Четвёртый Хокагэ [波風ミナト] ценой своей жизни спас деревню, запечатав демона в новорождённом Наруто, неосознанно обрекая его на жизнь в ненависти односельчан.\nНесмотря на недостаток таланта во многих областях ниндзюцу, неусидчивость и задиристость, у Наруто есть мечта — стать [[Хокагэ]], сильнейшим ниндзя в деревне. Желая признания, которого не получал, он упорно работает и тренируется вместе со своими напарниками, Саскэ Учихой [うちは サスケ] и Сакурой Харуно [春野 サクラ], а также со своим наставником Какаши Хатакэ. Ему и его напарникам придётся пройти через многое по пути к своим заветным мечтам: сражения, любовь, дружба, предательство, жажда силы..."
        return descriptionDetailsLabel
    }()
    
    var viewModel: AnimeDetailsViewModelProtocol! {
        didSet {
            viewModel.fetchAnimeDetails { [weak self] in
                self?.setupUI()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        editButtonsStackView.spacing = editButtonsStackView.frame.height / 3
        
        statusButton.layer.cornerRadius = statusButton.frame.height / 2
        editButton.layer.cornerRadius = editButton.frame.width / 2
        
        print("Status Button Frame: \(statusButton.frame)")
        print("Edit Button Frame: \(editButton.frame)")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel = AnimeDetailsViewModel(animeId: 57635)
        viewModel = AnimeDetailsViewModel(animeId: 20)
        configureScrollView()
        configurePosterImageView()
        configureEditButtonsStackView()
        configureRussianNameLabel()
        configureNameLabel()
        configurePropertiesScrollView()
        configurePropertiesContentView()
        configureBorders()
        configureStatusStackView()
        configureTypeStackView()
        configureEpisodesStackView()
        configureEpisodesDurationStackView()
        configureDescriptionLabel()
        configureDescriptionDetailsLabel()
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
    
    private func configureEditButtonsStackView() {
        scrollView.addSubview(editButtonsStackView)

        NSLayoutConstraint.activate([
            editButtonsStackView.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor),
            editButtonsStackView.heightAnchor.constraint(equalTo:  posterImageView.heightAnchor, multiplier: 0.5),
            editButtonsStackView.widthAnchor.constraint(equalTo: editButtonsStackView.heightAnchor, multiplier: 1/3),
            editButtonsStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10)
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
            propertiesScrollView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            propertiesScrollView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            propertiesScrollView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func configurePropertiesContentView() {
        propertiesScrollView.addSubview(propertiesContentView)
        
        NSLayoutConstraint.activate([
//            propertiesContentView.topAnchor.constraint(equalTo: propertiesScrollView.topAnchor),
            propertiesContentView.leadingAnchor.constraint(equalTo: propertiesScrollView.leadingAnchor),
            propertiesContentView.trailingAnchor.constraint(equalTo: propertiesScrollView.trailingAnchor),
            propertiesContentView.centerYAnchor.constraint(equalTo: propertiesScrollView.centerYAnchor)
//            propertiesContentView.bottomAnchor.constraint(equalTo: propertiesScrollView.bottomAnchor)
            
        ])
    }
    
    private func configureBorders() {
        scrollView.addSubview(topBorderView)
        scrollView.addSubview(bottomBorderView)
        
        NSLayoutConstraint.activate([
            topBorderView.bottomAnchor.constraint(equalTo: propertiesScrollView.topAnchor, constant: -2),
            topBorderView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            topBorderView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            topBorderView.heightAnchor.constraint(equalToConstant: 1),
            bottomBorderView.topAnchor.constraint(equalTo: propertiesScrollView.bottomAnchor, constant: 2),
            bottomBorderView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            bottomBorderView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            bottomBorderView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func configureStatusStackView() {
        propertiesContentView.addSubview(statusStackView)
        NSLayoutConstraint.activate([
            statusStackView.topAnchor.constraint(equalTo: propertiesContentView.topAnchor),
            statusStackView.leadingAnchor.constraint(equalTo: propertiesContentView.leadingAnchor, constant: 16),
            statusStackView.bottomAnchor.constraint(equalTo: propertiesContentView.bottomAnchor)
        ])
    }
    
    private func configureTypeStackView() {
        propertiesContentView.addSubview(typeStackView)
        
        NSLayoutConstraint.activate([
            typeStackView.topAnchor.constraint(equalTo: propertiesContentView.topAnchor),
            typeStackView.leadingAnchor.constraint(equalTo: statusStackView.trailingAnchor, constant: 20),
            typeStackView.bottomAnchor.constraint(equalTo: propertiesContentView.bottomAnchor)
        ])
    }
    
    private func configureEpisodesStackView() {
        propertiesContentView.addSubview(episodesStackView)
        
        NSLayoutConstraint.activate([
            episodesStackView.topAnchor.constraint(equalTo: propertiesContentView.topAnchor),
            episodesStackView.leadingAnchor.constraint(equalTo: typeStackView.trailingAnchor, constant: 20),
            episodesStackView.bottomAnchor.constraint(equalTo: propertiesContentView.bottomAnchor)
        ])
    }
    
    private func configureEpisodesDurationStackView() {
        propertiesContentView.addSubview(episodesDurationStackView)
        
        NSLayoutConstraint.activate([
            episodesDurationStackView.topAnchor.constraint(equalTo: propertiesContentView.topAnchor),
            episodesDurationStackView.leadingAnchor.constraint(equalTo: episodesStackView.trailingAnchor, constant: 20),
            episodesDurationStackView.bottomAnchor.constraint(equalTo: propertiesContentView.bottomAnchor),
            episodesDurationStackView.trailingAnchor.constraint(equalTo: propertiesContentView.trailingAnchor, constant: -16)
        ])
    }
    
    private func configureDescriptionLabel() {
        scrollView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: propertiesScrollView.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func configureDescriptionDetailsLabel() {
        scrollView.addSubview(descriptionDetailsLabel)
        
        NSLayoutConstraint.activate([
            descriptionDetailsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            descriptionDetailsLabel.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 16),
            descriptionDetailsLabel.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16),
            descriptionDetailsLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
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
