//
//  ChangeUniversityViewController.swift
//  Otzovik
//
//  Created by Александр Денисов on 28.12.2023.
//

import UIKit

protocol ChangeUniversityViewControllerDelegate {
    func getUniversity() -> [String]
}

final class ChangeUniversityViewController: RegistrationOrganisationViewController {
    
    private let userManager = UserManager()
    private var user_: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setBeginningValueInTableView()
        
    }
    
    override func nextVC() {
        dismiss(animated: true) {
            let str = self.getUniversity()
            self.userManager.updateUniversity(university: str[1]) { [weak self] result in
                switch result {
                    case .success():
                        break
                    case .failure(let error):
                        print(error)
                        break
                }
            }
            self.userManager.updateChair(chair: str[0]) { [weak self] result in
                switch result {
                    case .success():
                        break
                    case .failure(let error):
                        print(error)
                        break
                }
            }
        }
    }
    
//    private func setBeginningValueInTableView() {
//        var beginningUniversity: String?
//        userManager.getUser { [weak self] result in
//            switch result {
//                case .success(let user):
//                    guard let self else {return}
//                    user_ = user
//                    if let usr = user_ {
//                        beginningUniversity = usr.university
//                        if let startPoint = beginningUniversity {
//                            
//                        }
//                    }
//                    break
//                case .failure(let error):
//                    print(error)
//                    break
//            }
//        }
//    }
}
