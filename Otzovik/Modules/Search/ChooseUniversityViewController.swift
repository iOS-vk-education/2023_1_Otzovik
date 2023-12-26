//
//  ChooseUniversityViewController.swift
//  Otzovik
//
//  Created by Сергей Мирошниченко on 17.11.2023.
//

import UIKit

protocol ReceiveTitleDelegate{
    func receiveTitle(_ title: String)
}


final class ChooseUniversityViewController: UIViewController{
    
    var choosenUniversity: String?
    var delegate: ReceiveTitleDelegate?
    var selectedIndexPaths: [IndexPath] = []
    
    private var UniversityList: UITableView = {
        let List = UITableView()
        return List
        
    }()
    
    let universityTable = UITableView.init(frame: CGRect.zero, style: .grouped)
    
    private var allUniversities: [University] = []
    private let universityManager = Manager()
    
    deinit{
        if let encodedData = try? PropertyListEncoder().encode(selectedIndexPaths) {
            UserDefaults.standard.set(encodedData, forKey: "selectedUniversityPath")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGroupedBackground
        self.navigationItem.title = "Выберите университет"
        
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapCloseButton))
        navigationItem.setRightBarButton(closeButton, animated: true)
        
        view.addSubview(universityTable)
        universityTable.allowsMultipleSelection = false
        universityTable.frame = view.bounds
        universityTable.layer.cornerRadius = 10.0
        universityTable.dataSource = self
        universityTable.delegate = self
        
        universityTable.register(UniversityCell.self, forCellReuseIdentifier: "UniversityCell")
        loadData()
        
        if let savedData = UserDefaults.standard.data(forKey: "selectedUniversityPath"),
           let loadedArray = try? PropertyListDecoder().decode([IndexPath].self, from: savedData) {
            selectedIndexPaths = loadedArray
        }
        if selectedIndexPaths.count == 0{
            selectedIndexPaths = [[0,5]]
        }
    }
    
    func loadData(){
        if let savedData = UserDefaults.standard.data(forKey: "all_univers"),
           let loadedArray = try? PropertyListDecoder().decode([University].self, from: savedData) {
            self.allUniversities = loadedArray
        }
        if self.allUniversities.count != 0{
            self.universityTable.reloadData()
            return
        }
    }
    @objc
    private func didTapCloseButton(){
        dismiss(animated: true)
    }
}

extension ChooseUniversityViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        universityTable.deselectRow(at: indexPath, animated: true)
        for cellIndex in selectedIndexPaths{
            let cell = universityTable.cellForRow(at: cellIndex)
            cell?.accessoryType = .none
        }
        selectedIndexPaths = []
        selectedIndexPaths.append(indexPath)
        updateCellAccessoryType(at: indexPath)
    }
    
    func updateCellAccessoryType(at indexPath: IndexPath) {
        if let cell = universityTable.cellForRow(at: indexPath) {
            cell.accessoryType = selectedIndexPaths.contains(indexPath) ? .checkmark : .none
            delegate?.receiveTitle(allUniversities[indexPath.row].name)
        }
    }
}

extension ChooseUniversityViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = universityTable.dequeueReusableCell(withIdentifier: "UniversityCell", for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        configuration.text = allUniversities[indexPath.row].name
        configuration.secondaryText = allUniversities[indexPath.row].fullName
        cell.contentConfiguration = configuration
        cell.accessoryType = selectedIndexPaths.contains(indexPath) ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUniversities.count
    }
}

final class UniversityCell: UITableViewCell{
    
}
    
