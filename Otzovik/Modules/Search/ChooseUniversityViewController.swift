//
//  ChooseUniversityViewController.swift
//  Otzovik
//
//  Created by Сергей Мирошниченко on 17.11.2023.
//

import UIKit

final class ChooseUniversityViewController: UIViewController{
    
    private var UniversityList: UITableView = {
        let List = UITableView()
        return List
        
    }()
    let universityTable = UITableView.init(frame: CGRect.zero, style: .grouped)
    
    
    private var allUniversities: [University] = []
    private let universityManager = Manager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .systemGroupedBackground
        self.navigationItem.title = "Выберите университет"
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapCloseButton))
        navigationItem.setRightBarButton(closeButton, animated: true)
        view.addSubview(universityTable)
        universityTable.frame = view.bounds
        universityTable.layer.cornerRadius = 10.0
        universityTable.dataSource = self
        universityTable.delegate = self
        
        universityTable.register(UniversityCell.self, forCellReuseIdentifier: "UniversityCell")
        
        loadData()
        print(allUniversities)
        
    }
    func loadData(){
        universityManager.loadUniversities{ [weak self] allUniversities in
            self?.allUniversities = allUniversities
            self?.universityTable.reloadData()
        }
    }
    
    @objc
    private func didTapCloseButton(){
        dismiss(animated: true)
    }
}

extension ChooseUniversityViewController: UITableViewDelegate{
    
    
}

extension ChooseUniversityViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = universityTable.dequeueReusableCell(withIdentifier: "UniversityCell", for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        configuration.text = allUniversities[indexPath.row].abbreviation
        configuration.secondaryText = allUniversities[indexPath.row].fullName
        cell.contentConfiguration = configuration
        if configuration.text == "МГТУ им. Н.Э. Баумана"{
            cell.accessoryType = .checkmark
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUniversities.count
    }
}

final class UniversityCell: UITableViewCell{
    
}
    
