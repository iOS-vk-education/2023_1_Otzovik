//
//  FavoritesViewController.swift
//  Otzovik
//
//  Created by Leonid Perlin on 10/22/23.
//

import Foundation
import UIKit

class FavoritesViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private var teachers: [Teacher] = []
    private let teacherManager = TeacherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "FavoritesTableViewCell")
        loadData()
        view.addSubview(tableView)
    }
    
    func loadData() {
        teacherManager.loadTeachers { [weak self] teachers in
            self?.teachers = teachers
            self?.tableView.reloadData()
        }
    }
    
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teachers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath)
        let mainCell = cell as? FavoritesTableViewCell
        
        mainCell?.configure(with: teachers[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print(sourceIndexPath, destinationIndexPath)
        let sourceProduct = teachers[sourceIndexPath.row]
        teachers.remove(at: sourceIndexPath.row)
        teachers.insert(sourceProduct, at: destinationIndexPath.row)
    }
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        
        teachers.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
}
