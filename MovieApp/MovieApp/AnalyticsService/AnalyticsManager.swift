import Foundation

class AnalyticsManager {
    
    // MARK: - Properties
    
    private let engine: AnalyticsEngineProtocol
    
    init(engine: AnalyticsEngineProtocol) {
        self.engine = engine
    }
    
    // MARK: - Public
    
    func log(_ event: AnalyticsEvent) {
        engine.sendAnalyticsEvent(named: event.name, metadata: event.metadata)
    }
}
