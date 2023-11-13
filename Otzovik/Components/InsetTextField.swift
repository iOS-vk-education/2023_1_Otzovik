//
//  InsetTextField.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 10.11.2023.
//

import UIKit

class InsetTextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0.0, left: 100.0, bottom: 0.0, right: 5.0))
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0.0, left: 100.0, bottom: 0.0, right: 5.0))
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0.0, left: 100.0, bottom: 0.0, right: 5.0))
    }
}
