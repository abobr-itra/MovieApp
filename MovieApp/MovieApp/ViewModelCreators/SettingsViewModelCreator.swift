import Foundation

class SettingsViewModelCreator: ViewModelCreatorProtocol {
    
    typealias ViewModel = SettingViewModel
    
    private unowned let coordinator: SettingsCoordinatorProtocol
    
    init(coordinator: SettingsCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    func factoryMethod() -> SettingViewModel {
        SettingViewModel(coordinator: coordinator)
    }
}
