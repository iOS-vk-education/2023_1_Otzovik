//
//  LoginViewController.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 27.10.2023.
//

import UIKit

class LoginViewController: BaseEntranceViewController {
    
    private lazy var separatorView: EntranceSeparatorView = EntranceSeparatorView()
    private lazy var loginTextField: InsetTextField = {
        var textField = InsetTextField()
        textField.config(leftInset: 85.0)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textColor = Colors.textFieldText
        //textField.placeholder = "почта"
        return textField
    }()
    private lazy var loginTextFieldLabel: UILabel = {
        var label = UILabel()
        label.text = "Почта"
        label.textAlignment = .left
        label.textColor = Colors.labelText
        return label
    }()
    private lazy var passwordTextField: InsetTextField = {
        var textField = InsetTextField()
        textField.config(leftInset: 85.0)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textColor = Colors.textFieldText
        textField.isSecureTextEntry = true
        //textField.placeholder = "пароль"
        return textField
    }()
    private lazy var passwordTextFieldLabel: UILabel = {
        var label = UILabel()
        label.text = "Пароль"
        label.textAlignment = .left
        label.textColor = Colors.labelText
        return label
    }()
    private lazy var textFieldsView: EntranceTextFieldsView = EntranceTextFieldsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tryToResineFirstResponder(_:))))
        view.addSubview(textFieldsView)
        textFieldsView.addSubview(loginTextField)
        textFieldsView.addSubview(passwordTextField)
        loginTextField.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        loginTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControl.Event.editingDidBegin)
        loginTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControl.Event.editingDidEnd)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControl.Event.editingDidBegin)
        passwordTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControl.Event.editingDidEnd)
        textFieldsView.addSubview(separatorView)
        loginTextField.addSubview(loginTextFieldLabel)
        passwordTextField.addSubview(passwordTextFieldLabel)
        setIcon()
        setTitle()
        setConstraints()
    }
    
    private func setTitle() {
        super.setTitles(title: "Вход", buttonTitle: "Продолжить")
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
        if loginTextField.isFirstResponder {
            loginTextField.resignFirstResponder()
        }
        if passwordTextField.isFirstResponder {
            passwordTextField.resignFirstResponder()
        }
    }
    public override func nextVC() {
//        print(#function)
        LoginModel.shared.login(completion: { errorMessage in
            if let errorMessage = errorMessage {
                let alert = UIAlertController(title: "Ошибка", message: "Проверьте правильность введенных данных и повторите попытку (\(errorMessage)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: { (action: UIAlertAction) in
                    self.passwordTextField.text = ""
                    self.tryToResineFirstResponder()
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
//                let factory = AppFactory()
//                let vc = factory.buildTabBar()
//                //self.navigationController?.pushViewController(vc, animated: true)
//                self.present(vc, animated: true)
                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: {self.delegate?.changeValueOfIsLogging()})
            }
        })
    }
}
extension LoginViewController {
    @objc
    private func textFieldDidChanged(textField: UITextField) {
        if let text = textField.text {
            if textField == loginTextField {
                LoginModel.shared.setLogin(login: text)
            }
            if textField == passwordTextField {
                LoginModel.shared.setPassword(password: text)
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
extension LoginViewController {
    private func setConstraints() {
        
        let _ =
        [textFieldsView,
        loginTextField,
        passwordTextField,
        separatorView,
        loginTextFieldLabel,
        passwordTextFieldLabel].map({ $0.translatesAutoresizingMaskIntoConstraints = false})
        
        textFieldsView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        textFieldsView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        textFieldsView.topAnchor.constraint(equalTo: super.titleLabel.bottomAnchor, constant: 35).isActive = true
        
        loginTextField.topAnchor.constraint(equalTo: textFieldsView.topAnchor).isActive = true
        loginTextField.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor).isActive = true
        loginTextField.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor).isActive = true
        loginTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        separatorView.topAnchor.constraint(equalTo: loginTextField.bottomAnchor).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor, constant: 20).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: separatorView.bottomAnchor).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor).isActive = true
        passwordTextField.bottomAnchor.constraint(equalTo: textFieldsView.bottomAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        loginTextFieldLabel.centerYAnchor.constraint(equalTo: loginTextField.centerYAnchor).isActive = true
        loginTextFieldLabel.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor, constant: 15).isActive = true
        
        passwordTextFieldLabel.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor).isActive = true
        passwordTextFieldLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: 15).isActive = true
    }
}
