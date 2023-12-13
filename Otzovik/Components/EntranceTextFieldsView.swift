//
//  EntranceTextFieldsView.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 04.12.2023.
//

import UIKit

class EntranceTextFieldsView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 12
        layer.masksToBounds = true
        backgroundColor = Colors.textFieldsViewBackground
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
