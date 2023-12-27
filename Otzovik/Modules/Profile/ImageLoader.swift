//
//  ImageLoader.swift
//  Otzovik
//
//  Created by Александр Денисов on 27.12.2023.
//

import UIKit
import FirebaseStorage

protocol ImageLoaderDescription {
    func upload(image: UIImage, completion: @escaping(Result<String, Error>) -> Void)
    func image(with name: String, completion: @escaping(Result<UIImage, Error>) -> Void)
}

enum ImageLoaderError: Error {
    case invalidImageData
}

final class ImageLoader: ImageLoaderDescription {
    static let shared: ImageLoaderDescription = ImageLoader()
    
    private let storage = Storage.storage().reference()
    
    private var imageCache: [String: UIImage] = [:]
    
    private init() {}
    
    func upload(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let data = image.jpegData(compressionQuality: 0.5) else {
            completion(.failure(ImageLoaderError.invalidImageData))
            return
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let name = UUID().uuidString
        
        storage.child(name).putData(data, metadata: metadata) { [weak self] _, error in
            if let error {
                completion(.failure(error))
            } else {
                self?.imageCache[name] = UIImage(data: data)
                completion(.success(name))
            }
        }
    }
    
    func image(with name: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let image = imageCache[name] {
            completion(.success(image))
            return
        }
        
        storage.child(name).getData(maxSize: 15 * 1024 * 1024) { [weak self] data, error in
            if let error {
                completion(.failure(error))
            } else if let data = data, let image = UIImage(data: data) {
                self?.imageCache[name] = image
                completion(.success(image))
            } else {
                completion(.failure(ImageLoaderError.invalidImageData))
            }
        }
    }
}

