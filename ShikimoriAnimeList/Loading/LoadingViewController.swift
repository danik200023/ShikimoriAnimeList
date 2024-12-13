//
//  LoadingViewController.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 13.12.2024.
//

import UIKit

final class LoadingViewController: UIViewController {
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicatorView()
    }

    private func setupActivityIndicatorView() {
        view.addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
