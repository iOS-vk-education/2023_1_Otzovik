//
//  CustomCollectionViewCell.swift
//  Otzovik
//
//  Created by Начын Сарыглар on 28.11.2023.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
    
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    private let ratingLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.13)
        contentView.layer.cornerRadius = 12
        
        titleLabel.text = "Норм препод"
        titleLabel.font = .systemFont(ofSize: 12, weight: .bold)
        
        contentLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        contentLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        ratingLabel.attributedText = getStars(rating: 5.0)
        
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(ratingLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
    }
    
    private func getStars(rating: Double) -> NSMutableAttributedString {
        let fullStars = Int(rating)
        let emptyStars = 5 - Int(rating)
        
        let fullStar = NSTextAttachment()
        fullStar.image = UIImage(systemName: "star.fill")?.withTintColor(.gray)
        fullStar.bounds = CGRect(origin: .zero,
                                        size: CGSize(width: (fullStar.image?.size.width)! * 0.8,
                                                     height: (fullStar.image?.size.height)! * 0.8))
        let emptyStar = NSTextAttachment()
        emptyStar.image = UIImage(systemName: "star")?.withTintColor(.gray)
        emptyStar.bounds = CGRect(origin: .zero,
                                        size: CGSize(width: (emptyStar.image?.size.width)! * 0.8,
                                                     height: (emptyStar.image?.size.height)! * 0.8))
        
        let fullString = NSMutableAttributedString(string: "")
        
        fullString.append(NSAttributedString(attachment: fullStar))
        fullString.append(NSAttributedString(attachment: fullStar))
        fullString.append(NSAttributedString(attachment: fullStar))
        fullString.append(NSAttributedString(attachment: fullStar))
        fullString.append(NSAttributedString(attachment: fullStar))
        
        return fullString
    }
    
}
