import Foundation
import Swinject

class EditProfileViewModelCreator: ViewModelCreatorProtocol {

    typealias ViewModel = EditProfileViewModel
    
    private unowned let coordinator: EditProfileCoordinatorProtocol
    
    init(coordinator: EditProfileCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func factoryMethod() -> EditProfileViewModel {
        let authService = Container.shared.resolve(AuthServiceProtocol.self)!
        let remoteDBService = Container.shared.resolve(DataBaseServiceProtocol.self)!
        return EditProfileViewModel(authService: authService, databaseService: remoteDBService)
    }
}
