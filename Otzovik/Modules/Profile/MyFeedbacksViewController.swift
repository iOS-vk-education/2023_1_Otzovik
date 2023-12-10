//
//  MyFeedbacksViewController.swift
//  Otzovik
//
//  Created by Александр Денисов on 27.11.2023.
//

import UIKit

final class MyFeedbacksViewController: UIViewController, UISearchBarDelegate {
    
    private let tableMyFeedbacks = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var feedbacks: [Feedback] = []
    private let feedbackManager = FeedbackManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Мои отзывы"
        
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.setValue("Отмена", forKey: "cancelButtonText")
        navigationItem.searchController = searchController
        
        tableMyFeedbacks.frame = view.bounds
        tableMyFeedbacks.delegate = self
        tableMyFeedbacks.dataSource = self
        tableMyFeedbacks.register(cellFeedback.self, forCellReuseIdentifier: "cellFeedback")
        loadData()
        view.addSubview(tableMyFeedbacks)
    }
    
    func loadData() {
        feedbackManager.loadFeedbacks() { [weak self] feedbacks in
            self?.feedbacks = feedbacks
            self?.tableMyFeedbacks.reloadData()
        }
    }
    @objc private func didTapCloseButton() {
        dismiss(animated: true)
    }
}


extension MyFeedbacksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MyFeedbacksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedbacks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFeedback", for: indexPath)
        let mainCell = cell as! cellFeedback
        mainCell.configure(with: feedbacks[indexPath.row])
        return cell
    }
}
