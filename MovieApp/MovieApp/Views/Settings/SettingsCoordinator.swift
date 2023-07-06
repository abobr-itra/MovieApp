import UIKit

class SettingsCoordinator: CoordinatorProtocol {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    private var viewModel: SettingsViewModelProtocol {
        let viewModelCreator = SettingsViewModelCreator()
        let viewModel = viewModelCreator.factoryMethod(parser: NetworkParser())
        viewModel.actions = .init(
            openLanguages: openLanguages,
            openApperance: openApperance
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
            print(language.rawValue)
            Bundle.setLanguage(lang: language.rawValue)
            print(Locale.current.language.languageCode?.identifier)
            completion(.success(()))
        })
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func openApperance() {
        let viewController = ApperanceViewController()
        navigationController.pushViewController(viewController, animated: false)
    }
}
