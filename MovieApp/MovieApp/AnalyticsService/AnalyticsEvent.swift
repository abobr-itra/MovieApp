import Foundation

enum AnalyticsEvent {
    
    case signIn(email: String)
    case signUp(email: String)
    case signOut(email: String)
}

extension AnalyticsEvent {
    
    var name: String {
        switch self {
        case .signIn, .signOut, .signUp:
            return String(describing: self)
        }
    }
    
    var metadata: [String: String] {
        switch self {
        case .signIn(let email), .signUp(let email), .signOut(let email):
            return ["user_email": email]
        }
    }
}
