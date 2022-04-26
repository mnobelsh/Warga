//
//  FirestoreRepository.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 17/09/21.
//

import Foundation
import FirebaseFirestore

public protocol FirestoreRepository {
    func save<T: Encodable>(_ data: T, to collection: FirebaseFirestoreStorage.Collection, completion: @escaping ((Result<T, Error>) -> Void))
    func save<T: Encodable>(_ data: T, withDocumentPath documentPath: String, to collection: FirebaseFirestoreStorage.Collection, completion: @escaping ((Result<T, Error>) -> Void))
    func update(_ data: [String: Any], withDocumentPath documentPath: String, to collection: FirebaseFirestoreStorage.Collection, completion: @escaping (Error?) -> Void)
    func fetchDocument<T: Decodable>(withDocumentPath documentPath: String, of type: T.Type, from collection: FirebaseFirestoreStorage.Collection, completion: @escaping ((Result<T?, Error>) -> Void))
    func fetchRealtimeDocument<T: Decodable>(of type: T.Type, from collection: FirebaseFirestoreStorage.Collection, whereField field: String, isEqualTo value: Any, completion: @escaping ((Result<T?, Error>) -> Void))
    func fetchOneTimeDocument<T: Decodable>(of type: T.Type, from collection: FirebaseFirestoreStorage.Collection, whereField field: String, isEqualTo value: Any, completion: @escaping ((Result<T?, Error>) -> Void))
    func fetchRealtimeDocument<T: Decodable>(withDocumentPath documentPath: String, of type: T.Type, from collection: FirebaseFirestoreStorage.Collection, completion: @escaping ((Result<T?, Error>) -> Void)) 
}

public class DefaultFirestoreRepository: FirestoreRepository {
    
    let firestoreStorage: FirebaseFirestoreStorage
    
    init(
        firestoreStorage: FirebaseFirestoreStorage
    ) {
        self.firestoreStorage = firestoreStorage
    }
    
}

extension DefaultFirestoreRepository {
    
    public func save<T: Encodable>(_ data: T, to collection: FirebaseFirestoreStorage.Collection, completion: @escaping ((Result<T, Error>) -> Void)) {
        self.firestoreStorage.setData(data, to: collection, completion: completion)
    }
    public func save<T: Encodable>(_ data: T, withDocumentPath documentPath: String, to collection: FirebaseFirestoreStorage.Collection, completion: @escaping ((Result<T, Error>) -> Void)) {
        self.firestoreStorage.setData(data, withDocumentPath: documentPath, to: collection, completion: completion)
    }
    
    public func update(_ data: [String: Any], withDocumentPath documentPath: String, to collection: FirebaseFirestoreStorage.Collection, completion: @escaping (Error?) -> Void) {
        self.firestoreStorage.updateData(data, withDocumentPath: documentPath, to: collection, completion: completion)
    }
    
    public func fetchDocument<T>(withDocumentPath documentPath: String, of type: T.Type, from collection: FirebaseFirestoreStorage.Collection, completion: @escaping ((Result<T?, Error>) -> Void)) where T : Decodable {
        self.firestoreStorage.fetchCollections(from: collection) { result in
            guard let reference = try? result.get() else {
                let error = NSError(domain: "Unable to get users collection from firestore.", code: 0)
                completion(.failure(error))
                return
            }
            reference.document(documentPath).getDocument { querySnapshot, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    guard let documentSnapshot = querySnapshot else {
                        completion(.success(nil))
                        return
                    }
                    guard let data = try? documentSnapshot.data(as: type.self) else {
                        completion(.success(nil))
                        return
                    }
                    completion(.success(data))
                }
            }
        }
    }
    
    public func fetchRealtimeDocument<T: Decodable>(of type: T.Type, from collection: FirebaseFirestoreStorage.Collection, whereField field: String, isEqualTo value: Any, completion: @escaping ((Result<T?, Error>) -> Void)) {
        self.firestoreStorage.fetchCollections(from: collection) { result in
            guard let reference = try? result.get() else {
                let error = NSError(domain: "Unable to get users collection from firestore.", code: 0)
                completion(.failure(error))
                return
            }
            reference.whereField(field, isEqualTo: value).addSnapshotListener { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    guard let documentSnapshot = snapshot?.documents.first else {
                        completion(.success(nil))
                        return
                    }
                    guard let data = try? documentSnapshot.data(as: type.self) else {
                        completion(.success(nil))
                        return
                    }
                    completion(.success(data))
                }
            }
        }
    }
    
    public func fetchRealtimeDocument<T: Decodable>(withDocumentPath documentPath: String, of type: T.Type, from collection: FirebaseFirestoreStorage.Collection, completion: @escaping ((Result<T?, Error>) -> Void)) {
        self.firestoreStorage.fetchCollections(from: collection) { result in
            guard let reference = try? result.get() else {
                let error = NSError(domain: "Unable to get users collection from firestore.", code: 0)
                completion(.failure(error))
                return
            }
            reference.document(documentPath).addSnapshotListener { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    guard let documentSnapshot = snapshot else {
                        completion(.success(nil))
                        return
                    }
                    guard let data = try? documentSnapshot.data(as: type.self) else {
                        completion(.success(nil))
                        return
                    }
                    completion(.success(data))
                }
            }
        }
    }
    
    public func fetchOneTimeDocument<T>(of type: T.Type, from collection: FirebaseFirestoreStorage.Collection, whereField field: String, isEqualTo value: Any, completion: @escaping ((Result<T?, Error>) -> Void)) where T : Decodable {
        self.firestoreStorage.fetchCollections(from: collection) { result in
            guard let reference = try? result.get() else {
                let error = NSError(domain: "Unable to get users collection from firestore.", code: 0)
                completion(.failure(error))
                return
            }
            reference.whereField(field, isEqualTo: value).getDocuments { querySnapshot, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    guard let documentSnapshot = querySnapshot?.documents.first else {
                        completion(.success(nil))
                        return
                    }
                    guard let data = try? documentSnapshot.data(as: type.self) else {
                        completion(.success(nil))
                        return
                    }
                    completion(.success(data))
                }
            }
        }
    }
    
}
