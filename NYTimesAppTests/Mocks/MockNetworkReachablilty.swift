//
//  MockNetworkReachablilty.swift
//  NYTimesAppTests
//
//  Created by Muhammad Iqbal on 02/02/2025.
//

import Foundation

class MockNetworkReachabilityService: NetworkReachablityProtocol {
    
    var isReachable: Bool = true
    var isMonitorinStarted: Bool = true
    
    func startMonitoring(completion: @escaping (Bool) -> Void) {
        isMonitorinStarted = true
    }
    
    func stopMonitoring() {
        isMonitorinStarted = false
    }
}
