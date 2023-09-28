import Foundation
import Swinject

class DependencyManager {

    private let assembler = Assembler()

    var resolver: Resolver {
        assembler.resolver
    }
    
    func setup() {
        assembler.apply(assemblies: [
            NetworkParserAssembly(),
            NetworkServiceAssembly(),
            MovieServiceAssembly(),
            RealmServiceAssembly(),
            AuthServiceAssembly(),
            DataBaseServiceAssembly(),
            KeychainServiceAssembly(),
        ])
    }
}
