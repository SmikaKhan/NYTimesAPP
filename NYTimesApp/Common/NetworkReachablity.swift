//
//  NetworkReachablity.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 01/02/2025.
//

import Network
protocol NetworkReachablityProtocol {
    var isReachable: Bool { get }
    func startMonitoring(completion: @escaping (Bool) -> Void)
    func stopMonitoring()
}

class NetworkReachablity: NetworkReachablityProtocol {
    private let monitor = NWPathMonitor()
    private var isMonitoring = false
    private(set) var isReachable: Bool = true
    
    func startMonitoring(completion: @escaping (Bool) -> Void) {
        guard !isMonitoring else { return }
        
        monitor.pathUpdateHandler = { [weak self] path in
            let isReachable = path.status == .satisfied
            self?.isReachable = isReachable
            
            DispatchQueue.main.async {
                completion(isReachable)
            }
        }
        
        let queue = DispatchQueue(label: "NetworkReachablity")
        monitor.start(queue: queue)
        isMonitoring = true
    }
    
    func stopMonitoring() {
        guard isMonitoring else { return }
        monitor.cancel()
        isMonitoring = false
    }
}
