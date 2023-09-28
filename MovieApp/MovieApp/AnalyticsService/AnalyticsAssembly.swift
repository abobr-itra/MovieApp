import Foundation
import Swinject

class AnalyticsServiceAssembly: Assembly {

    func assemble(container: Swinject.Container) {
        container.register(AnalyticsEngineProtocol.self) { _ in AnalyticsEngine() }
        container.register(AnalyticsManager.self) { r in
            AnalyticsManager(engine: r.resolve(AnalyticsEngineProtocol.self)!)
        }
    }
}
