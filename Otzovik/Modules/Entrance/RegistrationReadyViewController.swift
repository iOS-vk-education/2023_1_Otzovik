//
//  RegistrationReadyViewController.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 11.11.2023.
//

import UIKit

class RegistrationReadyViewController: BaseEntranceViewController {

    private lazy var textLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = Colors.labelReadyText
        let sfProTextFont = UIFont(name: "SFProText-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)
        let attributedString = NSMutableAttributedString(string: "Теперь вы можете пользоваться ", attributes: [NSAttributedString.Key.font: sfProTextFont])
        let boldFontAttribute = [NSAttributedString.Key.font: UIFont(name: "SFProText-Bold", size: 17) ?? UIFont.boldSystemFont(ofSize: 17)]
        let boldPart = NSMutableAttributedString(string: "Отзовик", attributes: boldFontAttribute)
        attributedString.append(boldPart)
        label.attributedText = attributedString
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textLabel)
        setIcon()
        setTitles()
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
    
    public override func nextVC() {
        RegistrationModel.shared.registration { isOk, message in
            if isOk {
                //здесь регистрация
                self.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: {self.delegate?.changeValueOfIsLogging()})
            } else {
                let alert = UIAlertController(title: "Ошибка", message: "Проверьте правильность введенных данных и повторите попытку (\(message)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: { (action: UIAlertAction) in
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
extension RegistrationReadyViewController {
    private func setConstraints() {  
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        textLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        textLabel.topAnchor.constraint(equalTo: super.titleLabel.bottomAnchor, constant: 10).isActive = true
    }
}

