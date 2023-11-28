//
//  FilterViewController.swift
//  Otzovik
//
//  Created by Сергей Мирошниченко on 26.11.2023.
//

import UIKit

final class FilterViewController: UIViewController{
    
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
        label.font = UIFont(name: "ArialHebrew-Light", size: 15)
        
        return label
    }()
    
    private var facultyLabel: UILabel = {
        let label = UILabel()
        label.text = "Факультеты"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "ArialHebrew-Light", size: 17)
        
        return label
    }()
    
    let facultyManager = Manager()
    var allFaculties: [Faculty] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Фильтры"
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: doneCustomButton), animated: false)
        view.backgroundColor = .systemGroupedBackground
        facultyTable.frame = .init(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        view.addSubview(facultyTable)
        view.addSubview(facultyLabel)
        view.addSubview(infoLabel)
        
        doneCustomButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            facultyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            facultyLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 25)
        ])
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 315),
            infoLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 25)
        ])
            
        
        
        facultyTable.dataSource = self
        facultyTable.delegate = self
        
        facultyTable.register(FacultyCell.self, forCellReuseIdentifier: "FacultyCell")
        
        allFaculties = facultyManager.loadFaculties()
        
    }
    
    @objc
    func goBack(){
        navigationController?.popViewController(animated: true)
    }
    
}
extension FilterViewController: UITableViewDelegate{
    
    
}
extension FilterViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = facultyTable.dequeueReusableCell(withIdentifier: "FacultyCell", for: indexPath)
        var conf = cell.defaultContentConfiguration()
        conf.text = allFaculties[indexPath.row].name
        cell.contentConfiguration = conf
        cell.accessoryType = .checkmark
       
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFaculties.count
    }

}

final class FacultyCell: UITableViewCell{
    
}
