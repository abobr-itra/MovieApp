import Foundation

protocol AnalyticsEngineProtocol {
    
    func sendAnalyticsEvent(named name: String, metadata: [String: String])
}
