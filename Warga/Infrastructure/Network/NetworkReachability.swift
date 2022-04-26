//
//  NetworkReachability.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 21/10/21.
//

import Foundation
import Reachability

public final class NetworkReachability {
    
    static var shared = NetworkReachability()
    
    private let reachability = try! Reachability()
    
    public var whenReachable: ((_ reachability: Reachability) -> Void)?
    public var whenUnreachable: ((_ reachability: Reachability) -> Void)?
    public var connectionStatus: Reachability.Connection = .unavailable
    
    func startNotifier() {
        do {
            try self.reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
        self.reachability.whenReachable = { [unowned self] reachability in
            self.connectionStatus = reachability.connection
            self.whenReachable?(reachability)
        }
        
        self.reachability.whenUnreachable = { [unowned self] reachability in
            self.connectionStatus = reachability.connection
            self.whenUnreachable?(reachability)
        }
        
    }
    
    func removeNotifier() {
        self.reachability.stopNotifier()
    }
    
    
}
