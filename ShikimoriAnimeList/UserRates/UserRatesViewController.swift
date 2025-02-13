//
//  UserRatesViewController.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 02.11.2024.
//

import UIKit
import AuthenticationServices
import Combine

class UserRatesViewController: UIViewController {
    private let loginLabel: UILabel = {
        let loginLabel = UILabel()
        loginLabel.text = "Войдите, чтобы увидеть список"
        loginLabel.numberOfLines = 0
        return loginLabel
    }()
    
    private let registerButton: UIButton = {
        let registerButton = UIButton(configuration: .gray())
        registerButton.setTitle("Создать аккаунт", for: .normal)
        return registerButton
    }()
    
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton(configuration: .filled())
        loginButton.setTitle("Войти", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        return loginButton
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [registerButton, loginButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 30
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var loginStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginLabel, buttonsStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 30
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var tableTabSegmentedControl: UISegmentedControl = {
        let tableTabSegmentedControl = UISegmentedControl(items: ["Смотрю", "В планах", "Просмотрено", "Отложено"])
        tableTabSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        tableTabSegmentedControl.selectedSegmentIndex = 0
        tableTabSegmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        return tableTabSegmentedControl
    }()
    
    private lazy var animeListView: UITableView = {
        let animeListView = UITableView()
        animeListView.translatesAutoresizingMaskIntoConstraints = false
        animeListView.dataSource = self
        animeListView.delegate = self
        animeListView.register(UserRatesCell.self, forCellReuseIdentifier: "userRateCell")
        animeListView.rowHeight = view.bounds.height / 5
        return animeListView
    }()
    
    var viewModel: UserRatesViewModelProtocol!
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserRatesViewModel()
        
        NotificationCenter.default.publisher(for: .authStatusChanged)
            .sink { [unowned self] _ in
                setupUI()
            }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: .userRateChanged)
            .sink { [unowned self] _ in
                viewModel.moveCell { [unowned self] in
                    animeListView.reloadData()
                }
            }
            .store(in: &cancellables)
        
        navigationItem.titleView = tableTabSegmentedControl
        configureLoginStackView()
        configureAnimeListView()
        setupUI()
    }
    
    @objc
    private func loginButtonAction() {
        viewModel.loginButtonAction()
    }
    
    @objc
    private func segmentChanged() {
        animeListView.reloadData()
    }
    
    private func setupUI() {
        animeListView.isHidden = !viewModel.isLoggedIn
        tableTabSegmentedControl.isHidden = !viewModel.isLoggedIn
        loginStackView.isHidden = viewModel.isLoggedIn
        if viewModel.isLoggedIn {
            viewModel.fetchUserRates() { [unowned self] in
                animeListView.reloadData()
            }
        }
    }
    
    private func configureLoginStackView() {
        view.addSubview(loginStackView)
        NSLayoutConstraint.activate([
            loginStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configureAnimeListView() {
        view.addSubview(animeListView)
        NSLayoutConstraint.activate([
            animeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            animeListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            animeListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            animeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func showUserRateDetails(for cell: UserRatesCell) {
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
        detailsVC.viewModel = cell.viewModel.getUserRateDetailsViewModel()
        present(detailsVC, animated: true)
    }
}

//MARK: - UITableViewDelegate
extension UserRatesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let animeDetailsVC = AnimeDetailsViewController()
        guard let cell = tableView.cellForRow(at: indexPath) as? UserRatesCell else { return }
        animeDetailsVC.viewModel = cell.viewModel.getAnimeDetailsViewModel()
        navigationController?.pushViewController(animeDetailsVC, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension UserRatesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section, andTab: tableTabSegmentedControl.selectedSegmentIndex)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "userRateCell",
            for: indexPath
        )
        
        guard let cell = cell as? UserRatesCell else { return UITableViewCell() }
        cell.viewModel = viewModel.getUserRateCellViewModel(at: indexPath, andSegment: tableTabSegmentedControl.selectedSegmentIndex)
        cell.delegate = self
        return cell
    }
}

extension UserRatesViewController: UserRatesCellDelegate {
    func editButtonButtonTapped(in cell: UserRatesCell) {
        showUserRateDetails(for: cell)
    }
}
