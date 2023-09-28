import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: AppCoordinatior?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let dependencyManager = DependencyManager()
        dependencyManager.setup()
        coordinator = AppCoordinatior(window: window, dependecyManager: dependencyManager)
        coordinator?.start()
    }
}
