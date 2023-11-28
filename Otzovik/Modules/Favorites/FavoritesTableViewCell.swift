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
        chairLabel.numberOfLines = 3
        
        ratingLabel.textAlignment = .right
        ratingLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        ratingLabel.textColor = .gray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImageView.frame = .init(x: 26, y: 15.5, width: 45, height: 45)
        
        titleLabel.frame = .init(x: iconImageView.frame.maxX + 12,
                                 y: 8,
                                 width: contentView.frame.width - iconImageView.frame.maxX - ratingLabel.frame.width - 12,
                                 height: 24)
        
        chairLabel.frame = .init(x: iconImageView.frame.maxX + 12,
                                 y: titleLabel.frame.maxY,
                                 width: contentView.frame.width - iconImageView.frame.maxX - 90,
                                 height: 48)
        
        ratingLabel.frame = .init(x: chairLabel.frame.maxX, y: 8,
                                  width: contentView.frame.width - iconImageView.frame.maxX - chairLabel.frame.width - 20,
                                  height: 24)
    }
    
    func configure(with teacher: Teacher) {
        titleLabel.text = teacher.fio
        chairLabel.text = "Кафедра: " + teacher.chair
        iconImageView.image = .init(systemName: "globe")
        
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

