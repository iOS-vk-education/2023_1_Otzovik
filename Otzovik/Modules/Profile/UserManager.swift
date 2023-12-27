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
    
    private let database = Firestore.firestore()
    
    func observeUser(completion: @escaping (Result<User, Error>) -> ()) {
        var user: User?
        let userID: String = Auth.auth().currentUser?.uid ?? ""
        database.collection("Profile").document(userID).addSnapshotListener { snapshot, error in
            if let error {
                completion(.failure(error))
            } else {
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
                        print(user as Any)
                        if let usr = user {
                            completion(.success(usr))}
                    }
                }
            }
        }
    }
}
    
