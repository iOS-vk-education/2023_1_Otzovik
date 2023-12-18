//
//  MyFeedbacksViewController.swift
//  Otzovik
//
//  Created by Александр Денисов on 27.11.2023.
//

import UIKit

final class MyFeedbacksViewController: UIViewController, UISearchBarDelegate {
    
    private let tableMyFeedbacks = UITableView()
    private var searchController: UISearchController {
        var searchController_ = UISearchController(searchResultsController: nil)
        searchController_.obscuresBackgroundDuringPresentation = true
        searchController_.searchBar.placeholder = "Поиск"
        searchController_.searchBar.setValue("Отмена", forKey: "cancelButtonText")
        return searchController_
    };
    
    private var feedbacks: [Feedback] = []
    private let feedbackManager = FeedbackManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мои отзывы"
        navigationItem.searchController = searchController
        tableMyFeedbacks.frame = view.bounds
        tableMyFeedbacks.delegate = self
        tableMyFeedbacks.dataSource = self
        tableMyFeedbacks.register(cellFeedback.self, forCellReuseIdentifier: "cellFeedback")
        loadData()
        view.addSubview(tableMyFeedbacks)
    }
    
    private func loadData() {
        feedbackManager.loadFeedbacks() { [weak self] feedbacks_ in
            guard let self else { return }
            feedbacks = feedbacks_
            tableMyFeedbacks.reloadData()
        }
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
