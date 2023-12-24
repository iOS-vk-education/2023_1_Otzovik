//
//  RegistrationOrganisationViewController.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 11.11.2023.
//

import UIKit

class RegistrationOrganisationViewController: BaseEntranceViewController {

    private lazy var upperSeparatorView: EntranceSeparatorView = EntranceSeparatorView()
    private lazy var bottomSeparatorView: EntranceSeparatorView = EntranceSeparatorView()
    private lazy var heiTextField: InsetTextField = {
        let textField = InsetTextField()
        textField.config(leftInset: 100.0)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textColor = Colors.textFieldText
        textField.text = RegistrationModel.shared.hei
        textField.placeholder = "ВУЗ"
        return textField
    }()
    private lazy var heiTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "ВУЗ"
        label.textAlignment = .left
        label.textColor = Colors.labelText
        return label
    }()
    private lazy var facultyTextField: InsetTextField = {
        let textField = InsetTextField()
        textField.config(leftInset: 100.0)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textColor = Colors.textFieldText
        textField.text = RegistrationModel.shared.faculty
        textField.placeholder = "факультет"
        return textField
    }()
    private lazy var facultyTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "Факультет"
        label.textAlignment = .left
        label.textColor = Colors.labelText
        return label
    }()
    private lazy var departmentTextField: InsetTextField = {
        let textField = InsetTextField()
        textField.config(leftInset: 100.0)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textColor = Colors.textFieldText
        textField.text = RegistrationModel.shared.department
        textField.placeholder = "кафедра"
        return textField
    }()
    private lazy var departmentTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "Кафедра"
        label.textAlignment = .left
        label.textColor = Colors.labelText
        return label
    }()
    private lazy var textFieldsView: EntranceTextFieldsView = EntranceTextFieldsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tryToResineFirstResponder(_:))))
        view.addSubview(textFieldsView)
        textFieldsView.addSubview(heiTextField)
        heiTextField.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        heiTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControl.Event.editingDidBegin)
        heiTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControl.Event.editingDidEnd)
        textFieldsView.addSubview(facultyTextField)
        facultyTextField.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        facultyTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControl.Event.editingDidBegin)
        facultyTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControl.Event.editingDidEnd)
        textFieldsView.addSubview(departmentTextField)
        departmentTextField.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        departmentTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControl.Event.editingDidBegin)
        departmentTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControl.Event.editingDidEnd)
        textFieldsView.addSubview(upperSeparatorView)
        textFieldsView.addSubview(bottomSeparatorView)
        heiTextField.addSubview(heiTextFieldLabel)
        facultyTextField.addSubview(facultyTextFieldLabel)
        departmentTextField.addSubview(departmentTextFieldLabel)
        setIcon()
        setTitles()
        setConstraints()
    }
    
    private func setTitles() {
        super.setTitles(title: "Учебное заведение", buttonTitle: "Продолжить")
    }
    private func setIcon() {
        if let image = UIImage(systemName: "graduationcap.fill") {
            super.setIcon(image: image)
        }
    }
    @objc
    private func tryToResineFirstResponder(_ sender: UITapGestureRecognizer) {
        tryToResineFirstResponder()
    }
    private func tryToResineFirstResponder() {
        if heiTextField.isFirstResponder {
            heiTextField.resignFirstResponder()
        }
        if facultyTextField.isFirstResponder {
            facultyTextField.resignFirstResponder()
        }
        if departmentTextField.isFirstResponder {
            departmentTextField.resignFirstResponder()
        }
    }
    public override func nextVC() {
        let vc: RegistrationPasswordViewController = RegistrationPasswordViewController()
        self.present(vc, animated: true, completion: {vc.delegate = self.delegate})
    }
}
extension RegistrationOrganisationViewController {
    @objc
    private func textFieldDidChanged(textField: UITextField) {
        if let text = textField.text {
            print(text)
            if textField == heiTextFieldLabel {
                RegistrationModel.shared.hei = text
            }
            if textField == facultyTextField {
                RegistrationModel.shared.faculty = text
            }
            if textField == departmentTextField {
                RegistrationModel.shared.department = text
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
extension RegistrationOrganisationViewController {
    private func setConstraints() {
        
        textFieldsView.translatesAutoresizingMaskIntoConstraints = false
        heiTextField.translatesAutoresizingMaskIntoConstraints = false
        facultyTextField.translatesAutoresizingMaskIntoConstraints = false
        departmentTextField.translatesAutoresizingMaskIntoConstraints = false
        upperSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        bottomSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        heiTextFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        facultyTextFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        departmentTextFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        
        textFieldsView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        textFieldsView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        textFieldsView.topAnchor.constraint(equalTo: super.titleLabel.bottomAnchor, constant: 35).isActive = true
        
        heiTextField.topAnchor.constraint(equalTo: textFieldsView.topAnchor).isActive = true
        heiTextField.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor).isActive = true
        heiTextField.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor).isActive = true
        heiTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        upperSeparatorView.topAnchor.constraint(equalTo: heiTextField.bottomAnchor).isActive = true
        upperSeparatorView.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor, constant: 20).isActive = true
        upperSeparatorView.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor).isActive = true
        upperSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        facultyTextField.topAnchor.constraint(equalTo: upperSeparatorView.bottomAnchor).isActive = true
        facultyTextField.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor).isActive = true
        facultyTextField.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor).isActive = true
        facultyTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        bottomSeparatorView.topAnchor.constraint(equalTo: facultyTextField.bottomAnchor).isActive = true
        bottomSeparatorView.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor, constant: 20).isActive = true
        bottomSeparatorView.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor).isActive = true
        bottomSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        departmentTextField.topAnchor.constraint(equalTo: bottomSeparatorView.bottomAnchor).isActive = true
        departmentTextField.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor).isActive = true
        departmentTextField.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor).isActive = true
        departmentTextField.bottomAnchor.constraint(equalTo: textFieldsView.bottomAnchor).isActive = true
        departmentTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        heiTextFieldLabel.centerYAnchor.constraint(equalTo: heiTextField.centerYAnchor).isActive = true
        heiTextFieldLabel.leadingAnchor.constraint(equalTo: heiTextField.leadingAnchor, constant: 15).isActive = true
        
        facultyTextFieldLabel.centerYAnchor.constraint(equalTo: facultyTextField.centerYAnchor).isActive = true
        facultyTextFieldLabel.leadingAnchor.constraint(equalTo: facultyTextField.leadingAnchor, constant: 15).isActive = true
        
        departmentTextFieldLabel.centerYAnchor.constraint(equalTo: departmentTextField.centerYAnchor).isActive = true
        departmentTextFieldLabel.leadingAnchor.constraint(equalTo: departmentTextField.leadingAnchor, constant: 15).isActive = true
    }
}
