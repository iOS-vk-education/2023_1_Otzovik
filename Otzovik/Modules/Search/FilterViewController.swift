//
//  FilterViewController.swift
//  Otzovik
//
//  Created by Сергей Мирошниченко on 26.11.2023.
//

import UIKit

final class FilterViewController: UIViewController{
    var currentUniversity: String?
    var selectedIndexPaths: [IndexPath] = []
    let universityManager = Manager()
    var allUniversities: [University] = []
    let facultyManager = Manager()
    var allDepartments: [String] = []
    var allFaculties: [Faculty] = []
    let facultyTable = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
    private var doneCustomButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Готово", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        button.addTarget(nil, action: #selector(goBack), for: .touchUpInside)
        
        return button
    }()
    private var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Можете выбрать несколько пунктов"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    private var facultyLabel: UILabel = {
        let label = UILabel()
        label.text = "Факультеты"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
    
    deinit{
        if let encodedData = try? PropertyListEncoder().encode(selectedIndexPaths) {
            UserDefaults.standard.set(encodedData, forKey: "selectedCells")
            
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let headerContainerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        let bottomContainerView = UIView()
        title = "Фильтры"
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: doneCustomButton), animated: false)
        view.backgroundColor = .systemGroupedBackground
        facultyTable.translatesAutoresizingMaskIntoConstraints = false
        facultyTable.tableHeaderView = headerContainerView
        facultyTable.allowsMultipleSelection = true
        
        view.addSubview(facultyTable)
        headerContainerView.addSubview(facultyLabel)
        doneCustomButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            facultyTable.topAnchor.constraint(equalTo: view.topAnchor),
            facultyTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            facultyTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            facultyTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            facultyLabel.topAnchor.constraint(equalTo: headerContainerView.topAnchor),
            facultyLabel.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor, constant: 20),
            facultyLabel.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
            facultyLabel.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor)
        ])
        loadDepartments()
        facultyTable.dataSource = self
        facultyTable.delegate = self
        
        facultyTable.register(FacultyCell.self, forCellReuseIdentifier: "FacultyCell")
        
        
        allFaculties = facultyManager.loadFaculties()
        if let savedData = UserDefaults.standard.data(forKey: "selectedCells"),
           let loadedArray = try? PropertyListDecoder().decode([IndexPath].self, from: savedData) {
            print("Загруженный массив из didload: \(loadedArray)")
            selectedIndexPaths = loadedArray
            print("selected \(selectedIndexPaths)")
        }

    }
    func loadDepartments(){
        let unwrappedUniversityName = currentUniversity ?? "Default"
        if let savedData = UserDefaults.standard.data(forKey: "all_univers"),
           let loadedArray = try? PropertyListDecoder().decode([University].self, from: savedData) {
            self.allUniversities = loadedArray
        }
        if self.allUniversities.count != 0{
            for university in self.allUniversities{
                if university.name == unwrappedUniversityName{
                    for department in university.departments {
                        allDepartments.append(department.name)
                    }
                }
            }
        }
        else{
            universityManager.loadUniversities{
                self.allUniversities = self.universityManager.all_universities
                for university in self.allUniversities{
                    if university.name == unwrappedUniversityName{
                        for department in university.departments {
                            self.allDepartments.append(department.name)
                        }
                    }
                }
            }
        }
        self.facultyTable.reloadData()
        print(allDepartments)
    }
    @objc
    func goBack(){
        navigationController?.popViewController(animated: true)
    }
}
extension FilterViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        facultyTable.deselectRow(at: indexPath, animated: true)
        if let index = selectedIndexPaths.firstIndex(of: indexPath) {
            selectedIndexPaths.remove(at: index)
        }
        else{
            selectedIndexPaths.append(indexPath)
        }
        updateCellAccessoryType(at: indexPath)
    }
    
    func updateCellAccessoryType(at indexPath: IndexPath) {
            if let cell = facultyTable.cellForRow(at: indexPath) {
                cell.accessoryType = selectedIndexPaths.contains(indexPath) ? .checkmark : .none
            }
        }
}

extension FilterViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = facultyTable.dequeueReusableCell(withIdentifier: "FacultyCell", for: indexPath)
        var conf = cell.defaultContentConfiguration()
        //conf.text = allFaculties[indexPath.row].name
        print(indexPath.row)
        print(allDepartments)
        conf.text = allDepartments[indexPath.row]
        print(conf.text)
        cell.contentConfiguration = conf
        cell.accessoryType = selectedIndexPaths.contains(indexPath) ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFaculties.count
    }
}

final class FacultyCell: UITableViewCell{
    
}
