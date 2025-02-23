//
//  AnimeDetailsViewController.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 16.08.2024.
//

import UIKit
import Kingfisher
import Combine

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
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.configuration = .gray()
        editButton.clipsToBounds = true
        editButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        editButton.addTarget(self, action: #selector(editButtonAction), for: .touchUpInside)
        return editButton
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
        let episodeDurationDetailsLabel = UILabel()
        episodeDurationDetailsLabel.font = .systemFont(ofSize: 14, weight: .medium)
        return episodeDurationDetailsLabel
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
        
        editButton.layer.cornerRadius = editButton.frame.width / 2
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        NotificationCenter.default.publisher(for: .userRateChanged)
            .sink { [weak self] _ in
                self?.viewModel.updateUserRate { [weak self] in
                    self?.updateEditButtonImage()
                }
            }
            .store(in: &cancellables)
        
        configureScrollView()
        configurePosterImageView()
        configureEditButton()
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
    
    private func configureEditButton() {
        scrollView.addSubview(editButton)

        NSLayoutConstraint.activate([
            editButton.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor),
            editButton.heightAnchor.constraint(equalTo:  posterImageView.heightAnchor, multiplier: 0.15),
            editButton.widthAnchor.constraint(equalTo: editButton.heightAnchor),
            editButton.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10)
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
            propertiesContentView.leadingAnchor.constraint(equalTo: propertiesScrollView.leadingAnchor),
            propertiesContentView.trailingAnchor.constraint(equalTo: propertiesScrollView.trailingAnchor),
            propertiesContentView.centerYAnchor.constraint(equalTo: propertiesScrollView.centerYAnchor)
            
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
        typeDetailsLabel.text = viewModel.type
        episodesDetailsLabel.text = viewModel.episodes
        episodeDurationDetailsLabel.text = viewModel.episodeDuration
        descriptionLabel.isHidden = viewModel.isDescriptionHidden
        descriptionDetailsLabel.isHidden = viewModel.isDescriptionHidden
        descriptionDetailsLabel.text = viewModel.description
        statusDetailsLabel.text = viewModel.statusDetails
        statuslabel.text = viewModel.status
        editButton.isHidden = !viewModel.isLoggedIn
        updateEditButtonImage()
    }
    
    private func updateEditButtonImage() {
        let imageName: String
        switch viewModel.userRateStatus {
        case .planned:
            imageName = "list.clipboard"
        case .watching:
            imageName = "eye"
        case .rewatching:
            imageName = "checkmark.arrow.trianglehead.counterclockwise"
        case .completed:
            imageName = "checkmark"
        case .onHold:
            imageName = "pause"
        case .dropped:
            imageName = "nosign"
        case .none:
            imageName = "plus"
        }
        editButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @objc
    private func editButtonAction() {
        let detailsVC = UserRateDetailsViewController()
        if let sheet = detailsVC.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.detents = [.custom(resolver: { _ in
                    return 400
                })]
            } else {
                sheet.detents = [.medium()]
            }
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 15
        }
        if let viewModel = viewModel.getUserRateDetailsViewModel() {
            detailsVC.viewModel = viewModel
            present(detailsVC, animated: true)
        } else {
            viewModel.addAnimeToList()
        }
    }
}
