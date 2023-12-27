//
//  EntranceViewController.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 27.10.2023.
//

import UIKit

class EntranceViewController: UIViewController {
    
    weak var delegate: ProfileViewControllerDelegate?

    private lazy var logoImageView: UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "logo.png")
        return iv
    }()
    private lazy var buttonLoginView: EntranceButton = {
        var view = EntranceButton()
        view.titleLabel.text = "Логин"
        return view
    }()
    private lazy var buttonRegistrationView: EntranceButton = {
        var view = EntranceButton()
        view.titleLabel.text = "Регистрация"
        return view
    }()
    
    
    private let animationTime: Double = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        view.addSubview(buttonLoginView)
        view.addSubview(buttonRegistrationView)

        view.addSubview(logoImageView)
        buttonLoginView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.loginTap(_:))))
        buttonRegistrationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.registrationTap(_:))))
        setConstraints()
    }
    @objc
    private func loginTap(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: self.animationTime) {
            self.buttonLoginView.layer.opacity = 0.5
        } completion: { isOk in
            UIView.animate(withDuration: self.animationTime) {
                self.buttonLoginView.layer.opacity = 1.0
            } completion: { isOk in
                let vc: LoginViewController = LoginViewController()
                self.present(vc, animated: true, completion: {vc.delegate = self.delegate})
            }
        }
    }
    @objc
    private func registrationTap(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: self.animationTime) {
            self.buttonRegistrationView.layer.opacity = 0.5
        } completion: { isOk in
            UIView.animate(withDuration: self.animationTime) {
                self.buttonRegistrationView.layer.opacity = 1.0
            } completion: { isOk in
                let vc: RegistrationNameViewController = RegistrationNameViewController()
                self.present(vc, animated: true, completion: {vc.delegate = self.delegate})
            }
        }
    }
    
}

extension EntranceViewController {
    private func setConstraints() {

        let _ = [
            logoImageView,
            buttonLoginView,
            buttonRegistrationView,
        ].map({ $0.translatesAutoresizingMaskIntoConstraints = false })
        
        let _ = [
            buttonLoginView,
            buttonRegistrationView,
        ].map({ $0.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true })
        
        let _ = [
            buttonLoginView,
            buttonRegistrationView,
        ].map({ $0.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true })
        
        let _ = [
            buttonLoginView,
            buttonRegistrationView,
        ].map({ $0.heightAnchor.constraint(equalToConstant: 45.0).isActive = true })
        
        buttonLoginView.bottomAnchor.constraint(equalTo: buttonRegistrationView.topAnchor, constant: -20).isActive = true
        buttonRegistrationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        
        logoImageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.4).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.4).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: -100.0).isActive = true
    }
}
