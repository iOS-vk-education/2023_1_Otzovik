//
//  EntranceButton.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 04.12.2023.
//

import UIKit

class EntranceButton: UIView {
    
    public lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = Colors.buttonText
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 12
        layer.masksToBounds = true
        backgroundColor = Colors.buttonBackground
        addSubview(titleLabel)
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension EntranceButton {
    private func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
