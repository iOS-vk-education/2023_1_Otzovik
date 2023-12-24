//
//  BaseEntranceViewController.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 11.11.2023.
//

import UIKit

class BaseEntranceViewController: UIViewController {
    
    weak var delegate: ProfileViewControllerDelegate?
    
    private lazy var backView: UIView = UIView()
//    private lazy var backImageView: UIImageView = {
//        var imageView = UIImageView()
//        imageView.isUserInteractionEnabled = true
//        imageView.image = UIImage(systemName: "chevron.backward")
//        return imageView
//    }()
//    private lazy var backLabel: UILabel = {
//        var label = UILabel()
//        label.font = .systemFont(ofSize: 18)
//        label.textAlignment = .left
//        label.numberOfLines = 1
//        label.text = "Назад"
//        label.textColor = Colors.labelBackText
//        return label
//    }()
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
        view.addSubview(backView)
//        backView.addSubview(backImageView)
//        backView.addSubview(backLabel)
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backTap(_:))))
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
    @objc
    private func backTap(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
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
            backView,
//            backImageView,
//            backLabel,
            iconImageView,
            titleLabel,
            buttonView
        ].map({ $0.translatesAutoresizingMaskIntoConstraints = false })
        
        backView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 7).isActive = true
        backView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        backView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        backView.heightAnchor.constraint(equalToConstant: 35).isActive = true
//        
//        backImageView.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
//        backImageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 15).isActive = true
//        backImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
//        backImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        
//        backLabel.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
//        backLabel.leadingAnchor.constraint(equalTo: backImageView.trailingAnchor, constant: 3).isActive = true
        
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
