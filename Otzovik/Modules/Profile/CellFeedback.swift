//
//  CellFeedback.swift
//  Otzovik
//
//  Created by Александр Денисов on 08.12.2023.
//

import UIKit

final class cellFeedback: UITableViewCell {
    private let labelName = UILabel()
    private let labelTitle = UILabel()
    private let labelContent = UILabel()
    private let labelDate = UILabel()
    
    private let imageViewFeedback = UIImageView(image: UIImage(systemName: "chevron.right"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(labelName)
        contentView.addSubview(labelTitle)
        contentView.addSubview(labelContent)
        contentView.addSubview(labelDate)
        contentView.addSubview(imageViewFeedback)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let xcoord: CGFloat = 20
        labelName.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        labelName.frame = .init(x: xcoord, y: 8, width: contentView.bounds.width, height: 20)
        labelTitle.font = UIFont(name:"HelveticaNeue-regular", size: 15.0)
        labelTitle.frame = .init(x: xcoord, y: 32, width: contentView.bounds.width, height: 18)
        labelContent.frame = .init(x: xcoord + 1, y: 55, width: contentView.bounds.width - 30, height: 40)
        labelContent.font = UIFont(name:"HelveticaNeue-light", size: 15.0)
        labelContent.numberOfLines = 2
        labelContent.textColor = .gray
        labelContent.textAlignment = .left
        labelContent.sizeToFit()
        labelDate.frame = .init(x: contentView.frame.maxX - 85, y: 8, width: 100, height: 15)
        labelDate.textColor = .gray
        labelDate.font = UIFont(name:"HelveticaNeue", size: 15.0)
        imageViewFeedback.frame = .init(x: contentView.frame.maxX - 20, y: 10, width: 6.5, height: 11)
        imageViewFeedback.tintColor = .gray
    }
    func configure(with feedback: Feedback) {
        labelName.text = feedback.name
        labelTitle.text = feedback.title
        labelContent.text = feedback.content
        labelDate.text = "\((feedback.date.year ?? 1900) - 2000).\(feedback.date.month ?? 1).\(feedback.date.day ?? 1)"
    }
}
