//
//  RegistrationReadyViewController.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 11.11.2023.
//

import UIKit

class RegistrationReadyViewController: BaseEntranceViewController {

    let textLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textLabel)
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 2
        let sfProTextFont = UIFont(name: "SFProText-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)
        let attributedString = NSMutableAttributedString(string: "Теперь вы можете пользоваться ", attributes: [NSAttributedString.Key.font: sfProTextFont])
        let boldFontAttribute = [NSAttributedString.Key.font: UIFont(name: "SFProText-Bold", size: 17) ?? UIFont.boldSystemFont(ofSize: 17)]
        let boldPart = NSMutableAttributedString(string: "Отзовик", attributes: boldFontAttribute)
        attributedString.append(boldPart)
        textLabel.attributedText = attributedString
        setIcon()
        setTitles()
        
        setColor()
        setConstraints()
    }
    
    private func setTitles() {
        super.setTitles(title: "Готово", buttonTitle: "Готово")
    }
    private func setIcon() {
        if let image = UIImage(systemName: "person.fill.checkmark") {
            super.setIcon(image: image)
        }
    }
    
    private func setColor() {
        textLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    }
    
    
    public override func nextVC() {
        print(#function)
        print("следующий шаг")
        let factory = AppFactory()
        let vc = factory.buildTabBar()
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
extension RegistrationReadyViewController {
    private func setConstraints() {
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: textLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: textLabel, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.width, multiplier: 0.8, constant: 0).isActive = true
        NSLayoutConstraint(item: textLabel, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: super.titleLabel, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 35).isActive = true

    }
}
