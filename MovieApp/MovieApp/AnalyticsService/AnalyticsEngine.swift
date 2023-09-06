import Foundation
import Firebase
import FirebaseAnalytics

class AnalyticsEngine: AnalyticsEngineProtocol {

    func sendAnalyticsEvent(named name: String, metadata: [String : String]) {
        Analytics.logEvent(name, parameters: metadata)
        // Call any other analytics services here
    }
}
