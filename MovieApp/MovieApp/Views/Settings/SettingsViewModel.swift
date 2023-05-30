import Foundation
import UIKit

protocol SettingsViewModelProtocol {
  func sectionsCount() -> Int
  func optionsCount(section: Int) -> Int
  func option(at index: Int, section: Int) -> SettingsOption
  func sectionTitle(for index: Int) -> String
}

class SettingViewModel: SettingsViewModelProtocol {
  
  // MARK: - Properties
  
  private(set) var settingsOptions: [SettingsSection] = [
    SettingsSection(title: "Basic", options: [
      SettingsOption(title: "Apperance",
                     icon: UIImage(systemName: "paintbrush"),
                     iconBackgroundColor: .systemBlue,
                     handler: {
                       // TODO: Implement openApperance: method from coordinator
                     }
                    ),
      SettingsOption(title: "App Icon",
                     icon: UIImage(systemName: "photo.circle"),
                     iconBackgroundColor: .systemMint,
                     handler: {
                       // TODO: Implement openAppIcon: method from coordinator
                     }),
      SettingsOption(title: "App Language",
                     icon: UIImage(systemName: "character.bubble"),
                     iconBackgroundColor: .systemTeal,
                     handler: {
                       // TODO: Implement openAppLanguage: method from coordinator
                     })]
                   )
  ]
  
  // MARK: - Public
  
  func sectionsCount() -> Int {
    settingsOptions.count
  }
  
  func optionsCount(section: Int) -> Int {
    settingsOptions[section].options.count
  }
  
  func option(at index: Int, section: Int) -> SettingsOption {
    settingsOptions[section].options[index]
  }
  
  func sectionTitle(for index: Int) -> String {
    settingsOptions[index].title
  }
}
