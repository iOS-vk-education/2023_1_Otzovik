//
//  RegistrationPasswordViewController.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 11.11.2023.
//

import UIKit

class RegistrationPasswordViewController: BaseEntranceViewController {

    private lazy var separatorView: EntranceSeparatorView = EntranceSeparatorView()
    private lazy var passwordTextField: InsetTextField = {
        var textField = InsetTextField()
        textField.config(leftInset: 100.0)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textColor = Colors.textFieldText
        textField.placeholder = "введите пароль"
        textField.isSecureTextEntry = true
        return textField
    }()
    private lazy var passwordTextFieldLabel: UILabel = {
        var label = UILabel()
        label.text = "Пароль"
        label.textAlignment = .left
        label.textColor = Colors.labelText
        return label
    }()
    private lazy var confirmationTextField: InsetTextField = {
        var textField = InsetTextField()
        textField.config(leftInset: 100.0)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textColor = Colors.textFieldText
        textField.placeholder = "введите пароль повторно"
        textField.isSecureTextEntry = true
        return textField
    }()
    private lazy var confirmationTextFieldLabel: UILabel = {
        var label = UILabel()
        label.text = "Подтвер."
        label.textAlignment = .left
        label.textColor = Colors.labelText
        return label
    }()
    
    private lazy var textFieldsView: EntranceTextFieldsView = EntranceTextFieldsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tryToResineFirstResponder(_:))))
        view.addSubview(textFieldsView)
        textFieldsView.addSubview(passwordTextField)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControl.Event.editingDidBegin)
        passwordTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControl.Event.editingDidEnd)
        textFieldsView.addSubview(confirmationTextField)
        confirmationTextField.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        confirmationTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControl.Event.editingDidBegin)
        confirmationTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControl.Event.editingDidEnd)
        textFieldsView.addSubview(separatorView)
        passwordTextField.addSubview(passwordTextFieldLabel)
        confirmationTextField.addSubview(confirmationTextFieldLabel)
        setIcon()
        setTitles()
        setConstraints()
    }
    
    private func setTitles() {
        super.setTitles(title: "Пароль", buttonTitle: "Зарегистрироваться")
    }
    
    private func setIcon() {
        if let image = UIImage(systemName: "rectangle.and.pencil.and.ellipsis") {
            super.setIcon(image: image)
        }
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
        /*RegistrationModel.shared.registration { isOk, message in
            if isOk {
                //здесь регистрация
                self.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: {self.delegate?.changeValueOfIsLogging()})
                let vc: RegistrationReadyViewController = RegistrationReadyViewController()
                self.present(vc, animated: true, completion: {vc.delegate = self.delegate})
            } else {
                let alert = UIAlertController(title: "Ошибка", message: "Проверьте правильность введенных данных и повторите попытку (\(message)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: { (action: UIAlertAction) in
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }*/
        
        let vc: RegistrationReadyViewController = RegistrationReadyViewController()
        self.present(vc, animated: true, completion: {vc.delegate = self.delegate})
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
    private func textFieldDidBeginEditing(textField: UITextField) { }
    @objc
    private func textFieldDidEndEditing(textField: UITextField) { }
    @objc
    private func onReturn(textField: UITextField) { }
}
extension RegistrationPasswordViewController {
    private func setConstraints() {
        
        textFieldsView.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmationTextField.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        passwordTextFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        confirmationTextFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        
        textFieldsView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        textFieldsView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        textFieldsView.topAnchor.constraint(equalTo: super.titleLabel.bottomAnchor, constant: 35).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: textFieldsView.topAnchor).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        separatorView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor, constant: 20).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        confirmationTextField.topAnchor.constraint(equalTo: separatorView.bottomAnchor).isActive = true
        confirmationTextField.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor).isActive = true
        confirmationTextField.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor).isActive = true
        confirmationTextField.bottomAnchor.constraint(equalTo: textFieldsView.bottomAnchor).isActive = true
        confirmationTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        passwordTextFieldLabel.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor).isActive = true
        passwordTextFieldLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: 15).isActive = true
        
        confirmationTextFieldLabel.centerYAnchor.constraint(equalTo: confirmationTextField.centerYAnchor).isActive = true
        confirmationTextFieldLabel.leadingAnchor.constraint(equalTo: confirmationTextField.leadingAnchor, constant: 15).isActive = true
    }
}
