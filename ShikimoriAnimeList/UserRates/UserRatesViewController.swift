//
//  UserRatesViewController.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 02.11.2024.
//

import UIKit
import AuthenticationServices

class UserRatesViewController: UIViewController {

    @IBOutlet var tableTabSegmentedControl: UISegmentedControl!
    @IBOutlet var loginStackView: UIStackView!
    @IBOutlet var animeListTableView: UITableView!
    
    var viewModel: UserRatesViewModelProtocol! {
        didSet {
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserRatesViewModel()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshUI), name: .authStatusChanged, object: nil)
        
        animeListTableView.dataSource = self
        animeListTableView.delegate = self
        animeListTableView.rowHeight = 174
        refreshUI()
    }
    
    @IBAction func loginButtonAction() {
        viewModel.loginButtonAction()
    }
    
    @IBAction func segmentChanged() {
        animeListTableView.reloadData()
    }
    @objc private func refreshUI() {
        animeListTableView.isHidden = !viewModel.isLoggedIn
        tableTabSegmentedControl.isHidden = !viewModel.isLoggedIn
        loginStackView.isHidden = viewModel.isLoggedIn
        if viewModel.isLoggedIn {
            viewModel.fetchUserRates() { [unowned self] in
                animeListTableView.reloadData()
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .authStatusChanged, object: nil)
    }
}

//MARK: - UITableViewDelegate
extension UserRatesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
        return cell
    }
    
    
}
