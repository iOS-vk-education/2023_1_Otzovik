//
//  BaseEntranceViewController.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 11.11.2023.
//

import UIKit

class BaseEntranceViewController: UIViewController {
    
    weak var delegate: ProfileViewControllerDelegate?
    
    private lazy var iconImageView: UIImageView = UIImageView()
    public lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = Colors.labelTitleText
        return label
    }()
    private lazy var buttonView: EntranceButton = EntranceButton()
    
    private let animationTime: Double = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        view.addSubview(iconImageView)
        view.addSubview(titleLabel)
        view.addSubview(buttonView)
        buttonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.nextVC(_:))))
        setConstraints()
    }
    public func setTitles(title: String, buttonTitle: String) {
        titleLabel.text = title
        buttonView.titleLabel.text = buttonTitle
    }
    public func setIcon(image: UIImage) {
        iconImageView.image = image
    }

    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc
    private func nextVC(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: self.animationTime) {
            self.buttonView.layer.opacity = 0.5
        } completion: { isOk in
            UIView.animate(withDuration: self.animationTime) {
                self.buttonView.layer.opacity = 1
            } completion: { isOk in
                self.nextVC()
            }
        }
    }
    public func nextVC() {}

}
extension BaseEntranceViewController {
    private func setConstraints() {
        let _ = [
            iconImageView,
            titleLabel,
            buttonView
        ].map({ $0.translatesAutoresizingMaskIntoConstraints = false })
        
        
        iconImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -250).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 25).isActive = true

        buttonView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        buttonView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        buttonView.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
        buttonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -35).isActive = true
        
    }
}
