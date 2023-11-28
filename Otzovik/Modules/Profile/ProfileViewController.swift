//
//  ViewController.swift
//  Otzovik
//
//  Created by Leonid Perlin on 10/22/23.
//

import Foundation
import UIKit


final class ProfileViewController: UIViewController {
    
    private let navigationControllerFor = UINavigationController()
    
    private let avatarImage = UIImageView()
    
    private let nameOfStudent = UILabel()
    private let university = UILabel()
    private let faculty = UILabel()
    private let cathedra = UILabel()

    private let twoButtonsTable = UITableView()
    private let oneButtonTable = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        
        view.addSubview(avatarImage)
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.layer.cornerRadius =  10
        avatarImage.layer.masksToBounds = true
        avatarImage.image = UIImage(systemName: "person.circle")
        avatarImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13.0).isActive = true
        avatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        avatarImage.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        avatarImage.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
        
        view.addSubview(nameOfStudent)
        nameOfStudent.text = "Сарыглар Начын"
        nameOfStudent.translatesAutoresizingMaskIntoConstraints = false
        nameOfStudent.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameOfStudent.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 15.0).isActive = true
        nameOfStudent.font = UIFont(name:"HelveticaNeue-Medium", size: 24.0)
        
        view.addSubview(university)
        university.text = "Студент МГТУ. им. Баумана"
        university.font = university.font.withSize(13.0)
        university.translatesAutoresizingMaskIntoConstraints = false
        university.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        university.topAnchor.constraint(equalTo: nameOfStudent.bottomAnchor, constant: 8.0).isActive = true
        
        view.addSubview(faculty)
        faculty.text = "Факультет: Информатика и системы управления"
        faculty.font = faculty.font.withSize(13.0)
        faculty.translatesAutoresizingMaskIntoConstraints = false
        faculty.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        faculty.topAnchor.constraint(equalTo: university.bottomAnchor, constant: 3.0).isActive = true
        
        view.addSubview(cathedra)
        cathedra.text = "Кафедра: ИУ8"
        cathedra.font = cathedra.font.withSize(13.0)
        cathedra.translatesAutoresizingMaskIntoConstraints = false
        cathedra.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cathedra.topAnchor.constraint(equalTo: faculty.bottomAnchor, constant: 3.0).isActive = true
        
        twoButtonsTable.delegate = self
        twoButtonsTable.dataSource = self
        
        view.addSubview(twoButtonsTable)
        twoButtonsTable.translatesAutoresizingMaskIntoConstraints = false
        twoButtonsTable.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        twoButtonsTable.heightAnchor.constraint(equalToConstant: 88.0).isActive = true
        twoButtonsTable.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        twoButtonsTable.topAnchor.constraint(equalTo: cathedra.bottomAnchor, constant: 41.0).isActive = true
        twoButtonsTable.register(buttonInTable.self, forCellReuseIdentifier: "buttonInTable")
        twoButtonsTable.layer.cornerRadius = 10.0
        
        oneButtonTable.delegate = self
        oneButtonTable.dataSource = self
                
        view.addSubview(oneButtonTable)
        oneButtonTable.translatesAutoresizingMaskIntoConstraints = false
        oneButtonTable.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        oneButtonTable.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        oneButtonTable.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        oneButtonTable.topAnchor.constraint(equalTo: twoButtonsTable.bottomAnchor, constant: 44.0).isActive = true
        oneButtonTable.register(buttonInTable.self, forCellReuseIdentifier: "buttonInTable")
        oneButtonTable.layer.cornerRadius = 10
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView == twoButtonsTable && indexPath.row == 1 {
            let settingsViewController = SettingsViewController()
            let navigationController = UINavigationController(rootViewController: settingsViewController)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true)
        }
        if tableView == twoButtonsTable && indexPath.row == 0 {
            let myFeedbackViewController = MyFeedbacksViewController()
            let navigationController = UINavigationController(rootViewController: myFeedbackViewController)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true)
        }
        if tableView == oneButtonTable {
            let alertExitController = UIAlertController(title: "Внимание!", message: "Вы уверены, что хотите выйти из своего профиля?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
            alertExitController.addAction(cancelAction)
            let exitAction = UIAlertAction(title: "Выйти", style: .destructive) { UIAlertAction in print("Exit") }
            alertExitController.addAction(exitAction)
            present(alertExitController, animated: true)
        }
    }
}



extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == twoButtonsTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "buttonInTable", for: indexPath)
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 55, bottom: 0, right: 0)
            var contentConfiguration = cell.defaultContentConfiguration()
            
            if indexPath.row == 0 {
                contentConfiguration.image = UIImage(systemName: "person.badge.clock.fill")
                contentConfiguration.text = "Мои отзывы"
            }
            else {
                contentConfiguration.text = "Настройки"
                contentConfiguration.image = UIImage(systemName: "gear")
            }
            cell.contentConfiguration = contentConfiguration
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "buttonInTable", for: indexPath)
            tableView.separatorColor = UIColor.clear
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = "Выйти"
            contentConfiguration.attributedText = NSAttributedString(string: "Выйти", attributes: [ NSAttributedString.Key.foregroundColor: UIColor.systemRed ])
            cell.accessoryType = .disclosureIndicator
            cell.contentConfiguration = contentConfiguration
            return cell
        }
    }
}



final class buttonInTable: UITableViewCell {}
