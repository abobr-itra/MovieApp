import Swinject

class NetworkParserAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(NetworkPaserProtocol.self) { _ in NetworkParser() }
    }
}
