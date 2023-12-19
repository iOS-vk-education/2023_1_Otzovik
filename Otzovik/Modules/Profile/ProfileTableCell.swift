//
//  ProfileTableCell.swift
//  Otzovik
//
//  Created by Александр Денисов on 25.11.2023.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    
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
        contentView.addSubview(priceLabel)
        
        iconImageView.layer.cornerRadius = 12
        iconImageView.layer.masksToBounds = true
        iconImageView.contentMode = .scaleAspectFill

        
        accessoryType = .disclosureIndicator
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImageView.frame = .init(x: 12, y: 8, width: 104, height: 104)
        titleLabel.frame = .init(x: iconImageView.frame.maxX + 12,
                                 y: 8,
                                 width: contentView.frame.width - iconImageView.frame.maxX - 12,
                                 height: 24)
        priceLabel.frame = .init(x: iconImageView.frame.maxX + 12,
                                 y: titleLabel.frame.maxY + 4,
                                 width: contentView.frame.width - iconImageView.frame.maxX - 12,
                                 height: 24)
    }
    
    func configure(with product: Product) {
        titleLabel.text = product.title
        priceLabel.text = product.price
        iconImageView.kf.setImage(with: URL(string: product.imageURL))
    }
}
