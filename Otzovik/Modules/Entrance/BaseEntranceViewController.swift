//
//  BaseEntranceViewController.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 11.11.2023.
//

import UIKit

class BaseEntranceViewController: UIViewController {

    let backView: UIView = UIView()
    let backImageView: UIImageView = UIImageView()
    let backLabel: UILabel = UILabel()
    let iconImageView: UIImageView = UIImageView()
    let titleLabel: UILabel = UILabel()
    let buttonView: UIView = UIView()
    let buttonLabel: UILabel = UILabel()
    let animationTime: Double = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(backView)
        backView.addSubview(backImageView)
        backView.addSubview(backLabel)
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backTap(_:))))
        backImageView.isUserInteractionEnabled = true
        backImageView.image = UIImage(systemName: "chevron.backward")
        backLabel.font = .systemFont(ofSize: 18)
        backLabel.textAlignment = .left
        backLabel.numberOfLines = 1
        backLabel.text = "Назад"
        
        view.addSubview(iconImageView)
        
        view.addSubview(titleLabel)
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        
        view.addSubview(buttonView)
        buttonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.nextVC(_:))))
        buttonView.layer.cornerRadius = 12
        buttonView.layer.masksToBounds = true
        buttonView.addSubview(buttonLabel)
        buttonLabel.font = .systemFont(ofSize: 17)
        buttonLabel.textAlignment = .center
        buttonLabel.numberOfLines = 1
        buttonLabel.text = "Продолжить"
        
        setColor()
        setConstraints()
    }
    public func setTitle(title: String) {
        titleLabel.text = title
    }
    public func setIcon(image: UIImage) {
        iconImageView.image = image
    }
    @objc
    private func backTap(_ sender: UITapGestureRecognizer) {
        print(#function)
        self.navigationController?.popViewController(animated: true)
    }
    @objc
    private func nextVC(_ sender: UITapGestureRecognizer) {
        print(#function)
        UIView.animate(withDuration: self.animationTime) {
            self.buttonView.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 0.5)
        } completion: { isOk in
            UIView.animate(withDuration: self.animationTime) {
                self.buttonView.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
            } completion: { isOk in
                
                self.nextVC()
            }
        }
    }
    public func nextVC() {}
    private func setColor() {
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
        backLabel.textColor = .blue
        titleLabel.textColor = .black
        buttonView.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
        buttonLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    }

}
extension BaseEntranceViewController {
    private func setConstraints() {
        backView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint(item: backView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 3).isActive = true
        NSLayoutConstraint(item: backView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: backView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 150).isActive = true
        NSLayoutConstraint(item: backView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 35).isActive = true
        
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        backLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: backImageView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 15).isActive = true
        NSLayoutConstraint(item: backImageView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: backImageView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 25).isActive = true
        NSLayoutConstraint(item: backImageView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 30).isActive = true
        
        NSLayoutConstraint(item: backLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backImageView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 3).isActive = true
        NSLayoutConstraint(item: backLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0).isActive = true
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: iconImageView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: iconImageView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 0.35, constant: 0).isActive = true
        NSLayoutConstraint(item: iconImageView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 80).isActive = true
        NSLayoutConstraint(item: iconImageView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 70).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: titleLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 0.5, constant: 0).isActive = true
        
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: buttonView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: -35).isActive = true
        NSLayoutConstraint(item: buttonView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: buttonView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.width, multiplier: 0.9, constant: 0).isActive = true
        NSLayoutConstraint(item: buttonView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 45).isActive = true
        
        NSLayoutConstraint(item: buttonLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: buttonView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: buttonLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: buttonView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0).isActive = true
    }
}
