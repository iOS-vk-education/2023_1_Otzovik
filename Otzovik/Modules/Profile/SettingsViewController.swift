//
//  SettingsViewController.swift
//  Otzovik
//
//  Created by Александр Денисов on 27.11.2023.
//

import UIKit
import FirebaseAuth

final class SettingsViewController : UIViewController {
    
    private let userManager = UserManager()
    
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
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
        
        setSelectedSegment()
        setConstraints()
    }
    
    @objc private func segmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                UserDefaults.standard.setValue(Theme.light.rawValue, forKey: "theme")
                break
            case 1:
                UserDefaults.standard.setValue(Theme.system.rawValue, forKey: "theme")
                break
            case 2:
                UserDefaults.standard.setValue(Theme.dark.rawValue, forKey: "theme")
                break
            default:
                
                break
        }
    }
    
    private func setSelectedSegment() {
        let theme = UserDefaults.standard.value(forKey: "theme") as? Theme.RawValue
        switch theme {
            case "dark":
                segmentedControl.selectedSegmentIndex = 2
                break
            case "light":
                segmentedControl.selectedSegmentIndex = 0
                break
            case "system":
                segmentedControl.selectedSegmentIndex = 1
                break
            default:
                segmentedControl.selectedSegmentIndex = 1
                break
        }
    }
    
    private func didTapUploadImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    func upload(image: UIImage?) {
        guard let image else {
            return
        }
        ImageLoader.shared.upload(image: image) { [weak self] result in
            switch result {
                case .success(let name):
                    self?.userManager.updateImage(imageName: name, completion: {res in
                        switch res {
                            case .success():
                                break
                            case .failure(let err):
                                print(err)
                                break
                        }
                    })
                    break
                case .failure(let error):
                    print(error)
                    break
            }
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
                let changeUniversity = ChooseUniversityViewController()
                changeUniversity.isCalledFromRegistration = true
                present(changeUniversity, animated: true)
                break
            case 1:
                let changeChair = FilterViewController()
                changeChair.isCalledFromRegistration = true
                present(changeChair, animated: true)
                break
            case 2:
                let changeInfoController = ChangeNameViewController()
                let navigationController = UINavigationController(rootViewController: changeInfoController)
                present(navigationController, animated: true)
                break
            case 3:
                didTapUploadImage()
                break
            case 4:
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
            return 5
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if let _ = Auth.auth().currentUser {
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
                    contentConfiguration.text = "Сменить ВУЗ"
                    cell.accessoryType = .disclosureIndicator
                    break
                case 1:
                    contentConfiguration.text = "Сменить кафедру"
                    cell.accessoryType = .disclosureIndicator
                case 2:
                    contentConfiguration.text = "Изменить информацию о себе"
                    cell.accessoryType = .disclosureIndicator
                    break
                case 3:
                    contentConfiguration.text = "Загрузить новое фото профиля"
                    break
                case 4:
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
        tableButtons.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        tableButtons.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0).isActive = true
        
        segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 32).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
    }
}

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        upload(image: image)
        
        picker.dismiss(animated: true)
    }
}
