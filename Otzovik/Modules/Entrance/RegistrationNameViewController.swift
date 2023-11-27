//
//  RegistrationNameViewController.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 27.10.2023.
//

import UIKit

class RegistrationNameViewController: BaseEntranceViewController {

    let separatorView: UIView = UIView()
    let firstnameTextField: InsetTextField = InsetTextField()
    let firstnameLabel: UILabel = UILabel()
    let lastnameTextField: InsetTextField = InsetTextField()
    let lastnameTextFieldLabel: UILabel = UILabel()
    let textFieldsView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tryToResineFirstResponder(_:))))
        view.addSubview(textFieldsView)
        textFieldsView.layer.cornerRadius = 12
        textFieldsView.layer.masksToBounds = true
        
        textFieldsView.addSubview(firstnameTextField)
        firstnameTextField.autocorrectionType = .no
        firstnameTextField.autocapitalizationType = .none
        //firstnameTextField.placeholder = "имя"
        firstnameTextField.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        firstnameTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControl.Event.editingDidBegin)
        firstnameTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControl.Event.editingDidEnd)
        textFieldsView.addSubview(lastnameTextField)
        lastnameTextField.autocorrectionType = .no
        lastnameTextField.autocapitalizationType = .none
        //lastnameTextField.placeholder = "фамилия"
        lastnameTextField.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        lastnameTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControl.Event.editingDidBegin)
        lastnameTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControl.Event.editingDidEnd)
        textFieldsView.addSubview(separatorView)
        firstnameTextField.addSubview(firstnameLabel)
        lastnameTextField.addSubview(lastnameTextFieldLabel)
        firstnameLabel.text = "Имя"
        lastnameTextFieldLabel.text = "Фамилия"
        firstnameLabel.textAlignment = .left
        lastnameTextFieldLabel.textAlignment = .left
        setIcon()
        setTitles()
        
        setColor()
        setConstraints()
    }
    
    private func setTitles() {
        super.setTitles(title: "Имя и фамилия", buttonTitle: "Продолжить")
    }
    private func setIcon() {
        if let image = UIImage(systemName: "person.fill") {
            super.setIcon(image: image)
        }
    }
    
    private func setColor() {
        textFieldsView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        separatorView.backgroundColor = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.36)
        firstnameTextField.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        lastnameTextField.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        firstnameLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        lastnameTextFieldLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    }
    @objc
    private func tryToResineFirstResponder(_ sender: UITapGestureRecognizer) {
        tryToResineFirstResponder()
    }
    private func tryToResineFirstResponder() {
        if firstnameTextField.isFirstResponder {
            firstnameTextField.resignFirstResponder()
        }
        if lastnameTextField.isFirstResponder {
            lastnameTextField.resignFirstResponder()
        }
    }
    public override func nextVC() {
        print(#function)
        print("следующий шаг")
        let vc: RegistrationEmailViewController = RegistrationEmailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension RegistrationNameViewController {
    @objc
    private func textFieldDidChanged(textField: UITextField) {
        if let text = textField.text {
            print(text)
            if textField == firstnameTextField {
                RegistrationModel.shared.firstName = text
            }
            if textField == lastnameTextField {
                RegistrationModel.shared.lastName = text
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
extension RegistrationNameViewController {
    private func setConstraints() {
        
        textFieldsView.translatesAutoresizingMaskIntoConstraints = false
        firstnameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastnameTextField.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        firstnameLabel.translatesAutoresizingMaskIntoConstraints = false
        lastnameTextFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: textFieldsView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: textFieldsView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.width, multiplier: 0.9, constant: 0).isActive = true
        NSLayoutConstraint(item: textFieldsView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: super.titleLabel, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 35).isActive = true
        
        NSLayoutConstraint(item: firstnameTextField, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: firstnameTextField, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: firstnameTextField, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: separatorView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: firstnameTextField, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: separatorView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: separatorView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: separatorView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 1).isActive = true
        
        NSLayoutConstraint(item: lastnameTextField, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: separatorView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: lastnameTextField, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: lastnameTextField, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: lastnameTextField, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: firstnameTextField, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 40).isActive = true
        NSLayoutConstraint(item: lastnameTextField, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 40).isActive = true
        
        NSLayoutConstraint(item: firstnameLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: firstnameTextField, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: firstnameLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: firstnameTextField, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 15).isActive = true
        NSLayoutConstraint(item: lastnameTextFieldLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: lastnameTextField, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: lastnameTextFieldLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: lastnameTextField, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 15).isActive = true
        
        
    }
}
