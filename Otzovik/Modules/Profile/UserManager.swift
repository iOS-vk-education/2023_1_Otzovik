//
//  UserManager.swift
//  Otzovik
//
//  Created by Александр Денисов on 08.12.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Firebase


final class UserManager {
    
    private lazy var userID: String = Auth.auth().currentUser?.uid ?? ""
    private let database = Firestore.firestore()
    
    func getUserFromDict(completion: @escaping ((User) -> Void)){
        var user: User?
        self.database.collection("Profile").document(self.userID).getDocument(completion: { snapshot, error in
            if let _ = error {return}
            else {
                if let snap = snapshot {
                    let data = snap.data()
                    if let dat = data {
                        let name = dat["name"] as! String
                        let faculty = dat["faculty"] as! String
                        let chair = dat["chair"] as! String
                        var profileImageName = dat["profileImageName"] as! String
                        if profileImageName == "" {
                            profileImageName = "defaultProfileImage"
                        }
                        let university = dat["university"] as! String
                        user = User(name: name, profileImageName: profileImageName, university: university, faculty: faculty, cathedra: chair)
                        print(user)
                        if let usr = user {
                            completion(usr)}
                    }
                }
            }
        })
    }
}
    
