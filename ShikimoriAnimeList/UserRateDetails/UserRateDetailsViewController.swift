//
//  UserRateDetailsViewController.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 07.11.2024.
//

import Combine
import UIKit

class UserRateDetailsViewController: UIViewController {
    private lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        return closeButton
    }()
    
    private lazy var deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.tintColor = .systemRed
        deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        return deleteButton
    }()
    
    private let animeNameLabel: UILabel = {
        let animeNameLabel = UILabel()
        animeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        animeNameLabel.font = .systemFont(ofSize: 13)
        animeNameLabel.numberOfLines = 2
        animeNameLabel.minimumScaleFactor = 0.8
        return animeNameLabel
    }()
    
//    @IBOutlet var watchingButton: UIButton!
//    @IBOutlet var plannedButton: UIButton!
//    @IBOutlet var completedButton: UIButton!
//    @IBOutlet var rewatchingButton: UIButton!
//    @IBOutlet var onHoldButton: UIButton!
//    @IBOutlet var droppedButton: UIButton!
//    @IBOutlet var watchedEpisodesTextField: UITextField!
//    @IBOutlet var totalEpisodeslabel: UILabel!
//    @IBOutlet var rewatchesTextField: UITextField!

    var viewModel: UserRateDetailsViewModelProtocol!
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCloseButton()
        configureDeleteButton()
        configureAnimeNameLabel()
        
        setupUI()
        setupBindings()
//        updateButtonStyles()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    private func configureCloseButton() {
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            closeButton.widthAnchor.constraint(equalToConstant: 32),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor)
        ])
    }
    
    private func configureDeleteButton() {
        view.addSubview(deleteButton)
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            deleteButton.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -6),
            deleteButton.widthAnchor.constraint(equalToConstant: 32),
            deleteButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor)
        ])
    }
    
    private func configureAnimeNameLabel() {
        view.addSubview(animeNameLabel)
        NSLayoutConstraint.activate([
            animeNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            animeNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            animeNameLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -10)
        ])
    }
    
    private func setupUI() {
        animeNameLabel.text = viewModel.animeName
//        totalEpisodeslabel.text = viewModel.totalEpisodes
//        rewatchesTextField.text = viewModel.rewatches

        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(
            title: "Готово",
            style: .done,
            target: self,
            action: #selector(doneButtonAction)
        )

        toolbar.items = [.flexibleSpace(), doneButton]

//        watchedEpisodesTextField.inputAccessoryView = toolbar
//        watchedEpisodesTextField.delegate = self
//        rewatchesTextField.inputAccessoryView = toolbar
//        rewatchesTextField.delegate = self

    }

    @objc
    private func doneButtonAction() {
        view.endEditing(true)
    }

    private func setupBindings() {
        viewModel.statusPublisher
            .receive(on: RunLoop.main)
            .sink { [unowned self] _ in
//                updateButtonStyles()
            }
            .store(in: &cancellables)

        viewModel.numberOfWatchedEpisodesPublisher
            .receive(on: RunLoop.main)
            .sink { [unowned self] numberOfWatchedEpisodes in
//                watchedEpisodesTextField.text = numberOfWatchedEpisodes
            }
            .store(in: &cancellables)
    }

