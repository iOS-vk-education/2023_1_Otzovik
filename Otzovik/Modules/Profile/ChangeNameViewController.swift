//
//  ChangeNameViewController.swift
//  Otzovik
//
//  Created by Александр Денисов on 27.12.2023.
//

import UIKit

final class ChangeNameViewController: UIViewController {
    
    private let userManager = UserManager()
    private var user_: User?
    
    private let buttonConfirm = UIButton(type: .system)
    private let infoLabel = UILabel()
    private let nameTextField = UITextField()
    private let surnameTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        surnameTextField.delegate = self
        nameTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
        
    }
    
    
    private func setup() {
        view.backgroundColor = .secondarySystemBackground
        title = "Изменение"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didCloseButtonTapped))
        
        let _ = [buttonConfirm, infoLabel, nameTextField, surnameTextField].map({
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        })
        
        setConstraints()
        
        buttonConfirm.setTitle("Подтвердить", for: .normal)
        buttonConfirm.addTarget(self, action: #selector(didConfirmButtonTapped), for: .touchUpInside)
        buttonConfirm.titleLabel?.font = .systemFont(ofSize: 20)
        buttonConfirm.backgroundColor = .tintColor
        buttonConfirm.setTitleColor(.systemGray6, for: .normal)
        buttonConfirm.layer.cornerRadius = 8
        
        infoLabel.text = "Измените свои имя и фамилию в полях ниже"
        infoLabel.font = .systemFont(ofSize: 14)
        infoLabel.textColor = .systemGray
        
        let _ = [nameTextField, surnameTextField].map({
            $0.layer.cornerRadius = 8
            $0.backgroundColor = .white
            $0.layer.sublayerTransform = CATransform3DMakeTranslation(9, 0, 0);

        })
        
        nameTextField.placeholder = "Введите ваше имя"
        surnameTextField.placeholder = "Введите вашу фамилию"
        
        setBeginningValueInTextFields()
    }
    
    private func setConstraints() {
        let _ = [buttonConfirm, infoLabel, nameTextField, surnameTextField].map({
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        })
        
        buttonConfirm.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45).isActive = true
        buttonConfirm.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        buttonConfirm.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        infoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 27).isActive = true
        infoLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 18).isActive = true
        surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 9).isActive = true
        
        let _ = [nameTextField, surnameTextField].map({
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 36).isActive = true
        })
        
    }
    
    private func setBeginningValueInTextFields() {
        userManager.getUser { [weak self] result in
            switch result {
                case .success(let user):
                    guard let self else {return}
                    user_ = user
                    if let usr = user_ {
                        let fullName = usr.name
                        let strArray = fullName.components(separatedBy: " ")
                        if strArray.count == 2 {
                            self.nameTextField.text = strArray[0]
                            self.surnameTextField.text = strArray[1]
                        } else { return }
                    }
                    break
                case .failure(let error):
                    print(error)
                    break
            }
        }
    }
    
    @objc
    private func didConfirmButtonTapped(sender: UIButton) {
        if let str1 = nameTextField.text,
            let str2 = surnameTextField.text,
           !str1.isEmpty && !str2.isEmpty {
            userManager.updateName(name: str1 + " " + str2) { [weak self] result in
                switch result {
                    case .success():
                        break
                    case .failure(let error):
                        print(error)
                        break
                }
            }
        }
        else {
            return
        }
        self.dismiss(animated: true)
    }
    
    @objc
    private func didCloseButtonTapped(sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension ChangeNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
}

extension ChangeNameViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChangeNameViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc 
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
