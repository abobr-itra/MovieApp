import UIKit
import FirebaseCore
import Swinject
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        registerDependencies()
        return true
    }
    
    // MARK: - UISceneSession Lifecycle
    
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    // MARK: - Private
    
    private func registerDependencies() {
        Container.shared.register(NetworkPaserProtocol.self) { _ in NetworkParser() }
        Container.shared.register(NetworkServiceProtocol.self) { r in
            NetworkService(parser: r.resolve(NetworkPaserProtocol.self)!)
        }
        Container.shared.register(MovieServiceProtocol.self) { r in
            MovieService(networkService: r.resolve(NetworkServiceProtocol.self)!)
        }
        Container.shared.register(AuthServiceProtocol.self) { _ in AuthService() }
        Container.shared.register(KeychainServiceProtocol.self) { _ in KeychainService() }
        Container.shared.register(KeychainServiceProtocol.self) { _, keyPrefix in
            KeychainService(keyPrefix: keyPrefix)
        }
        
        Container.shared.register(Realm.Configuration.self) { _ in
            Realm.Configuration()
        }
        Container.shared.register(Realm.self) { r in
            try! Realm(configuration: r.resolve(Realm.Configuration.self)!)
        }
        Container.shared.register(RealmServiceProtocol.self) { r in
            RealmService(realm: r.resolve(Realm.self)!)
        }
        
        Container.shared.register(DataBaseServiceProtocol.self) { _ in FirebaseDBService() }
    }
}
