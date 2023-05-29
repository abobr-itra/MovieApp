import Foundation
import UIKit

protocol SettingsViewModelProtocol {
  func optionsCount() -> Int
  func option(at index: Int) -> SettingsOption
}

class SettingViewModel: SettingsViewModelProtocol {
  
  private(set) var settingsOptions: [SettingsOption] = [
    SettingsOption(title: "First", icon: UIImage(systemName: "star"), iconBackgroundColor: .red, handler: {
      print("First pressed")
    }),
    SettingsOption(title: "Second", icon: UIImage(systemName: "pencil"), iconBackgroundColor: .blue, handler: {
      print("Second pressed")
    })
  ]
  
  func optionsCount() -> Int {
    settingsOptions.count
  }
  
  func option(at index: Int) -> SettingsOption {
    settingsOptions[index]
  }
}
