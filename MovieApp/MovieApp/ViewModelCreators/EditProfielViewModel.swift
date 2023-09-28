import Foundation
import Swinject

class EditProfileViewModelCreator: ViewModelCreatorProtocol {

    typealias ViewModel = EditProfileViewModel
    
    private unowned let coordinator: EditProfileCoordinatorProtocol
    private var dependencyManager: DependencyManager
    
    init(coordinator: EditProfileCoordinatorProtocol, dependencyManager: DependencyManager) {
        self.coordinator = coordinator
        self.dependencyManager = dependencyManager
    }
    
    func factoryMethod() -> EditProfileViewModel {
        let authService = dependencyManager.resolver.resolve(AuthServiceProtocol.self)!
        let remoteDBService = dependencyManager.resolver.resolve(DataBaseServiceProtocol.self)!
        return EditProfileViewModel(authService: authService, databaseService: remoteDBService)
    }
}