//    private func updateButtonStyles() {
//        let buttons = [
//            watchingButton, plannedButton, completedButton, rewatchingButton,
//            onHoldButton, droppedButton,
//        ]
//        buttons.forEach { button in
//            var configuration = UIButton.Configuration.gray()
//            configuration.image = button?.configuration?.image
//            button?.configuration = configuration
//            button?.isUserInteractionEnabled = true
//        }
//
//        var configuration = UIButton.Configuration.filled()
//        switch viewModel.status {
//        case .planned:
//            configuration.image = plannedButton.configuration?.image
//            plannedButton.configuration = configuration
//            plannedButton.isUserInteractionEnabled = false
//        case .watching:
//            configuration.image = watchingButton.configuration?.image
//            watchingButton.configuration = configuration
//            watchingButton.isUserInteractionEnabled = false
//        case .rewatching:
//            configuration.image = rewatchingButton.configuration?.image
//            rewatchingButton.configuration = configuration
//            rewatchingButton.isUserInteractionEnabled = false
//        case .completed:
//            configuration.image = completedButton.configuration?.image
//            completedButton.configuration = configuration
//            completedButton.isUserInteractionEnabled = false
//        case .onHold:
//            configuration.image = onHoldButton.configuration?.image
//            onHoldButton.configuration = configuration
//            onHoldButton.isUserInteractionEnabled = false
//        case .dropped:
//            configuration.image = droppedButton.configuration?.image
//            droppedButton.configuration = configuration
//            droppedButton.isUserInteractionEnabled = false
//        }
//    }

    private func showAlert(
        withTitle title: String,
        andMessage message: String,
        actions: [UIAlertAction] = [UIAlertAction(title: "OK", style: .default)]
    ) {
        let alert = UIAlertController(
            title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        present(alert, animated: true)
    }

//    @objc
//    private func statusButtonAction(_ sender: UIButton) {
//        switch sender {
//        case plannedButton:
//            viewModel.setStatus(.planned)
//        case watchingButton:
//            viewModel.setStatus(.watching)
//        case rewatchingButton:
//            viewModel.setStatus(.rewatching)
//        case completedButton:
//            viewModel.setStatus(.completed)
//        case onHoldButton:
//            viewModel.setStatus(.onHold)
//        default:
//            viewModel.setStatus(.dropped)
//        }
//    }

    @objc
    private func deleteButtonAction() {
        let alert = UIAlertController(
            title: "Удалить",
            message: "Вы действительно хотите удалить аниме из списка?",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Удалить", style: .destructive) {
            [unowned self] _ in
            viewModel.deleteRate { [unowned self] in
                dismiss(animated: true)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

    @objc
    private func closeButtonAction() {
        dismiss(animated: true)
    }

    @objc
    private func incrementButtonAction() {
        viewModel.incrementWatchedEpisodes()
    }

    @objc
    private func decrementButtonAction() {
        viewModel.decrementWatchedEpisodes()
    }
}

//extension UserRateDetailsViewController: UITextFieldDelegate {
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        guard let text = textField.text, let intValue = Int(text) else {
//            let alert = UIAlertController(
//                title: "Ошибка",
//                message: "Введите число",
//                preferredStyle: .alert
//            )
//            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
//                textField.text = "1"
//                textField.becomeFirstResponder()
//            }
//            alert.addAction(okAction)
//            present(alert, animated: true)
//            return false
//        }
//        switch textField {
//        case watchedEpisodesTextField:
//            if viewModel.isValidWatchedEpisodesCount(intValue) {
//                return true
//            } else {
//                showAlert(
//                    withTitle: "Ошибка",
//                    andMessage: "Неправильное количество серий",
//                    actions: [
//                        UIAlertAction(title: "OK", style: .default) { _ in
//                            textField.text = "1"
//                            textField.becomeFirstResponder()
//                        }
//                    ])
//                return false
//            }
//        default:
//            if viewModel.isValidRewatchesCount(intValue) {
//                return true
//            } else {
//                showAlert(
//                    withTitle: "Ошибка",
//                    andMessage: "Неправильное количество пересмотров",
//                    actions: [
//                        UIAlertAction(title: "OK", style: .default) { _ in
//                            textField.text = "0"
//                            textField.becomeFirstResponder()
//                        }
//                    ])
//                return false
//            }
//        }
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        switch textField {
//        case watchedEpisodesTextField:
//            guard let text = textField.text else { return }
//            viewModel.setNumberOfWatchedEpisodes(Int(text) ?? 0)
//        default:
//            guard let text = textField.text else { return }
//            viewModel.setNumberOfRewatches(Int(text) ?? 0)
//        }
//    }
//}
