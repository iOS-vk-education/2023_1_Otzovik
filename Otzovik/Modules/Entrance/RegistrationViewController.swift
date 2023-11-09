//
//  RegistrationViewController.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 27.10.2023.
//

import UIKit

class RegistrationViewController: UIViewController {

    let backView: UIView = UIView()
    let backLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backView)
        backView.addSubview(backLabel)
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backTap(_:))))
        backLabel.text = "Назад"
        backLabel.font = .systemFont(ofSize: 17)
        backLabel.textAlignment = .center
        backLabel.numberOfLines = 1
        setColor()
        setConstraints()
    }
    private func setColor() {
        view.backgroundColor = .white
        backView.backgroundColor = .black
        backLabel.textColor = .white
    }
    @objc
    private func backTap(_ sender: UITapGestureRecognizer) {
        print("tapped back")
        self.navigationController?.popViewController(animated: true)//tmp
    }

}
extension RegistrationViewController {
    private func setConstraints() {
        backView.translatesAutoresizingMaskIntoConstraints = false
        backLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint(item: backView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 15).isActive = true
        NSLayoutConstraint(item: backView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 25).isActive = true
        NSLayoutConstraint(item: backView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.width, multiplier: 0.2, constant: 0).isActive = true
        NSLayoutConstraint(item: backView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 40).isActive = true
            
        NSLayoutConstraint(item: backLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: backLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0).isActive = true

    }
}
