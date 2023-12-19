//
//  SettingsViewController.swift
//  Otzovik
//
//  Created by Александр Денисов on 27.11.2023.
//

import UIKit
import FirebaseAuth

final class SettingsViewController : UIViewController {
    
    private let tableButtons = UITableView(frame: .zero, style: .insetGrouped)
    private let segmentedControl = UISegmentedControl(items: ["Светлая", "Системная", "Темная"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Настройки"
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(tableButtons)
        view.addSubview(segmentedControl)
        tableButtons.register(tableCell.self, forCellReuseIdentifier: "TableCell")
        tableButtons.delegate = self
        tableButtons.dataSource = self
        segmentedControl.selectedSegmentIndex = Colors.getColorSchemeForSegmentedControl()
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
        setConstraints()
    }
    
    @objc private func segmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                print("light theme")
                Colors.colorScheme = .light
                break
            case 1:
                print("system theme")
                Colors.colorScheme = .system
                break
            case 2:
                print("dark theme")
                Colors.colorScheme = .dark
                break
            default:
                break
        }
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 22
        }
        return 22
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
            case 0:
                break
            case 1:
                let changeInfoController = RegistrationNameViewController()
                navigationController?.pushViewController(changeInfoController, animated: true)
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
        if section == 0 {
            return 1
        }
        else {
            return 3
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if let user = Auth.auth().currentUser {
            return 2
        }
        else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Тема"
        }
        else {
            return "Настройки профиля"
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        cell.backgroundColor = .systemBackground
        tableView.backgroundColor = .secondarySystemBackground
        tableView.isScrollEnabled = false
        var contentConfiguration = cell.defaultContentConfiguration()
        if indexPath.section == 0 {
            cell.backgroundColor = .clear
            cell.isUserInteractionEnabled = false
        }
        if indexPath.section == 1 {
            switch indexPath.row {
                case 0:
                    contentConfiguration.text = "Сменить вуз/кафедру"
                    cell.accessoryType = .disclosureIndicator
                    break
                case 1:
                    contentConfiguration.text = "Изменить информацию о себе"
                    cell.accessoryType = .disclosureIndicator
                    break
                case 2:
                    contentConfiguration.text = "Сбросить все свои избранные"
                    break
                default:
                    break
            }
        }
        cell.contentConfiguration = contentConfiguration
        return cell
    }
}

final class tableCell: UITableViewCell {}

extension SettingsViewController {
    private func setConstraints() {
        let _ = [
        tableButtons,
        segmentedControl
        ].map({$0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true})


        tableButtons.widthAnchor.constraint(equalTo:view.safeAreaLayoutGuide.widthAnchor, multiplier: 1).isActive = true
        tableButtons.heightAnchor.constraint(equalToConstant: 300).isActive = true
        tableButtons.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0).isActive = true
        
        segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 32).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
    }
}
