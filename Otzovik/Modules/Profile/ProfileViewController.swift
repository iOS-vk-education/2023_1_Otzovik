//
//  ViewController.swift
//  Otzovik
//
//  Created by Leonid Perlin on 10/22/23.
//

import UIKit
import FirebaseAuth

final class ProfileViewController: UIViewController {
    
    private let userManager = UserManager()
    private var authUser: User?
    
    private var avatarImage = UIImageView()
    private let nameOfStudent = UILabel()
    private let university = UILabel()
    private let faculty = UILabel()
    private let cathedra = UILabel()
    private let buttonsTable = UITableView(frame: CGRect(), style: .insetGrouped)
    
    private let imageOfRegistration = UIImageView()
    private let logInButton = UIButton(type: .system)
    private let lableOfRegistration = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        title = "Профиль"
        
        if let user = Auth.auth().currentUser {
            loadData()
            
            view.addSubview(avatarImage)
            view.addSubview(nameOfStudent)
            view.addSubview(university)
            view.addSubview(faculty)
            view.addSubview(cathedra)
            view.addSubview(buttonsTable)
            
            avatarImage.layer.cornerRadius =  60
            avatarImage.layer.masksToBounds = true
            avatarImage.image = UIImage(named: authUser?.profileImageURL ?? "")
            nameOfStudent.text = authUser?.name
            nameOfStudent.font = UIFont(name:"HelveticaNeue-Medium", size: 24.0)
            university.text = "Студент " + (authUser?.university ?? "")
            university.font = university.font.withSize(13.0)
            university.numberOfLines = 0
            university.textAlignment = .center
            faculty.text = "Факультет: " + (authUser?.faculty ?? "")
            faculty.font = faculty.font.withSize(13.0)
            faculty.numberOfLines = 0
            faculty.textAlignment = .center
            cathedra.text = "Кафедра: " + (authUser?.cathedra ?? "")
            cathedra.font = cathedra.font.withSize(13.0)
            cathedra.numberOfLines = 0
            cathedra.textAlignment = .center
            buttonsTable.delegate = self
            buttonsTable.dataSource = self
            buttonsTable.register(buttonInTable.self, forCellReuseIdentifier: "buttonInTable")
            func loadData() {
                userManager.loadUserInfo() {[weak self] authUser in
                    self?.authUser = authUser}
            }
        }
        else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(didButtonSettingsTapped))
            
            view.addSubview(lableOfRegistration)
            view.addSubview(imageOfRegistration)
            view.addSubview(logInButton)

            imageOfRegistration.image = UIImage(systemName: "person.fill.xmark")
            imageOfRegistration.tintColor = .systemGray4
            lableOfRegistration.text = "Для того, чтобы работать с профилем и оставлять отзывы, войдите или зарегистрируйтесь"
            lableOfRegistration.textColor = .systemGray2
            lableOfRegistration.numberOfLines = 0
            lableOfRegistration.font = UIFont(name: "Helvetica Neue", size: 14.0)
            lableOfRegistration.textAlignment = .center
            logInButton.setTitle("Зарегистрироваться / войти", for: .normal)
            logInButton.addTarget(self, action: #selector(didLogInButtonTapped), for: .touchUpInside)
        }
        setConstraints()
    }
    @objc func didButtonSettingsTapped(sender: UIButton) {
        let settingsViewController = SettingsViewController()
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    @objc func didLogInButtonTapped(sender: UIButton) {
        present(EntranceViewController(), animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 && indexPath.row == 1 {
            let settingsViewController = SettingsViewController()
            navigationController?.pushViewController(settingsViewController, animated: true)
        }
        if indexPath.section == 0 && indexPath.row == 0 {
            let myFeedbackViewController = MyFeedbacksViewController()
            navigationController?.pushViewController(myFeedbackViewController, animated: true)
        }
        if indexPath.section == 1 {
            let alertExitController = UIAlertController(title: "Внимание!", message: "Вы уверены, что хотите выйти из своего профиля?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
            alertExitController.addAction(cancelAction)
            let exitAction = UIAlertAction(title: "Выйти", style: .destructive) {
                UIAlertAction in
                do {
                    try Auth.auth().signOut()
                    
                } catch _ {
                    print("Error of sign out")
                }
            }
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

extension ProfileViewController {
    private func setConstraints() {
        if let user = Auth.auth().currentUser {
            let _ = [
            avatarImage,
            nameOfStudent,
            university,
            faculty,
            cathedra,
            buttonsTable
            ].map({$0.translatesAutoresizingMaskIntoConstraints = false
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true})
            
            avatarImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13.0).isActive = true
            avatarImage.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            avatarImage.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
        
            nameOfStudent.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 15.0).isActive = true
            
            university.topAnchor.constraint(equalTo: nameOfStudent.bottomAnchor, constant: 8.0).isActive = true
            university.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
            
            faculty.topAnchor.constraint(equalTo: university.bottomAnchor, constant: 3.0).isActive = true
            faculty.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
            
            cathedra.topAnchor.constraint(equalTo: faculty.bottomAnchor, constant: 3.0).isActive = true
            cathedra.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
            
            buttonsTable.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1).isActive = true
            buttonsTable.heightAnchor.constraint(equalToConstant: 176.0).isActive = true
            buttonsTable.topAnchor.constraint(equalTo: cathedra.bottomAnchor, constant: 41.0).isActive = true
        }
        else {
            let _ = [
            imageOfRegistration,
            logInButton,
            lableOfRegistration
            ].map({$0.translatesAutoresizingMaskIntoConstraints = false
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true})
            
            imageOfRegistration.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 99).isActive = true
            imageOfRegistration.widthAnchor.constraint(equalToConstant: 243).isActive = true
            imageOfRegistration.heightAnchor.constraint(equalToConstant: 171).isActive = true
            
            lableOfRegistration.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
            lableOfRegistration.topAnchor.constraint(equalTo: imageOfRegistration.bottomAnchor, constant: 10).isActive = true
        
            logInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -27).isActive = true
        }
    }
    
}
