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
    
    private lazy var watchingButton: UIButton = {
        let watchingButton = UIButton(configuration: .gray())
        watchingButton.setImage(UIImage(systemName: "eye"), for: .normal)
        watchingButton.addTarget(self, action: #selector(statusButtonAction(_:)), for: .touchUpInside)
        return watchingButton
    }()
    
    private lazy var rewatchingButton: UIButton = {
        let rewatchingButton = UIButton(configuration: .gray())
        rewatchingButton.setImage(UIImage(systemName: "checkmark.arrow.trianglehead.counterclockwise"), for: .normal)
        rewatchingButton.addTarget(self, action: #selector(statusButtonAction(_:)), for: .touchUpInside)
        return rewatchingButton
    }()
    
    private lazy var plannedButton: UIButton = {
        let plannedButton = UIButton(configuration: .gray())
        plannedButton.setImage(UIImage(systemName: "list.clipboard"), for: .normal)
        plannedButton.addTarget(self, action: #selector(statusButtonAction(_:)), for: .touchUpInside)
        return plannedButton
    }()
    
    private lazy var onHoldButton: UIButton = {
        let onHoldButton = UIButton(configuration: .gray())
        onHoldButton.setImage(UIImage(systemName: "pause"), for: .normal)
        onHoldButton.addTarget(self, action: #selector(statusButtonAction(_:)), for: .touchUpInside)
        return onHoldButton
    }()
    
    private lazy var completedButton: UIButton = {
        let completedButton = UIButton(configuration: .gray())
        completedButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        completedButton.addTarget(self, action: #selector(statusButtonAction(_:)), for: .touchUpInside)
        return completedButton
    }()
    
    private lazy var droppedButton: UIButton = {
        let droppedButton = UIButton(configuration: .gray())
        droppedButton.setImage(UIImage(systemName: "nosign"), for: .normal)
        droppedButton.addTarget(self, action: #selector(statusButtonAction(_:)), for: .touchUpInside)
        return droppedButton
    }()
    
    private let watchingLabel: UILabel = {
        let watchingLabel = UILabel()
        watchingLabel.font = .systemFont(ofSize: 12)
        watchingLabel.textAlignment = .center
        watchingLabel.text = "Смотрю"
        return watchingLabel
    }()
    
    private let rewatchingLabel: UILabel = {
        let rewatchingLabel = UILabel()
        rewatchingLabel.font = .systemFont(ofSize: 12)
        rewatchingLabel.textAlignment = .center
        rewatchingLabel.text = "Пересматриваю"
        return rewatchingLabel
    }()
    
    private let plannedLabel: UILabel = {
        let plannedLabel = UILabel()
        plannedLabel.font = .systemFont(ofSize: 12)
        plannedLabel.textAlignment = .center
        plannedLabel.text = "В планах"
        return plannedLabel
    }()
    
    private let onHoldLabel: UILabel = {
        let onHoldLabel = UILabel()
        onHoldLabel.font = .systemFont(ofSize: 12)
        onHoldLabel.textAlignment = .center
        onHoldLabel.text = "Отложено"
        return onHoldLabel
    }()
    
    private let completedLabel: UILabel = {
        let completedLabel = UILabel()
        completedLabel.font = .systemFont(ofSize: 12)
        completedLabel.textAlignment = .center
        completedLabel.text = "Просмотрено"
        return completedLabel
    }()
    
    private let droppedLabel: UILabel = {
        let droppedLabel = UILabel()
        droppedLabel.font = .systemFont(ofSize: 12)
        droppedLabel.textAlignment = .center
        droppedLabel.text = "Брошено"
        return droppedLabel
    }()
    
    private lazy var watchingStackView: UIStackView = {
        let watchingStackView = UIStackView(arrangedSubviews: [watchingButton, watchingLabel])
        watchingStackView.axis = .vertical
        watchingStackView.alignment = .center
        watchingStackView.distribution = .fill
        watchingStackView.spacing = 4
        return watchingStackView
    }()
    
    private lazy var rewatchingStackView: UIStackView = {
        let rewatchingStackView = UIStackView(arrangedSubviews: [rewatchingButton, rewatchingLabel])
        rewatchingStackView.axis = .vertical
        rewatchingStackView.alignment = .center
        rewatchingStackView.distribution = .fill
        rewatchingStackView.spacing = 4
        return rewatchingStackView
    }()
    
    private lazy var plannedStackView: UIStackView = {
        let plannedStackView = UIStackView(arrangedSubviews: [plannedButton, plannedLabel])
        plannedStackView.axis = .vertical
        plannedStackView.alignment = .center
        plannedStackView.distribution = .fill
        plannedStackView.spacing = 4
        return plannedStackView
    }()
    
    private lazy var onHoldStackView: UIStackView = {
        let onHoldStackView = UIStackView(arrangedSubviews: [onHoldButton, onHoldLabel])
        onHoldStackView.axis = .vertical
        onHoldStackView.alignment = .center
        onHoldStackView.distribution = .fill
        onHoldStackView.spacing = 4
        return onHoldStackView
    }()
    
    private lazy var completedStackView: UIStackView = {
        let completedStackView = UIStackView(arrangedSubviews: [completedButton, completedLabel])
        completedStackView.axis = .vertical
        completedStackView.alignment = .center
        completedStackView.distribution = .fill
        completedStackView.spacing = 4
        return completedStackView
    }()
    
    private lazy var droppedStackView: UIStackView = {
        let droppedStackView = UIStackView(arrangedSubviews: [droppedButton, droppedLabel])
        droppedStackView.axis = .vertical
        droppedStackView.alignment = .center
        droppedStackView.distribution = .fill
        droppedStackView.spacing = 4
        return droppedStackView
    }()
    
    private lazy var leftButtonsStackView: UIStackView = {
        let leftButtonsStackView = UIStackView(arrangedSubviews: [watchingStackView, rewatchingStackView])
        leftButtonsStackView.axis = .vertical
        leftButtonsStackView.alignment = .fill
        leftButtonsStackView.distribution = .fillEqually
        leftButtonsStackView.spacing = 16
        return leftButtonsStackView
    }()
    
    private lazy var centerButtonsStackView: UIStackView = {
        let centerButtonsStackView = UIStackView(arrangedSubviews: [plannedStackView, onHoldStackView])
        centerButtonsStackView.axis = .vertical
        centerButtonsStackView.alignment = .fill
        centerButtonsStackView.distribution = .fillEqually
        centerButtonsStackView.spacing = 16
        return centerButtonsStackView
    }()
    
    private lazy var rightButtonsStackView: UIStackView = {
        let rightButtonsStackView = UIStackView(arrangedSubviews: [completedStackView, droppedStackView])
        rightButtonsStackView.axis = .vertical
        rightButtonsStackView.alignment = .fill
        rightButtonsStackView.distribution = .fillEqually
        rightButtonsStackView.spacing = 16
        return rightButtonsStackView
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let buttonsStackView = UIStackView(arrangedSubviews: [leftButtonsStackView, centerButtonsStackView, rightButtonsStackView])
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.axis = .horizontal
        buttonsStackView.alignment = .fill
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 20
        return buttonsStackView
    }()
    
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
        configureStatusButtons()
        configureButtonsStackViews()
        
        setupUI()
        setupBindings()
        updateButtonStyles()
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
            animeNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            animeNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            animeNameLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -10)
        ])
    }
    
    private func configureStatusButtons() {
        let buttons = [watchingButton, rewatchingButton, plannedButton, onHoldButton, completedButton, droppedButton]

        let maxWidth = buttons.map { $0.intrinsicContentSize.width }.max() ?? 44

        buttons.forEach { button in
            button.widthAnchor.constraint(equalToConstant: maxWidth).isActive = true
        }
    }

    
    private func configureButtonsStackViews() {
        view.addSubview(buttonsStackView)
        
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
                updateButtonStyles()
            }
            .store(in: &cancellables)

        viewModel.numberOfWatchedEpisodesPublisher
            .receive(on: RunLoop.main)
            .sink { [unowned self] numberOfWatchedEpisodes in
//                watchedEpisodesTextField.text = numberOfWatchedEpisodes
            }
            .store(in: &cancellables)
    }

    private func updateButtonStyles() {
        let buttons = [
            watchingButton, plannedButton, completedButton, rewatchingButton,
            onHoldButton, droppedButton,
        ]
        buttons.forEach { button in
            var configuration = UIButton.Configuration.gray()
            configuration.image = button.configuration?.image
            button.configuration = configuration
            button.isUserInteractionEnabled = true
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

    @objc
    private func statusButtonAction(_ sender: UIButton) {
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
