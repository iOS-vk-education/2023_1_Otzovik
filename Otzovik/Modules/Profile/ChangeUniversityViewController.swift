//
//  ChangeUniversityViewController.swift
//  Otzovik
//
//  Created by Александр Денисов on 28.12.2023.
//

import UIKit

protocol ChangeUniversityViewControllerDelegate {
    func setStartCheckmark()
    func recieveChoosenOption()
}

final class ChangeUniversityViewController: UIViewController {
    
    private let userManager = UserManager()
    private var user_: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBeginningValueInTableView()
        
    }
    
    private func setBeginningValueInTableView() {
        var beginningUniversity: String?
        userManager.getUser { [weak self] result in
            switch result {
                case .success(let user):
                    guard let self else {return}
                    user_ = user
                    if let usr = user_ {
                        beginningUniversity = usr.university
                        if let startPoint = beginningUniversity {
                            
                        }
                    }
                    break
                case .failure(let error):
                    print(error)
                    break
            }
        }
    }
}
