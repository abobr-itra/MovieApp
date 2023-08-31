import UIKit

class SettingsCoordinator: SettingsCoordinatorProtocol {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    private var viewModel: SettingsViewModelProtocol {
        let viewModelCreator = SettingsViewModelCreator(coordinator: self)
        let viewModel = viewModelCreator.factoryMethod(parser: NetworkParser())
        return viewModel
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public
    
    func start() {
        let viewController = SettingsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    // MARK: - SettingsCoordinatorProtocol
    
    func openLanguages() {
        let viewController = SettingsLanguagesViewController()
        viewController.data = .init(languages: viewModel.languages,
                                    currentLanguage: viewModel.currentLanguage ?? .english)
        viewController.actions = .init(select: { language, completion in
            Bundle.setLanguage(lang: language.rawValue)
            completion(.success(()))
        })
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func openApperance() {
        let viewController = ApperanceViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func openAccount() {
        let keychainService = KeychainService()
        if let _ = keychainService.get(Constants.KeychainKeys.userID) {
            print("💩")
            let profileCoordinator = EditProfileCoordinator(navigationController: navigationController)
            profileCoordinator.start()
        } else {
            print("💩💩")
            let authCoordinator = AuthCoordinator(navigationController: navigationController)
            authCoordinator.start()
        }
    }
}
