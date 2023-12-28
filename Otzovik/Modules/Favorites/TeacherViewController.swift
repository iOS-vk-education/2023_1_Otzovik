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
    
    private var isKeyboardUp = false
    
    private lazy var feedbackView: UIView = {
        let v = UIView()
        v.isHidden = true
        v.backgroundColor = .systemBackground
        return v
    }()
    private lazy var sendView: UIView = {
        let v = UIView()
        v.isHidden = true
        v.backgroundColor = .red
        v.backgroundColor = .systemBackground
        return v
    }()
    private lazy var sendLabel: UILabel = {
        let l = UILabel()
        l.isHidden = true
        l.textColor = .systemGray
        l.text = "    Отправить"

        l.font = .systemFont(ofSize: 14)
        return l
    }()
    private lazy var star1ImageView: UIImageView = {
        let iv = UIImageView()
        iv.isHidden = true
        iv.image = UIImage(systemName: "star")
        iv.isUserInteractionEnabled = true
        return iv
    }()
    private lazy var star2ImageView: UIImageView = {
        let iv = UIImageView()
        iv.isHidden = true
        iv.image = UIImage(systemName: "star")
        iv.isUserInteractionEnabled = true
        return iv
    }()
    private lazy var star3ImageView: UIImageView = {
        let iv = UIImageView()
        iv.isHidden = true
        iv.image = UIImage(systemName: "star")
        iv.isUserInteractionEnabled = true
        return iv
    }()
    private lazy var star4ImageView: UIImageView = {
        let iv = UIImageView()
        iv.isHidden = true
        iv.image = UIImage(systemName: "star")
        iv.isUserInteractionEnabled = true
        return iv
    }()
    private lazy var star5ImageView: UIImageView = {
        let iv = UIImageView()
        iv.isHidden = true
        iv.image = UIImage(systemName: "star")
        iv.isUserInteractionEnabled = true
        return iv
    }()
   
    private lazy var textView: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 18)
        tv.text = ""
        tv.backgroundColor = .systemGray
        tv.isScrollEnabled = true
        tv.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        tv.layer.borderColor = CGColor(gray: 0.9, alpha: 0.9)
        tv.layer.borderWidth = 1.0
        tv.layer.cornerRadius = 12
        tv.layer.masksToBounds = true
        tv.isHidden = true
        return tv
    }()
    
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
        button.backgroundColor = .systemGray
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

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
        
        addFeedBackButton.addTarget(self, action: #selector(didAddFeedBackButton), for: .touchUpInside)
        
        feedbackCollectionView.delegate = self
        feedbackCollectionView.dataSource = self
        
        view.addSubview(imageView)
        view.addSubview(fioLabel)
        view.addSubview(degreeLabel)
        view.addSubview(favoritesButton)
        view.addSubview(addFeedBackButton)
        view.addSubview(feedbackCollectionView)
        view.addSubview(textView)
        view.addSubview(feedbackView)
        feedbackView.addSubview(star1ImageView)
        feedbackView.addSubview(star2ImageView)
        feedbackView.addSubview(star3ImageView)
        feedbackView.addSubview(star4ImageView)
        feedbackView.addSubview(star5ImageView)
        feedbackView.addSubview(sendView)
        sendView.addSubview(sendLabel)
        sendView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.sendFeedback(_:))))
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
        
        // MARK: textView
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        // MARK: feedbackView
        feedbackView.translatesAutoresizingMaskIntoConstraints = false
        feedbackView.bottomAnchor.constraint(equalTo: textView.topAnchor, constant: 0).isActive = true
        feedbackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        feedbackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        feedbackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // MARK: stars
        star3ImageView.translatesAutoresizingMaskIntoConstraints = false
        star3ImageView.centerXAnchor.constraint(equalTo: feedbackView.centerXAnchor, constant: 0).isActive = true
        star3ImageView.centerYAnchor.constraint(equalTo: feedbackView.centerYAnchor, constant: 0).isActive = true
        star3ImageView.heightAnchor.constraint(equalTo: feedbackView.heightAnchor, multiplier: 0.8).isActive = true
        star3ImageView.widthAnchor.constraint(equalTo: feedbackView.heightAnchor, multiplier: 0.8).isActive = true
        
        star2ImageView.translatesAutoresizingMaskIntoConstraints = false
        star2ImageView.centerYAnchor.constraint(equalTo: feedbackView.centerYAnchor, constant: 0).isActive = true
        star2ImageView.trailingAnchor.constraint(equalTo: star3ImageView.leadingAnchor, constant: -5).isActive = true
        star2ImageView.heightAnchor.constraint(equalTo: feedbackView.heightAnchor, multiplier: 0.8).isActive = true
        star2ImageView.widthAnchor.constraint(equalTo: feedbackView.heightAnchor, multiplier: 0.8).isActive = true
        
        star1ImageView.translatesAutoresizingMaskIntoConstraints = false
        star1ImageView.centerYAnchor.constraint(equalTo: feedbackView.centerYAnchor, constant: 0).isActive = true
        star1ImageView.trailingAnchor.constraint(equalTo: star2ImageView.leadingAnchor, constant: -5).isActive = true
        star1ImageView.heightAnchor.constraint(equalTo: feedbackView.heightAnchor, multiplier: 0.8).isActive = true
        star1ImageView.widthAnchor.constraint(equalTo: feedbackView.heightAnchor, multiplier: 0.8).isActive = true
        
        star4ImageView.translatesAutoresizingMaskIntoConstraints = false
        star4ImageView.centerYAnchor.constraint(equalTo: feedbackView.centerYAnchor, constant: 0).isActive = true
        star4ImageView.leadingAnchor.constraint(equalTo: star3ImageView.trailingAnchor, constant: 5).isActive = true
        star4ImageView.heightAnchor.constraint(equalTo: feedbackView.heightAnchor, multiplier: 0.8).isActive = true
        star4ImageView.widthAnchor.constraint(equalTo: feedbackView.heightAnchor, multiplier: 0.8).isActive = true
        
        star5ImageView.translatesAutoresizingMaskIntoConstraints = false
        star5ImageView.centerYAnchor.constraint(equalTo: feedbackView.centerYAnchor, constant: 0).isActive = true
        star5ImageView.leadingAnchor.constraint(equalTo: star4ImageView.trailingAnchor, constant: 5).isActive = true
        star5ImageView.heightAnchor.constraint(equalTo: feedbackView.heightAnchor, multiplier: 0.8).isActive = true
        star5ImageView.widthAnchor.constraint(equalTo: feedbackView.heightAnchor, multiplier: 0.8).isActive = true
        
        sendView.translatesAutoresizingMaskIntoConstraints = false
        sendView.centerYAnchor.constraint(equalTo: feedbackView.centerYAnchor, constant: 0).isActive = true
        sendView.leadingAnchor.constraint(equalTo: star5ImageView.trailingAnchor, constant: 5).isActive = true
        sendView.trailingAnchor.constraint(equalTo: feedbackView.trailingAnchor, constant: 0).isActive = true
        sendView.heightAnchor.constraint(equalTo: feedbackView.heightAnchor).isActive = true
        
        sendLabel.translatesAutoresizingMaskIntoConstraints = false
        sendLabel.centerYAnchor.constraint(equalTo: sendView.centerYAnchor, constant: 0).isActive = true
        sendLabel.centerXAnchor.constraint(equalTo: sendView.centerXAnchor, constant: 0).isActive = true
        sendLabel.heightAnchor.constraint(equalTo: sendView.heightAnchor).isActive = true
        sendLabel.widthAnchor.constraint(equalTo: sendView.widthAnchor).isActive = true



    }
    @objc
    private func sendFeedback(_ sender: UITapGestureRecognizer) {
        feedbackView.isHidden = true
        textView.isHidden = true
        star1ImageView.isHidden = true
        star2ImageView.isHidden = true
        star3ImageView.isHidden = true
        star4ImageView.isHidden = true
        star5ImageView.isHidden = true
        sendView.isHidden = true
        sendLabel.isHidden = true
        if textView.isFirstResponder {
            textView.resignFirstResponder()
        }
    }
    @objc
    private func didTapCloseButton() {
        dismiss(animated: true)
    }
    @objc
    private func didAddFeedBackButton() {
        feedbackView.isHidden = false
        textView.isHidden = false
        star1ImageView.isHidden = false
        star2ImageView.isHidden = false
        star3ImageView.isHidden = false
        star4ImageView.isHidden = false
        star5ImageView.isHidden = false
        sendView.isHidden = false
        sendLabel.isHidden = false
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.isKeyboardUp = true
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -keyboardSize.height).isActive = true
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.isKeyboardUp = false
        textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
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
extension TeacherViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
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

