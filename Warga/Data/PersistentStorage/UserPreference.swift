//
//  UserPreference.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 20/09/21.
//

import Foundation

public final class UserPreference {
    
    public enum UserPreferenceKey: String {
        case signUpData = "SignUpDataUserDefault"
        case showInMap = "ShowInMapUserDefault"
        case allowNotification = "AllowNotificationUserDefault"
        case currentProfile = "CurrentProfileUserDefault"
        case appLaunchPermission = "AppLaunchPermissionUserDefault"
    }
    
    static let shared = UserPreference()
    
    private var jsonDecoder = JSONDecoder()
    private var jsonEncoder = JSONEncoder()
    private var storage: UserDefaults {
        return UserDefaults.standard
    }
    
    public func setObject<T: Encodable>(_ object: T, for key: UserPreferenceKey) {
        do {
            let encodedObject = try self.jsonEncoder.encode(object)
            self.storage.setValue(encodedObject, forKey: key.rawValue)
        } catch let error {
            print(error)
        }
    }
    
    public func getObject<T: Decodable>(withType type: T.Type, for key: UserPreferenceKey) -> T? {
        do {
            guard let data = self.storage.data(forKey: key.rawValue) else { return nil }
            let encodedObject = try self.jsonDecoder.decode(T.self, from: data)
            return encodedObject
        } catch {
            return nil
        }
    }
    
    public func setValue(_ value: Any, for key: UserPreferenceKey) {
        self.storage.setValue(value, forKey: key.rawValue)
    }
    
    public func getValue(for key: UserPreferenceKey) -> Any? {
        return self.storage.value(forKey: key.rawValue)
    }
    
    public func removeValue(for key: UserPreferenceKey) {
        self.storage.removeObject(forKey: key.rawValue)
    }
    
}

extension UserPreference {
    
    var doneAppLaunchPermission: Bool {
        set {
            self.setValue(newValue, for: .appLaunchPermission)
        }
        get {
            return self.getValue(for: .appLaunchPermission) as? Bool ?? false
        }
    }
    
    var currentProfile: ProfileDTO? {
        set {
            self.setObject(newValue, for: .currentProfile)
        }
        get {
            return self.getObject(withType: ProfileDTO.self, for: .currentProfile)
        }
    }
    
    var signUpData: ProfileDTO? {
        set {
            self.setObject(newValue, for: .signUpData)
        }
        get {
            return self.getObject(withType: ProfileDTO.self, for: .signUpData)
        }
    }
    
    var showInMap: Bool {
        set {
            self.setValue(newValue, for: .showInMap)
        }
        get {
            return self.getValue(for: .showInMap) as? Bool ?? true
        }
    }
    
    var allowNotification: Bool {
        set {
            self.setValue(newValue, for: .allowNotification)
        }
        get {
            return self.getValue(for: .allowNotification) as? Bool ?? true
        }
    }
    
}
