//
//  ViewController.swift
//  Otzovik
//
//  Created by Leonid Perlin on 10/22/23.
//

import Foundation
import UIKit


final class ProfileViewController: UIViewController {
    
    private let userManager = UserManager()
    private var authUser: User?
    private let avatarImage = UIImageView()
    private let nameOfStudent = UILabel()
    private let university = UILabel()
    private let faculty = UILabel()
    private let cathedra = UILabel()
    private let buttonsTable = UITableView(frame: CGRect(), style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        
        loadData()
        
        view.addSubview(avatarImage)
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.layer.cornerRadius =  60
        avatarImage.layer.masksToBounds = true
        avatarImage.image = UIImage(named: authUser?.profileImageURL ?? "")
        avatarImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13.0).isActive = true
        avatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        avatarImage.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        avatarImage.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
        
        view.addSubview(nameOfStudent)
        nameOfStudent.text = authUser?.name
        nameOfStudent.translatesAutoresizingMaskIntoConstraints = false
        nameOfStudent.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameOfStudent.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 15.0).isActive = true
        nameOfStudent.font = UIFont(name:"HelveticaNeue-Medium", size: 24.0)
        
        view.addSubview(university)
        university.text = "Студент " + (authUser?.university ?? "")
        university.font = university.font.withSize(13.0)
        university.translatesAutoresizingMaskIntoConstraints = false
        university.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        university.topAnchor.constraint(equalTo: nameOfStudent.bottomAnchor, constant: 8.0).isActive = true
        university.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        university.numberOfLines = 0
        university.textAlignment = .center
        
        view.addSubview(faculty)
        faculty.text = "Факультет: " + (authUser?.faculty ?? "")
        faculty.font = faculty.font.withSize(13.0)
        faculty.translatesAutoresizingMaskIntoConstraints = false
        faculty.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        faculty.topAnchor.constraint(equalTo: university.bottomAnchor, constant: 3.0).isActive = true
        faculty.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        faculty.numberOfLines = 0
        faculty.textAlignment = .center
        
        view.addSubview(cathedra)
        cathedra.text = "Кафедра: " + (authUser?.cathedra ?? "")
        cathedra.font = cathedra.font.withSize(13.0)
        cathedra.translatesAutoresizingMaskIntoConstraints = false
        cathedra.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cathedra.topAnchor.constraint(equalTo: faculty.bottomAnchor, constant: 3.0).isActive = true
        cathedra.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        cathedra.numberOfLines = 0
        cathedra.textAlignment = .center
        
        buttonsTable.delegate = self
        buttonsTable.dataSource = self
        
        view.addSubview(buttonsTable)
        buttonsTable.translatesAutoresizingMaskIntoConstraints = false
        buttonsTable.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1).isActive = true
        buttonsTable.heightAnchor.constraint(equalToConstant: 176.0).isActive = true
        buttonsTable.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        buttonsTable.topAnchor.constraint(equalTo: cathedra.bottomAnchor, constant: 41.0).isActive = true
        buttonsTable.register(buttonInTable.self, forCellReuseIdentifier: "buttonInTable")
    }
    func loadData() {
        userManager.loadUserInfo() {[weak self] authUser in
            self?.authUser = authUser}
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 && indexPath.row == 1 {
            let settingsViewController = SettingsViewController()
            let navigationController = UINavigationController(rootViewController: settingsViewController)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true)
        }
        if indexPath.section == 0 && indexPath.row == 0 {
            let myFeedbackViewController = MyFeedbacksViewController()
            let navigationController = UINavigationController(rootViewController: myFeedbackViewController)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true)
        }
        if indexPath.section == 1 {
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
        if section == 0 {
            return 2
        }
        else {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.isScrollEnabled = false
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "buttonInTable", for: indexPath)
        var contentConfiguration = cell.defaultContentConfiguration()
        
        if indexPath.section == 0 {
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 55, bottom: 0, right: 0)
            if indexPath.row == 0 {
                contentConfiguration.image = UIImage(systemName: "person.badge.clock.fill")
                contentConfiguration.text = "Мои отзывы"
            }
            if indexPath.row == 1 {
                contentConfiguration.text = "Настройки"
                contentConfiguration.image = UIImage(systemName: "gear")
            }
        }
        if indexPath.section == 1 {
            contentConfiguration.text = "Выйти"
            contentConfiguration.attributedText = NSAttributedString(string: "Выйти", attributes: [ NSAttributedString.Key.foregroundColor: UIColor.systemRed ])
            cell.accessoryType = .disclosureIndicator
        }
        cell.contentConfiguration = contentConfiguration
        return cell
    }
}

final class buttonInTable: UITableViewCell {}
