import Foundation

protocol SettingsViewModelProtocol {
  func optionsCount() -> Int
  func option(at index: Int) -> SettingsOption
}

class SettingViewModel: SettingsViewModelProtocol {
  
  private(set) var settingsOptions: [SettingsOption] = []
  
  func optionsCount() -> Int {
    settingsOptions.count
  }
  
  func option(at index: Int) -> SettingsOption {
    settingsOptions[index]
  }
}
