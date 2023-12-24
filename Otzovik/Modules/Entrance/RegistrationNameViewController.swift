//
//  RegistrationNameViewController.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 27.10.2023.
//

import UIKit

class RegistrationNameViewController: BaseEntranceViewController {
    
    private lazy var separatorView: EntranceSeparatorView = EntranceSeparatorView()
    private lazy var firstnameTextField: InsetTextField = {
        var textField = InsetTextField()
        textField.config(leftInset: 95.0)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textColor = Colors.textFieldText
        //textField.placeholder = "имя"
        return textField
    }()
    private lazy var firstnameTextFieldLabel: UILabel = {
        var label = UILabel()
        label.text = "Имя"
        label.textAlignment = .left
        label.textColor = Colors.labelText
        return label
    }()
    private lazy var lastnameTextField: InsetTextField = {
        var textField = InsetTextField()
        textField.config(leftInset: 95.0)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textColor = Colors.textFieldText
        //textField.placeholder = "фамилия"
        return textField
    }()
    private lazy var lastnameTextFieldLabel: UILabel = {
        var label = UILabel()
        label.text = "Фамилия"
        label.textAlignment = .left
        label.textColor = Colors.labelText
        return label
    }()
    private lazy var textFieldsView: EntranceTextFieldsView = EntranceTextFieldsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tryToResineFirstResponder(_:))))
        view.addSubview(textFieldsView)
        textFieldsView.addSubview(firstnameTextField)
        firstnameTextField.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        firstnameTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControl.Event.editingDidBegin)
        firstnameTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControl.Event.editingDidEnd)
        textFieldsView.addSubview(lastnameTextField)
        lastnameTextField.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        lastnameTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControl.Event.editingDidBegin)
        lastnameTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControl.Event.editingDidEnd)
        textFieldsView.addSubview(separatorView)
        firstnameTextField.addSubview(firstnameTextFieldLabel)
        lastnameTextField.addSubview(lastnameTextFieldLabel)
        setIcon()
        setTitles()
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
        let vc: RegistrationEmailViewController = RegistrationEmailViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: {vc.delegate = self.delegate})
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
    private func textFieldDidBeginEditing(textField: UITextField) { }
    @objc
    private func textFieldDidEndEditing(textField: UITextField) { }
    @objc
    private func onReturn(textField: UITextField) { }
}
extension RegistrationNameViewController {
    private func setConstraints() {
        
        let _ =
        [textFieldsView,
        firstnameTextField,
        lastnameTextField,
        separatorView,
        firstnameTextFieldLabel,
        lastnameTextFieldLabel].map({ $0.translatesAutoresizingMaskIntoConstraints = false})
        
        textFieldsView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        textFieldsView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        textFieldsView.topAnchor.constraint(equalTo: super.titleLabel.bottomAnchor, constant: 35).isActive = true
        
        firstnameTextField.topAnchor.constraint(equalTo: textFieldsView.topAnchor).isActive = true
        firstnameTextField.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor).isActive = true
        firstnameTextField.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor).isActive = true
        firstnameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        separatorView.topAnchor.constraint(equalTo: firstnameTextField.bottomAnchor).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor, constant: 20).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        lastnameTextField.topAnchor.constraint(equalTo: separatorView.bottomAnchor).isActive = true
        lastnameTextField.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor).isActive = true
        lastnameTextField.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor).isActive = true
        lastnameTextField.bottomAnchor.constraint(equalTo: textFieldsView.bottomAnchor).isActive = true
        lastnameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        firstnameTextFieldLabel.centerYAnchor.constraint(equalTo: firstnameTextField.centerYAnchor).isActive = true
        firstnameTextFieldLabel.leadingAnchor.constraint(equalTo: firstnameTextField.leadingAnchor, constant: 15).isActive = true
        
        lastnameTextFieldLabel.centerYAnchor.constraint(equalTo: lastnameTextField.centerYAnchor).isActive = true
        lastnameTextFieldLabel.leadingAnchor.constraint(equalTo: lastnameTextField.leadingAnchor, constant: 15).isActive = true
    }
}
