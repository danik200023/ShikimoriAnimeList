//
//  UserRateDetailsViewController.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 07.11.2024.
//

import UIKit
import Combine

class UserRateDetailsViewController: UIViewController {
    
    @IBOutlet var watchingButton: UIButton!
    @IBOutlet var plannedButton: UIButton!
    @IBOutlet var completedButton: UIButton!
    @IBOutlet var rewatchingButton: UIButton!
    @IBOutlet var onHoldButton: UIButton!
    @IBOutlet var droppedButton: UIButton!
    
    var viewModel: UserRateDetailsViewModelProtocol!
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        updateButtonStyles()
    }
    
    private func setupBindings() { 
        viewModel.statusPublisher
            .receive(on: RunLoop.main)
            .sink { [unowned self] _ in
                updateButtonStyles()
            }
            .store(in: &cancellables)
    }
    
    private func updateButtonStyles() {
        let buttons = [watchingButton, plannedButton, completedButton, rewatchingButton, onHoldButton, droppedButton]
            buttons.forEach { button in
                var configuration = UIButton.Configuration.gray()
                configuration.image = button?.configuration?.image
                button?.configuration = configuration
                button?.isUserInteractionEnabled = true
            }
        
        var configuration = UIButton.Configuration.filled()
        switch viewModel.status {
        case .planned:
            configuration.image = plannedButton.configuration?.image
            plannedButton.configuration = configuration
            plannedButton.isUserInteractionEnabled = false
        case .watching:
            configuration.image = watchingButton.configuration?.image
            watchingButton.configuration = configuration
            watchingButton.isUserInteractionEnabled = false
        case .rewatching:
            configuration.image = rewatchingButton.configuration?.image
            rewatchingButton.configuration = configuration
            rewatchingButton.isUserInteractionEnabled = false
        case .completed:
            configuration.image = completedButton.configuration?.image
            completedButton.configuration = configuration
            completedButton.isUserInteractionEnabled = false
        case .onHold:
            configuration.image = onHoldButton.configuration?.image
            onHoldButton.configuration = configuration
            onHoldButton.isUserInteractionEnabled = false
        case .dropped:
            configuration.image = droppedButton.configuration?.image
            droppedButton.configuration = configuration
            droppedButton.isUserInteractionEnabled = false
        }
    }

    @IBAction func statusButtonAction(_ sender: UIButton) {
        switch sender {
        case plannedButton:
            viewModel.setStatus(.planned)
        case watchingButton:
            viewModel.setStatus(.watching)
        case rewatchingButton:
            viewModel.setStatus(.rewatching)
        case completedButton:
            viewModel.setStatus(.completed)
        case onHoldButton:
            viewModel.setStatus(.onHold)
        default:
            viewModel.setStatus(.dropped)
        }
    }
    
    @IBAction func closeButtonAction() {
        dismiss(animated: true)
    }
}