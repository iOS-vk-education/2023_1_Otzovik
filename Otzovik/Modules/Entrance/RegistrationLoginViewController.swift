//
//  RegistrationLoginViewController.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 11.11.2023.
//

import UIKit

class RegistrationLoginViewController: BaseEntranceViewController {

    let loginTextField: InsetTextField = InsetTextField()
    let loginLabel: UILabel = UILabel()
    let textFieldsView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tryToResineFirstResponder(_:))))
        view.addSubview(textFieldsView)
        textFieldsView.layer.cornerRadius = 12
        textFieldsView.layer.masksToBounds = true
        
        textFieldsView.addSubview(loginTextField)
        loginTextField.autocorrectionType = .no
        loginTextField.autocapitalizationType = .none
        //loginTextField.placeholder = "логин"
        loginTextField.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        loginTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControl.Event.editingDidBegin)
        loginTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControl.Event.editingDidEnd)
        
        loginTextField.addSubview(loginLabel)
        loginLabel.text = "Логин"
        loginLabel.textAlignment = .left
        setIcon()
        setTitle()
        
        setColor()
        setConstraints()
    }
    
    private func setTitle() {
        super.setTitle(title: "Никнейм")
    }
    private func setIcon() {
        if let image = UIImage(systemName: "pencil.and.scribble") {
            super.setIcon(image: image)
        }
    }
    
    private func setColor() {
        textFieldsView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        loginTextField.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        loginLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    }
    @objc
    private func tryToResineFirstResponder(_ sender: UITapGestureRecognizer) {
        tryToResineFirstResponder()
    }
    private func tryToResineFirstResponder() {
        if loginTextField.isFirstResponder {
            loginTextField.resignFirstResponder()
        }
    }
    public override func nextVC() {
        print("следующий шаг")
        let vc: RegistrationOrganisationViewController = RegistrationOrganisationViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension RegistrationLoginViewController {
    @objc
    private func textFieldDidChanged(textField: UITextField) {
        print(textField.text)
        
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
extension RegistrationLoginViewController {
    private func setConstraints() {
        
        textFieldsView.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: textFieldsView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: textFieldsView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.width, multiplier: 0.9, constant: 0).isActive = true
        NSLayoutConstraint(item: textFieldsView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: super.titleLabel, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 35).isActive = true
        
        NSLayoutConstraint(item: loginTextField, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: loginTextField, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: loginTextField, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: loginTextField, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: textFieldsView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: loginTextField, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 40).isActive = true
        
        NSLayoutConstraint(item: loginLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: loginTextField, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: loginLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: loginTextField, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 15).isActive = true
    }
}
