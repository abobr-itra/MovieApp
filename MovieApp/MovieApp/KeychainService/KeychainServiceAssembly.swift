import Swinject

class KeychainServiceAssembly: Assembly {

    func assemble(container: Container) {
        container.register(KeychainServiceProtocol.self) { _ in KeychainService() }
    }
}
