//
//  RegistrationLoginViewController.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 11.11.2023.
//

import UIKit

class RegistrationEmailViewController: BaseEntranceViewController {

    private let emailTextField: InsetTextField = {
        let textField = InsetTextField()
        textField.config(leftInset: 70.0)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textColor = Colors.textFieldText
        textField.text = RegistrationModel.shared.email
        textField.attributedPlaceholder = NSAttributedString(
            string: "email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.placeholder = "email"
        return textField
    }()
    
    private let emailTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textAlignment = .left
        label.textColor = Colors.labelText
        return label
    }()
    
    private lazy var textFieldsView: EntranceTextFieldsView = EntranceTextFieldsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tryToResineFirstResponder(_:))))
        view.addSubview(textFieldsView)
        textFieldsView.addSubview(emailTextField)
        emailTextField.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControl.Event.editingDidBegin)
        emailTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControl.Event.editingDidEnd)
        emailTextField.addSubview(emailTextFieldLabel)
        setIcon()
        setTitles()
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
        let vc: RegistrationOrganisationViewController = RegistrationOrganisationViewController()
        self.present(vc, animated: true, completion: {vc.delegate = self.delegate})
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
    private func textFieldDidBeginEditing(textField: UITextField) { }
    @objc
    private func textFieldDidEndEditing(textField: UITextField) { }
    @objc
    private func onReturn(textField: UITextField) { }
}
extension RegistrationEmailViewController {
    private func setConstraints() {
        
        let _ =
        [textFieldsView,
        emailTextField,
        emailTextFieldLabel].map({ $0.translatesAutoresizingMaskIntoConstraints = false })
        
        textFieldsView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        textFieldsView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        textFieldsView.topAnchor.constraint(equalTo: super.titleLabel.bottomAnchor, constant: 35).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: textFieldsView.topAnchor).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor).isActive = true
        emailTextField.bottomAnchor.constraint(equalTo: textFieldsView.bottomAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        emailTextFieldLabel.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor).isActive = true
        emailTextFieldLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor, constant: 15).isActive = true
    }
}
