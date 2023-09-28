import Swinject
import RealmSwift

class RealmServiceAssembly: Assembly {

    func assemble(container: Container) {
        container.register(Realm.Configuration.self) { _ in Realm.Configuration() }
        container.register(Realm.self) { r in
            try! Realm(configuration: r.resolve(Realm.Configuration.self)!)
        }
        container.register(RealmServiceProtocol.self) { r in
            RealmService(realm: r.resolve(Realm.self)!)
        }
    }
}
