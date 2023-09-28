import Swinject

class AuthServiceAssembly: Assembly {

    func assemble(container: Container) {
        container.register(AuthServiceProtocol.self) { _ in AuthService() }
    }
}
