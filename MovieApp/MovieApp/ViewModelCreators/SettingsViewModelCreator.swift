import Foundation

class SettingsViewModelCreator: ViewModelCreatorProtocol {
    
    typealias ViewModel = SettingViewModel
    
    func factoryMethod(parser: NetworkPaserProtocol) -> SettingViewModel {
        SettingViewModel()
    }
}
