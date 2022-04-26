//
//  FirebaseFirestoreStorage.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 17/09/21.
//

import Foundation
import RxSwift
import Firebase
import FirebaseFirestoreSwift

public final class FirebaseFirestoreStorage {
    
    static let shared = FirebaseFirestoreStorage()
    
    public enum Collection: String {
        case users = "users"
        case requestDocumentPool = "request_document_pool"
    }
    
    let db = Firestore.firestore()
    
    func setData<T: Encodable>(_ data: T, to collection: Collection, completion: @escaping(Result<T, Error>) -> Void){
        do {
            try self.db.collection(collection.rawValue).document().setData(from: data)
            completion(.success(data))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func setData<T: Encodable>(_ data: T, withDocumentPath documentPath: String, to collection: Collection, completion: @escaping(Result<T, Error>) -> Void){
        do {
            try self.db.collection(collection.rawValue).document(documentPath).setData(from: data)
            completion(.success(data))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func updateData(_ data: [String: Any], withDocumentPath documentPath: String, to collection: Collection, completion: @escaping(Error?) -> Void){
        self.db.collection(collection.rawValue).document(documentPath).updateData(data, completion: completion)
    }
    
    func fetchCollections(from collection: Collection, completion: @escaping(Result<CollectionReference, Error>) -> Void) {
        let collections = db.collection(collection.rawValue)
        completion(.success(collections))
    }
    
    
}
