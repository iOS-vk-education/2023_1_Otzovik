//
//  TeacherViewController.swift
//  Otzovik
//
//  Created by  Alexander Fedoseev on 28.12.2023.
//

import UIKit

final class TeacherViewController: UIViewController {
    private let teacher: Teacher
    
    private let imageView = UIImageView()
    private let fioLabel = UILabel()
    private let degreeLabel = UILabel()
    private let favoritesButton = UIButton()
    
    private let feedbackCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let addFeedBackButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить отзыв", for: .normal)
        button.backgroundColor = .systemGroupedBackground
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        return button
    }()
    
    let cardData = ["Card 1", "Card 2", "Card 3", "Card 4", "Card 5", "Card 6", "Card 7", "Card 8"]
    
    
    private var favoritesFlag = Bool()

    init(teacher: Teacher) {
        self.teacher = teacher

        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let closeButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCloseButton))
        navigationItem.leftBarButtonItem = closeButton
        
        view.backgroundColor = .systemBackground
        
        
        imageView.contentMode = .scaleAspectFill
        imageView.image = .init(named: "avatar2")
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        
        fioLabel.text = "\(teacher.fio)"
        fioLabel.font = .systemFont(ofSize: 22, weight: .bold)
        fioLabel.numberOfLines = 2
        
        degreeLabel.text = "\(teacher.degree)"
        degreeLabel.font = .systemFont(ofSize: 15, weight: .regular)
        degreeLabel.textColor = .gray
        
        if (favoritesFlag == false) {
            favoritesButton.setTitle("В избранное", for: .normal)
        } else {
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "checkmark")?.withTintColor(.systemBlue)
            imageAttachment.bounds = CGRect(origin: .zero,
                                            size: CGSize(width: (imageAttachment.image?.size.width)! * 0.8,
                                                         height: (imageAttachment.image?.size.height)! * 0.8))
            
            
            let fullString = NSMutableAttributedString(string:  "В избранном ")
            fullString.append(NSAttributedString(attachment: imageAttachment))
            favoritesButton.setAttributedTitle(fullString, for: .normal)
        }
        favoritesButton.setTitleColor(.systemBlue, for: .normal)
        favoritesButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        favoritesButton.contentHorizontalAlignment = .left
        favoritesButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        
        feedbackCollectionView.delegate = self
        feedbackCollectionView.dataSource = self
        
        view.addSubview(imageView)
        view.addSubview(fioLabel)
        view.addSubview(degreeLabel)
        view.addSubview(favoritesButton)
        view.addSubview(addFeedBackButton)
        view.addSubview(feedbackCollectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // MARK: imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 114).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 114).isActive = true
        
        // MARK: fioLabel
        fioLabel.translatesAutoresizingMaskIntoConstraints = false
        fioLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        fioLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 27).isActive = true
        fioLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        
        // MARK: degreeLabel
        degreeLabel.translatesAutoresizingMaskIntoConstraints = false
        degreeLabel.topAnchor.constraint(equalTo: fioLabel.bottomAnchor, constant: 0).isActive = true
        degreeLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 27).isActive = true
        
        // MARK: favoritesButton
        favoritesButton.translatesAutoresizingMaskIntoConstraints = false
        favoritesButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -5).isActive = true
        favoritesButton.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 27).isActive = true
        
        
        // MARK: addFeedBackButton
        addFeedBackButton.translatesAutoresizingMaskIntoConstraints = false
        addFeedBackButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 13).isActive = true
        addFeedBackButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        addFeedBackButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        addFeedBackButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        // MARK: feedbackCollectionView
        feedbackCollectionView.translatesAutoresizingMaskIntoConstraints = false
        feedbackCollectionView.topAnchor.constraint(equalTo: addFeedBackButton.bottomAnchor, constant: 20).isActive = true
        feedbackCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        feedbackCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        feedbackCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc
    private func didTapCloseButton() {
        dismiss(animated: true)
    }
    
    @objc
    private func didTapButton() {
        favoritesFlag.toggle()
        if (favoritesFlag == false) {
            let fullString = NSMutableAttributedString(string: "В избранное")
            favoritesButton.setAttributedTitle(fullString, for: .normal)

        } else {
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "checkmark")?.withTintColor(.systemBlue)
            imageAttachment.bounds = CGRect(origin: .zero,
                                            size: CGSize(width: (imageAttachment.image?.size.width)! * 0.8,
                                                         height: (imageAttachment.image?.size.height)! * 0.8))
            
            
            let fullString = NSMutableAttributedString(string:  "В избранном ")
            fullString.append(NSAttributedString(attachment: imageAttachment))
            favoritesButton.setAttributedTitle(fullString, for: .normal)
        }
    }
}

extension TeacherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardData.count
    }

    @objc
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath)

        return cell
    }
}

extension TeacherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.self.frame.width - 40, height: 84)
    }
}

extension TeacherViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Snap to the nearest cell when scrolling stops
        let layout = feedbackCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}

