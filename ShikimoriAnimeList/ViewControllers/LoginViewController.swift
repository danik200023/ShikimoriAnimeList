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
    
    var oAuthVC: SFSafariViewController!
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func loginButtonAction() {
        if let url = URL(string: "https://shikimori.one/oauth/authorize?client_id=wfUWoNxEIwfseLQ5vGJfQjeVOAAELibJw5zbOmCVnrc&redirect_uri=shikimoriapp%3A%2F%2Fcallback&response_type=code&scope=user_rates") {
            oAuthVC = SFSafariViewController(url: url)
            self.present(oAuthVC, animated: true, completion: nil)
        }
    }
    
    func setupUI() {
        if UserDefaults.standard.getOAuthToken() != nil {
            configureUI(isLoggedIn: true)
            fetchUserProfile()
        } else if UserDefaults.standard.string(forKey: "authCode") != nil {
            configureUI(isLoggedIn: true)
            getAccessToken()
        } else {
            configureUI(isLoggedIn: false)
        }
    }
    
    private func configureUI(isLoggedIn: Bool) {
        loginButton.isHidden = isLoggedIn
        usernameLabel.isHidden = !isLoggedIn
        avatarImageView.isHidden = !isLoggedIn
        
        if isLoggedIn {
            avatarImageView.kf.indicatorType = .activity
        }
    }
    
    private func fetchUserProfile() {
        networkManager.fetchWithAuthorization(
            User.self,
            from: "https://shikimori.one/api/users/whoami"
        ) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let loadedUser):
                usernameLabel.text = "username: \(loadedUser.nickname)"
                avatarImageView.kf.setImage(with: loadedUser.image.x160)
            case .failure(let error):
                print(error)
                print(400)
            }
        }
    }
    
    private func getAccessToken() {
        networkManager.getAccessToken() { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let token):
                UserDefaults.standard.saveOAuthToken(token)
                self.setupUI()
            case .failure(let error):
                print(error.responseCode ?? "Unknown error")
                if error.responseCode == 400 {
                    print("error 400")
                }
            }
        }
    }
}
