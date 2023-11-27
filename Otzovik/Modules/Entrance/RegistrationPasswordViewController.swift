//
//  RegistrationPasswordViewController.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 11.11.2023.
//

import UIKit

class RegistrationPasswordViewController: BaseEntranceViewController {

    let separatorView: UIView = UIView()
    let passwordTextField: InsetTextField = InsetTextField()
    let passwordLabel: UILabel = UILabel()
    let confirmationTextField: InsetTextField = InsetTextField()
    let confirmationTextFieldLabel: UILabel = UILabel()
    let textFieldsView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tryToResineFirstResponder(_:))))
        view.addSubview(textFieldsView)
        textFieldsView.layer.cornerRadius = 12
        textFieldsView.layer.masksToBounds = true
        
        textFieldsView.addSubview(passwordTextField)
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.placeholder = "введите пароль"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControl.Event.editingDidBegin)
        passwordTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControl.Event.editingDidEnd)
        textFieldsView.addSubview(confirmationTextField)
        confirmationTextField.autocorrectionType = .no
        confirmationTextField.autocapitalizationType = .none
        confirmationTextField.placeholder = "введите пароль повторно"
        confirmationTextField.isSecureTextEntry = true
        confirmationTextField.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        confirmationTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControl.Event.editingDidBegin)
        confirmationTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControl.Event.editingDidEnd)
        textFieldsView.addSubview(separatorView)
        passwordTextField.addSubview(passwordLabel)
        confirmationTextField.addSubview(confirmationTextFieldLabel)
        passwordLabel.text = "Пароль"
        confirmationTextFieldLabel.text = "Подтвер."
        passwordLabel.textAlignment = .left
        confirmationTextFieldLabel.textAlignment = .left
        setIcon()
        setTitles()
        
        setColor()
        setConstraints()
    }
    
    private func setTitles() {
        super.setTitles(title: "Пароль", buttonTitle: "Продолжить")
    }
    private func setIcon() {
        if let image = UIImage(systemName: "rectangle.and.pencil.and.ellipsis") {
            super.setIcon(image: image)
        }
    }
    
    private func setColor() {
        textFieldsView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        separatorView.backgroundColor = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.36)
        passwordTextField.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        confirmationTextField.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        passwordLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        confirmationTextFieldLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    }
    @objc
    private func tryToResineFirstResponder(_ sender: UITapGestureRecognizer) {
        tryToResineFirstResponder()
    }
    private func tryToResineFirstResponder() {
        if passwordTextField.isFirstResponder {
            passwordTextField.resignFirstResponder()
        }
        if confirmationTextField.isFirstResponder {
            confirmationTextField.resignFirstResponder()
        }
    }
    public override func nextVC() {
        print(#function)
        print("следующий шаг")
        let vc: RegistrationReadyViewController = RegistrationReadyViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension RegistrationPasswordViewController {
    @objc
    private func textFieldDidChanged(textField: UITextField) {
        if let text = textField.text {
            print(text)
            if textField == passwordTextField {
                RegistrationModel.shared.password = text
            }
            if textField == confirmationTextField {
                RegistrationModel.shared.confirmation = text
            }
        }
        
    }
    @objc
    private func textFieldDidBeginEditing(textField: UITextField) {
        print(textField.text)
        
    }
    @objc
    private func textFieldDidEndEditing(textField: UITextField) {
        print(textField.text)
    }
    @objc
    private func onReturn(textField: UITextField) {
        print(textField.text)
    }
}
extension RegistrationPasswordViewController {
    private func setConstraints() {
        
        textFieldsView.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmationTextField.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        confirmationTextFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: textFieldsView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: textFieldsView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.width, multiplier: 0.9, constant: 0).isActive = true
        NSLayoutConstraint(item: textFieldsView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: super.titleLabel, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 35).isActive = true
        
        NSLayoutConstraint(item: passwordTextField, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: passwordTextField, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: passwordTextField, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: separatorView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: passwordTextField, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: separatorView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: separatorView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: separatorView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 1).isActive = true
        
        NSLayoutConstraint(item: confirmationTextField, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: separatorView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: confirmationTextField, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: confirmationTextField, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: confirmationTextField, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: passwordTextField, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 40).isActive = true
        NSLayoutConstraint(item: confirmationTextField, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 40).isActive = true
        
        NSLayoutConstraint(item: passwordLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: passwordTextField, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: passwordLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: passwordTextField, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 15).isActive = true
        NSLayoutConstraint(item: confirmationTextFieldLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: confirmationTextField, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: confirmationTextFieldLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: confirmationTextField, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 15).isActive = true
        
        
    }
}
