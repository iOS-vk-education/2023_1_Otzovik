//
//  EntranceSeparatorView.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 04.12.2023.
//

import UIKit

class EntranceSeparatorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.separatorViewBackground
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
