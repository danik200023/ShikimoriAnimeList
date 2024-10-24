//
//  LoginViewController.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 24.09.2024.
//

import UIKit
import SafariServices
import Kingfisher

final class LoginViewController: UIViewController {
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var loginButton: UIButton!
    
    var viewModel: LoginViewModelProtocol! {
        didSet {
            viewModel.loadData { [unowned self] in
                setupUI()
            }
        }
    }
    
    var oAuthVC: SFSafariViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel()
        setupUI()
    }
    
    @IBAction func loginButtonAction() {
        oAuthVC = SFSafariViewController(url: viewModel.url)
        self.present(oAuthVC, animated: true)
    }
    
    func refreshUI() {
        viewModel.loadData { [unowned self] in
            setupUI()
        }
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
