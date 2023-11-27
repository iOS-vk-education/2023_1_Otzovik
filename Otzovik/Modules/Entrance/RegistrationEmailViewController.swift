//
//  RegistrationLoginViewController.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 11.11.2023.
//

import UIKit

class RegistrationEmailViewController: BaseEntranceViewController {

    let emailTextField: InsetTextField = InsetTextField()
    let emailLabel: UILabel = UILabel()
    let textFieldsView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tryToResineFirstResponder(_:))))
        view.addSubview(textFieldsView)
        textFieldsView.layer.cornerRadius = 12
        textFieldsView.layer.masksToBounds = true
        
        textFieldsView.addSubview(emailTextField)
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        //loginTextField.placeholder = "email"
        emailTextField.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControl.Event.editingDidBegin)
        emailTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControl.Event.editingDidEnd)
        
        emailTextField.addSubview(emailLabel)
        emailLabel.text = "Email"
        emailLabel.textAlignment = .left
        setIcon()
        setTitles()
        
        setColor()
        setConstraints()
    }
    
    private func setTitles() {
        super.setTitles(title: "Почта", buttonTitle: "Продолжить")
    }
    private func setIcon() {
        if let image = UIImage(systemName: "envelope") {
            super.setIcon(image: image)
        }
    }
    
    private func setColor() {
        textFieldsView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        emailTextField.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        emailLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    }
    @objc
    private func tryToResineFirstResponder(_ sender: UITapGestureRecognizer) {
        tryToResineFirstResponder()
    }
    private func tryToResineFirstResponder() {
        if emailTextField.isFirstResponder {
            emailTextField.resignFirstResponder()
        }
    }
    public override func nextVC() {
        print("следующий шаг")
        let vc: RegistrationOrganisationViewController = RegistrationOrganisationViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension RegistrationEmailViewController {
    @objc
    private func textFieldDidChanged(textField: UITextField) {
        if let text = textField.text {
            print(text)
            if textField == emailTextField {
                RegistrationModel.shared.email = text
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
extension RegistrationEmailViewController {
    private func setConstraints() {
        
        textFieldsView.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: textFieldsView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: textFieldsView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.width, multiplier: 0.9, constant: 0).isActive = true
        NSLayoutConstraint(item: textFieldsView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: super.titleLabel, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 35).isActive = true
        
        NSLayoutConstraint(item: emailTextField, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: emailTextField, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: emailTextField, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: emailTextField, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: emailTextField, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 40).isActive = true
        
        NSLayoutConstraint(item: emailLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: emailTextField, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: emailLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: emailTextField, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 15).isActive = true
    }
}
