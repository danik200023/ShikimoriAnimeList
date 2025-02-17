//
//  OngoingCellHeader.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 25.10.2024.
//

import Foundation
import UIKit

final class OngoingCellHeader: UICollectionReusableView {
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .preferredFont(forTextStyle: .title1)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 1
        return titleLabel
    }()
    
    var viewModel: OngoingCellHeaderViewModelProtocol! {
        didSet {
            titleLabel.text = viewModel.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
    }
}
