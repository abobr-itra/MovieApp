import UIKit

class SettingsCoordinator: CoordinatorProtocol {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    private var viewModel: SettingsViewModelProtocol {
        let viewModelCreator = SettingsViewModelCreator()
        let viewModel = viewModelCreator.factoryMethod(parser: NetworkParser())
        viewModel.actions = .init(
            openAccount: openAccount,
            openApperance: openApperance,
            openLanguages: openLanguages
        )
        return viewModel
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public
    
    func start() {
        let viewController = SettingsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    // MARK: - Private
    
    private func openLanguages() {
        let viewController = SettingsLanguagesViewController()
        viewController.data = .init(languages: viewModel.languages,
                                    currentLanguage: viewModel.currentLanguage ?? .english)
        viewController.actions = .init(select: { language, completion in
            Bundle.setLanguage(lang: language.rawValue)
            completion(.success(()))
        })
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func openApperance() {
        let viewController = ApperanceViewController()
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func openAccount() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        authCoordinator.start()
    }
}
