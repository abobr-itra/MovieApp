import Swinject

class NetworkServiceAssembly: Assembly {

    func assemble(container: Container) {
        container.register(NetworkServiceProtocol.self) { r in
            NetworkService(parser: r.resolve(NetworkPaserProtocol.self)!)
        }
    }
}
