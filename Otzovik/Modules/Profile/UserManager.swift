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
        if let us = Auth.auth().currentUser {
            let userID: String = us.uid
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
                            if let usr = user {
                                completion(.success(usr))}
                        }
                    }
                }
            }
        }
    }
    
    func updateImage(imageName: String, completion: @escaping (Result<Void, Error>) -> ()) {
        if let us = Auth.auth().currentUser {
            let userID: String = us.uid
            database.collection("Profile").document(userID).getDocument { snapshot, error in
                if let error {
                    completion(.failure(error))
                } else {
                    if let snap = snapshot {
                        snap.reference.updateData([
                            "profileImageName": imageName
                        ])
                    }
                }
            }
        }
    }
    
    func updateName(name: String, completion: @escaping (Result<Void, Error>) -> ()) {
        if let us = Auth.auth().currentUser {
            let userID: String = us.uid
            database.collection("Profile").document(userID).getDocument { snapshot, error in
                if let error {
                    completion(.failure(error))
                } else {
                    if let snap = snapshot {
                        snap.reference.updateData([
                            "name": name
                        ])
                    }
                }
            }
        }
    }
    
    func updateFaculty(faculty: String, completion: @escaping (Result<Void, Error>) -> ()) {
        if let us = Auth.auth().currentUser {
            let userID: String = us.uid
            database.collection("Profile").document(userID).getDocument { snapshot, error in
                if let error {
                    completion(.failure(error))
                } else {
                    if let snap = snapshot {
                        snap.reference.updateData([
                            "faculty": faculty
                        ])
                    }
                }
            }
        }
    }
    
    func updateChair(chair: String, completion: @escaping (Result<Void, Error>) -> ()) {
        if let us = Auth.auth().currentUser {
            let userID: String = us.uid
            database.collection("Profile").document(userID).getDocument { snapshot, error in
                if let error {
                    completion(.failure(error))
                } else {
                    if let snap = snapshot {
                        snap.reference.updateData([
                            "chair": chair
                        ])
                    }
                }
            }
        }
    }
    
    func updateUniversity(university: String, completion: @escaping (Result<Void, Error>) -> ()) {
        if let us = Auth.auth().currentUser {
            let userID: String = us.uid
            database.collection("Profile").document(userID).getDocument { snapshot, error in
                if let error {
                    completion(.failure(error))
                } else {
                    if let snap = snapshot {
                        snap.reference.updateData([
                            "university": university
                        ])
                    }
                }
            }
        }
    }
    
    func getUser(completion: @escaping (Result<User, Error>) -> ()) {
        var user: User?
        if let us = Auth.auth().currentUser {
            let userID: String = us.uid
            database.collection("Profile").document(userID).getDocument { snapshot, error in
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
                            if let usr = user {
                                completion(.success(usr))}
                        }
                    }
                }
            }
        }
    }
}
    
