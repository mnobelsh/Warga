//
//  FirebaseService.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 06/02/22.
//

import Foundation
import Firebase
import FirebaseAuth

public final class FirebaseService {
    
    public static let shared = FirebaseService()
    private let auth = Auth.auth()
    
    
    public func registerUser(withEmail email: String, andPassword password: String, completion: @escaping(AuthDataResult?, Error?) -> Void) {
        self.auth.createUser(withEmail: email, password: password, completion: completion)
    }
    
    public func signIn(withEmail email: String, andPassword password: String, completion: @escaping(AuthDataResult?, Error?) -> Void) {
        self.auth.signIn(withEmail: email, password: password, completion: completion)
    }
    
    public func signOut(completion: @escaping(Error?) -> Void) {
        do {
            try self.auth.signOut()
            completion(nil)
        } catch let error as NSError {
            completion(error)
        }
        
    }
    
}
