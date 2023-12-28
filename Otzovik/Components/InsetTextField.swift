//
//  InsetTextField.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 10.11.2023.
//

import UIKit

class InsetTextField: UITextField {
    private var leftInset: CGFloat = 0.0
    private var rightInset: CGFloat = 0.0
    
    public func config(leftInset: CGFloat, rightInset: CGFloat) {
        self.leftInset = leftInset
        self.rightInset = rightInset
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0.0, left: leftInset, bottom: 0.0, right: rightInset))
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0.0, left: leftInset, bottom: 0.0, right: rightInset))
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0.0, left: leftInset, bottom: 0.0, right: rightInset))
    }
}
