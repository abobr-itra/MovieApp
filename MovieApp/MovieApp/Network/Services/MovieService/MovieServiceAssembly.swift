import Swinject

class MovieServiceAssembly: Assembly {

    func assemble(container: Container) {
        container.register(MovieServiceProtocol.self) { r in
            MovieService(networkService: r.resolve(NetworkServiceProtocol.self)!)
        }
    }
}
