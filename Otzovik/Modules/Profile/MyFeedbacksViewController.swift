//
//  MyFeedbacksViewController.swift
//  Otzovik
//
//  Created by Александр Денисов on 27.11.2023.
//

import UIKit

final class MyFeedbacksViewController: UIViewController {
    
    private let searchBarMyFeedbacks = UISearchBar()
    private let tableMyFeedbacks = UITableView()
    
    private var feedbacks: [Feedback] = [
        Feedback(name: "АлександроваГалина", 
                 title: "норм препод",
                 content: "Creating a Date and Time in SwiftIn Swift, dates and times are stored in a 64-bit floating point number measuring the number of seconds since the reference date of January 1, 2001 at 00:00:00 UTC. This is expressed in the Date structure. The following would give you the current date and time:",
                 date: DateComponents(year: 2023, month: 11, day: 23)),
        Feedback(name: "Name Surname",
                 title: "Some title",
                 content: "Some content",
                 date: DateComponents(year: 2023, month: 11, day: 23)),
        Feedback(name: "Name Surname",
                 title: "Some title",
                 content: "Some content",
                 date: DateComponents(year: 2023, month: 11, day: 23)),
        Feedback(name: "Name Surname",
                 title: "Some title",
                 content: "Some content",
                 date: DateComponents(year: 2023, month: 11, day: 23)),
        Feedback(name: "Name Surname",
                 title: "Some title",
                 content: "Some content",
                 date: DateComponents(year: 2023, month: 11, day: 23)),
        Feedback(name: "Name Surname",
                 title: "Some title",
                 content: "Some content",
                 date: DateComponents(year: 2023, month: 11, day: 23)),
        Feedback(name: "Name Surname",
                 title: "Some title",
                 content: "Some content",
                 date: DateComponents(year: 2023, month: 11, day: 23)),
        Feedback(name: "Name Surname",
                 title: "Some title",
                 content: "Some content",
                 date: DateComponents(year: 2023, month: 11, day: 23)),
        Feedback(name: "Name Surname",
                 title: "Some title",
                 content: "Some content",
                 date: DateComponents(year: 2023, month: 11, day: 23)),
        Feedback(name: "Name Surname",
                 title: "Some title",
                 content: "Some content",
                 date: DateComponents(year: 2023, month: 11, day: 23)),
        Feedback(name: "Name Surname",
                 title: "Some title",
                 content: "Some content",
                 date: DateComponents(year: 2023, month: 11, day: 23)),
        Feedback(name: "Name Surname",
                 title: "Some title",
                 content: "Some content",
                 date: DateComponents(year: 2023, month: 11, day: 23)),
        Feedback(name: "Name Surname",
                 title: "Some title",
                 content: "Some content",
                 date: DateComponents(year: 2023, month: 11, day: 23)),
        Feedback(name: "Name Surname",
                 title: "Some title",
                 content: "Some content",
                 date: DateComponents(year: 2023, month: 11, day: 23)),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Мои отзывы"
        let buttonBack = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(didTapCloseButton))
        navigationItem.leftBarButtonItem = buttonBack
        
        
        view.addSubview(searchBarMyFeedbacks)
        searchBarMyFeedbacks.translatesAutoresizingMaskIntoConstraints = false
        searchBarMyFeedbacks.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        searchBarMyFeedbacks.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchBarMyFeedbacks.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBarMyFeedbacks.placeholder = "Поиск"
        searchBarMyFeedbacks.searchBarStyle = .minimal
        
        view.addSubview(tableMyFeedbacks)
        tableMyFeedbacks.translatesAutoresizingMaskIntoConstraints = false
        tableMyFeedbacks.topAnchor.constraint(equalTo: searchBarMyFeedbacks.bottomAnchor).isActive = true
        tableMyFeedbacks.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableMyFeedbacks.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableMyFeedbacks.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        tableMyFeedbacks.register(cellFeedback.self, forCellReuseIdentifier: "cellFeedback")
        tableMyFeedbacks.delegate = self
        tableMyFeedbacks.dataSource = self
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

final class cellFeedback: UITableViewCell {
    private let labelName = UILabel()
    private let labelTitle = UILabel()
    private let labelContent = UILabel()
    private let labelDate = UILabel()
    
    private let imageViewFeedback = UIImageView(image: UIImage(systemName: "chevron.right"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(labelName)
        contentView.addSubview(labelTitle)
        contentView.addSubview(labelContent)
        contentView.addSubview(labelDate)
        contentView.addSubview(imageViewFeedback)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let xcoord: CGFloat = 20
        labelName.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        labelName.frame = .init(x: xcoord, y: 8, width: contentView.bounds.width, height: 20)
        labelTitle.font = UIFont(name:"HelveticaNeue-regular", size: 15.0)
        labelTitle.frame = .init(x: xcoord, y: 30, width: contentView.bounds.width, height: 18)
        labelContent.frame = .init(x: xcoord, y: 50, width: contentView.bounds.width - 30, height: 40)
        labelContent.font = UIFont(name:"HelveticaNeue-light", size: 15.0)
        labelContent.numberOfLines = 2
        labelContent.textColor = .gray
        labelContent.textAlignment = .left
        labelContent.sizeToFit()
        labelDate.frame = .init(x: contentView.frame.maxX - 85, y: 8, width: 100, height: 15)
        labelDate.textColor = .gray
        labelDate.font = UIFont(name:"HelveticaNeue", size: 15.0)
        imageViewFeedback.frame = .init(x: contentView.frame.maxX - 20, y: 10, width: 6.5, height: 11)
        imageViewFeedback.tintColor = .gray
    }
    
    func configure(with feedback: Feedback) {
        labelName.text = feedback.name
        labelTitle.text = feedback.title
        labelContent.text = feedback.content
        labelDate.text = "\((feedback.date.year ?? 1900) - 2000).\(feedback.date.month ?? 1).\(feedback.date.day ?? 1)"
    }
}
