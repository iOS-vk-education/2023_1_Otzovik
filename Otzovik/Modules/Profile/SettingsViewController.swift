//
//  SettingsViewController.swift
//  Otzovik
//
//  Created by Александр Денисов on 27.11.2023.
//

import UIKit


final class SettingsViewController : UIViewController {
    
    private let tableButtons = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Настройки"
        let buttonBack = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(didTapCloseButton))
        navigationItem.leftBarButtonItem = buttonBack
        
        view.backgroundColor = .secondarySystemBackground
        
        view.addSubview(tableButtons)
        tableButtons.translatesAutoresizingMaskIntoConstraints = false
        tableButtons.widthAnchor.constraint(equalTo:view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        tableButtons.heightAnchor.constraint(equalToConstant: 152).isActive = true
        tableButtons.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        tableButtons.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0).isActive = true
        tableButtons.register(tableCell.self, forCellReuseIdentifier: "TableCell")
        tableButtons.delegate = self
        tableButtons.dataSource = self
        
    }
    
    @objc private func didTapCloseButton() {
        dismiss(animated: true)
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
            case 0:
                //переход на view controller с выбором
                break
            case 1:
                //переход на view controller c настройками под себя
                break
            case 2:
                let alertController = UIAlertController(title: "Внимание!", message: "Вы уверены, что хотите сбросить все свои избранные?", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
                let deleteAction = UIAlertAction(title: "Сбросить", style: .destructive) {UIAlertAction in print("deleted")}
                alertController.addAction(cancelAction)
                alertController.addAction(deleteAction)
                present(alertController, animated: true)
                break
            default:
                break
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Настройки профиля"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        cell.backgroundColor = .systemBackground
        tableView.backgroundColor = .secondarySystemBackground
        tableView.isScrollEnabled = false
        var contentConfiguration = cell.defaultContentConfiguration()
        switch indexPath.row {
            case 0:
                cell.clipsToBounds = true
                cell.layer.cornerRadius = 10
                cell.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                contentConfiguration.text = "Сменить вуз/кафедру"
                cell.accessoryType = .disclosureIndicator
                break
            case 1:
                contentConfiguration.text = "Изменить информацию о себе"
                cell.accessoryType = .disclosureIndicator
                break
            case 2:
                contentConfiguration.text = "Сбросить все свои избранные"
                cell.clipsToBounds = true
                cell.layer.cornerRadius = 10
                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                break
            default:
                break
        }
        cell.contentConfiguration = contentConfiguration
        return cell
    }
}

final class tableCell: UITableViewCell {}
