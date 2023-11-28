//
//  FavoritesTableViewCell.swift
//  Otzovik
//
//  Created by Начын Сарыглар on 27.11.2023.
//

import UIKit

final class FavoritesTableViewCell: UITableViewCell {
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let chairLabel = TopAlignedLabel()
    private let ratingLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(chairLabel)
        contentView.addSubview(ratingLabel)
        
        iconImageView.layer.cornerRadius = 12
        iconImageView.layer.masksToBounds = true
        iconImageView.contentMode = .scaleAspectFill
        
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        chairLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        chairLabel.textColor = .gray
        chairLabel.numberOfLines = 4
        
        ratingLabel.textAlignment = .right
        ratingLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        ratingLabel.textColor = .gray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.topAnchor.constraint(
            equalTo: contentView.safeAreaLayoutGuide.topAnchor,
            constant: 15.5
        ).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 26).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width - iconImageView.frame.maxX - 80).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        
        chairLabel.translatesAutoresizingMaskIntoConstraints = false
        chairLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        chairLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12).isActive = true
        chairLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width - iconImageView.frame.width - 50).isActive = true

        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.topAnchor.constraint(
            equalTo: contentView.safeAreaLayoutGuide.topAnchor,
            constant: 8
        ).isActive = true
        ratingLabel.leadingAnchor.constraint(
            equalTo: titleLabel.trailingAnchor,
            constant: 0
        ).isActive = true

        ratingLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    func configure(with teacher: Teacher) {
        titleLabel.text = teacher.fio
        chairLabel.text = "Кафедра: " + teacher.chair
        iconImageView.image = .init(named: "avatar2")
        
        let rating : Double = teacher.rating
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "chevron.right")?.withTintColor(.gray)
        imageAttachment.bounds = CGRect(origin: .zero,
                                        size: CGSize(width: (imageAttachment.image?.size.width)! * 0.8,
                                                     height: (imageAttachment.image?.size.height)! * 0.8))
        
        let fullString = NSMutableAttributedString(string: String(rating) + "⭐️ ")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        
        ratingLabel.attributedText = fullString
    }
}

class TopAlignedLabel: UILabel {
      override func drawText(in rect: CGRect) {
        let textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        super.drawText(in: textRect)
      }
}
