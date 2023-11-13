//
//  EntranceViewController.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 27.10.2023.
//

import UIKit

class EntranceViewController: UIViewController {

    private let buttonLoginView = UIView()
    private let buttonRegistrationView = UIView()
    private let buttonTestView = UIView()
    private let buttonLoginLabel = UILabel()
    private let buttonRegistrationLabel = UILabel()
    private let buttonTestLabel = UILabel()
    private var buttons: [UIView] = []
    private var labels: [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttons.append(buttonLoginView)
        buttons.append(buttonRegistrationView)
        buttons.append(buttonTestView)
        labels.append(buttonLoginLabel)
        labels.append(buttonRegistrationLabel)
        labels.append(buttonTestLabel)
        buttonLoginView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.loginTap(_:))))
        buttonRegistrationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.registrationTap(_:))))
        buttonTestView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.testTap(_:))))
        buttonLoginLabel.text = "Логин"
        buttonRegistrationLabel.text = "Регистрация"
        buttonTestLabel.text = "Прямой путь"
        for button in buttons {
            view.addSubview(button)
            button.layer.cornerRadius = 12
            button.layer.masksToBounds = true
        }
        for (i, label) in labels.enumerated() {
            label.font = .systemFont(ofSize: 17)
            label.textAlignment = .center
            label.numberOfLines = 1
            buttons[i].addSubview(label)
        }
        setColor()
        setConstraints()
    }
    private func setColor() {
        view.backgroundColor = .white
        for button in buttons {
            button.backgroundColor = .black
        }
        for label in labels {
            label.textColor = .white
        }
    }
    @objc
    private func loginTap(_ sender: UITapGestureRecognizer) {
        print("tapped login")
        let vc: LoginViewController = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc
    private func registrationTap(_ sender: UITapGestureRecognizer) {
        print("tapped registration")
        let vc: RegistrationNameViewController = RegistrationNameViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc
    private func testTap(_ sender: UITapGestureRecognizer) {
        print("tapped test")
        //здесь нужно бы так, чтобы SearchViewController() был с таббаром определнным в AppDelegate
        let vc: SearchViewController = SearchViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension EntranceViewController {
    private func setConstraints() {
        for (i, _) in buttons.enumerated() {
            buttons[i].translatesAutoresizingMaskIntoConstraints = false
            labels[i].translatesAutoresizingMaskIntoConstraints = false
        }
        for (i, _) in buttons.enumerated() {
            NSLayoutConstraint(item: buttons[i], attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: buttons[i], attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.width, multiplier: 0.7, constant: 0).isActive = true
            NSLayoutConstraint(item: buttons[i], attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 45).isActive = true
            
            NSLayoutConstraint(item: labels[i], attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: buttons[i], attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: labels[i], attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: buttons[i], attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0).isActive = true
        }
        NSLayoutConstraint(item: buttonLoginView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: buttonRegistrationView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: -25).isActive = true
        NSLayoutConstraint(item: buttonRegistrationView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: buttonTestView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: buttonRegistrationView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 25).isActive = true

    }
}
