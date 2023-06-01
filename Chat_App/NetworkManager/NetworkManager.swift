//
//  NetworkMonitor.swift
//  Chat_App
//
//  Created by Ana Dzamelashvili on 5/30/23.
//

import Foundation
import Network

final class NetworkManager {
    ///Continuesly checking internet connection verytime it changes
    static let shared = NetworkManager()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    ///public for anybody to read but only this class can update its value
    public private(set) var isConnected: Bool = true
    
    private init() {
      monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else {return}
            self.isConnected = path.status == .satisfied
            print(self.isConnected)
        }

    }
    
}
