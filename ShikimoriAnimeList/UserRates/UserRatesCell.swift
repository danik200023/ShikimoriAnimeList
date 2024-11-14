//
//  UserRatesCell.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 02.11.2024.
//

import UIKit
import Kingfisher

protocol UserRatesCellDelegate: AnyObject {
    func editButtonButtonTapped(in cell: UserRatesCell)
}

final class UserRatesCell: UITableViewCell {
    @IBOutlet var animeImageView: UIImageView!
    @IBOutlet var animeNameLabel: UILabel!
    @IBOutlet var detailsLabel: UILabel!
    @IBOutlet var watchedEpisodesLabel: UILabel!
    
    weak var delegate: UserRatesCellDelegate?
    
    var viewModel: UserRatesCellViewModelProtocol! {
        didSet {
            animeNameLabel.text = viewModel.animeName
            detailsLabel.text = viewModel.details
            watchedEpisodesLabel.text = viewModel.watchedEpisodes
            animeImageView.layer.borderWidth = 1
            animeImageView.layer.borderColor = UIColor.secondarySystemFill.cgColor
            animeImageView.kf.indicatorType = .activity
            animeImageView.kf.setImage(with: viewModel.posterUrl)
        }
    }
    
    @IBAction func editButtonAction() {
        delegate?.editButtonButtonTapped(in: self)
    }
}


