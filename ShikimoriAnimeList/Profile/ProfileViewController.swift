//
//  ProfileViewController.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 24.09.2024.
//

import UIKit
import Kingfisher
import Combine

final class ProfileViewController: UIViewController {
    private let avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.layer.cornerRadius = 15
        return avatarImageView
    }()
    
    private let usernameLabel: UILabel = {
       let usernameLabel = UILabel()
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.font = .boldSystemFont(ofSize: 17)
        usernameLabel.text = "test"
        return usernameLabel
    }()
    
    private let loginLabel: UILabel = {
        let loginLabel = UILabel()
        loginLabel.text = "Войдите, чтобы увидеть профиль"
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
    
    var viewModel: ProfileViewModelProtocol! {
        didSet {
            viewModel.loadData { [unowned self] in
                setupUI()
            }
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProfileViewModel()
        
        NotificationCenter.default.publisher(for: .authStatusChanged)
            .sink { [unowned self] _ in
                refreshUI()
            }
            .store(in: &cancellables)
        
        configureAvatarImageView()
        configureUsernameLabel()
        configureLoginStackView()
        setupUI()
    }
    
    @objc
    func loginButtonAction() {
        viewModel.loginButtonAction()
    }
    
    func refreshUI() {
        viewModel.loadData { [unowned self] in
            setupUI()
        }
    }
    
    private func configureAvatarImageView() {
        view.addSubview(avatarImageView)
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
        ])
    }
    
    private func configureUsernameLabel() {
        view.addSubview(usernameLabel)
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureLoginStackView() {
        view.addSubview(loginStackView)
        NSLayoutConstraint.activate([
            loginStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupUI() {
        loginStackView.isHidden = viewModel.isLoggedIn
        usernameLabel.isHidden = !viewModel.isLoggedIn
        avatarImageView.isHidden = !viewModel.isLoggedIn
        
        if viewModel.isLoggedIn {
            usernameLabel.text = viewModel.username
            avatarImageView.kf.indicatorType = .activity
            avatarImageView.kf.setImage(with: viewModel.avatarUrl)
        }
    }
}
