//
//  ProfileViewController.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 24.09.2024.
//

import UIKit
import SafariServices
import Kingfisher
import SwiftUI

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
    
    private let loginButton: UIButton = {
        let loginButton = UIButton(configuration: .plain())
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login with Shikimori", for: .normal)
        return loginButton
    }()
    
    var viewModel: ProfileViewModelProtocol! {
        didSet {
            viewModel.loadData { [unowned self] in
                setupUI()
            }
        }
    }
    
    var oAuthVC: SFSafariViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProfileViewModel()
        configureAvatarImageView()
        configureUsernameLabel()
        configureLoginButton()
        setupUI()
    }
    
    @objc
    func loginButtonAction() {
        oAuthVC = SFSafariViewController(url: viewModel.url)
        self.present(oAuthVC, animated: true)
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
    
    private func configureLoginButton() {
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupUI() {
        loginButton.isHidden = viewModel.isLoggedIn
        usernameLabel.isHidden = !viewModel.isLoggedIn
        avatarImageView.isHidden = !viewModel.isLoggedIn
        
        if viewModel.isLoggedIn {
            usernameLabel.text = viewModel.username
            avatarImageView.kf.indicatorType = .activity
            avatarImageView.kf.setImage(with: viewModel.avatarUrl)
        }
    }
}

// MARK: - Preview
struct MyViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            ProfileViewController()
        }
    }
}

struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    let viewController: ViewController

    init(_ builder: @escaping () -> ViewController) {
        self.viewController = builder()
    }

    func makeUIViewController(context: Context) -> ViewController {
        return viewController
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}

