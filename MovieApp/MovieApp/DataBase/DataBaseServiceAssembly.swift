import Swinject

class DataBaseServiceAssembly: Assembly {

    func assemble(container: Container) {
        container.register(DataBaseServiceProtocol.self) { _ in FirebaseDBService() }
    }
}
