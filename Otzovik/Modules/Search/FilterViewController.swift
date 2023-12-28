//
//  FilterViewController.swift
//  Otzovik
//
//  Created by Сергей Мирошниченко on 26.11.2023.
//

import UIKit

protocol SendFiltersToSearchDelegate: AnyObject{
    func sendfilters(_ filters: [String])
}

class FilterViewController: UIViewController{
    weak var filterDelegate: SendFiltersToSearchDelegate?
    
    private var alreadySaveParametrs = false
    private var choosenFilters: [String] = []
    var isUniversityChanged: Bool?
    var currentUniversity: String?
    var isCalledFromRegistration = false
    private var selectedIndexPaths: [IndexPath] = []
    private var newSelectedCells: [IndexPath] = []
    private let universityManager = Manager()
    private var allUniversities: [University] = []
    private let facultyManager = Manager()
    private var allDepartments: [String] = []
    
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
        label.text = "Выберете одну или несколько кафедр"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .medium)
        
        return label
    }()
    
    deinit{
        if !alreadySaveParametrs{
            if let encodedData = try? PropertyListEncoder().encode(selectedIndexPaths) {
                UserDefaults.standard.set(encodedData, forKey: "selectedCells")
                
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let headerContainerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        let bottomContainerView = UIView()
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: doneCustomButton), animated: false)
        view.backgroundColor = .systemGroupedBackground
        facultyTable.translatesAutoresizingMaskIntoConstraints = false
        facultyTable.tableHeaderView = headerContainerView
        facultyTable.allowsMultipleSelection = true
        
        view.addSubview(facultyTable)
        if isCalledFromRegistration{
            title = "Выберете кафедру:"
            facultyLabel.text = ""
        }
        else{
            title = "Фильтры"
        }
        
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
            facultyLabel.centerXAnchor.constraint(equalTo: headerContainerView.centerXAnchor),
            facultyLabel.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor)
        ])
        loadDepartments()
        facultyTable.dataSource = self
        facultyTable.delegate = self
        
        facultyTable.register(FacultyCell.self, forCellReuseIdentifier: "FacultyCell")
    
        let isChanged = isUniversityChanged ?? false
        if isChanged{
            selectedIndexPaths = []
        }
        else{
        if let savedData = UserDefaults.standard.data(forKey: "selectedCells"),
           let loadedArray = try? PropertyListDecoder().decode([IndexPath].self, from: savedData) {
            selectedIndexPaths = loadedArray
            newSelectedCells = loadedArray
        }
        }
    }
    
    func loadDepartments(){
        let unwrappedUniversityName = currentUniversity ?? "МГТУ им. Баумана"
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
            universityManager.loadUniversities{result in
                switch result {
                case .success(let universities):
                    self.allUniversities = universities
                    
                    for university in self.allUniversities{
                        if university.name == unwrappedUniversityName{
                            for department in university.departments {
                                self.allDepartments.append(department.name)
                            }
                        }
                    }
                case .failure(_):
                    return
                }
            }
        }
        self.facultyTable.reloadData()
    }
    
    @objc
    func goBack(){
        choosenFilters = []
        if newSelectedCells != selectedIndexPaths{
            facultyTable.scrollToRow(at: [0, 0], at: .top, animated: false)
            for indexPath in newSelectedCells{
                if let cell = facultyTable.cellForRow(at: indexPath) {
                    if let configuration = cell.contentConfiguration as? UIListContentConfiguration{
                        if let cellText = configuration.text{
                            choosenFilters.append(cellText)
                        }
                    }
                }
            }
            filterDelegate?.sendfilters(choosenFilters)
        }
        alreadySaveParametrs = true
        if let encodedData = try? PropertyListEncoder().encode(newSelectedCells) {
            UserDefaults.standard.set(encodedData, forKey: "selectedCells")
        }
        navigationController?.popViewController(animated: true)
        dismiss(animated: true)
    }
}
extension FilterViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isCalledFromRegistration{
            facultyTable.deselectRow(at: indexPath, animated: true)
            for cellIndex in newSelectedCells{
                let cell = facultyTable.cellForRow(at: cellIndex)
                cell?.accessoryType = .none
            }
            newSelectedCells = []
            newSelectedCells.append(indexPath)
            updateCellAccessoryType(at: indexPath)
        }
        else{
            facultyTable.deselectRow(at: indexPath, animated: true)
            if let index = newSelectedCells.firstIndex(of: indexPath) {
                newSelectedCells.remove(at: index)
            }
            else{
                newSelectedCells.append(indexPath)
            }
            updateCellAccessoryType(at: indexPath)
        }
    }
    
    func updateCellAccessoryType(at indexPath: IndexPath) {
        if let cell = facultyTable.cellForRow(at: indexPath) {
            cell.accessoryType = newSelectedCells.contains(indexPath) ? .checkmark : .none
        }
    }
}

extension FilterViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = facultyTable.dequeueReusableCell(withIdentifier: "FacultyCell", for: indexPath)
        var conf = cell.defaultContentConfiguration()
        conf.text = allDepartments[indexPath.row]
        cell.contentConfiguration = conf
        cell.accessoryType = newSelectedCells.contains(indexPath) ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allDepartments.count
    }
}

final class FacultyCell: UITableViewCell{
    
}
