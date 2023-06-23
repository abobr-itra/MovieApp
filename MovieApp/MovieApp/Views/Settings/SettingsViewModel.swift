import Foundation
import UIKit

protocol SettingsViewModelProtocol {
  
  var languages: [Language] { get set }
  var currentLanguage: Language? { get }

  func sectionsCount() -> Int
  func optionsCount(section: Int) -> Int
  func option(at index: Int, section: Int) -> SettingsOption
  func sectionTitle(for index: Int) -> String
}

class SettingViewModel: SettingsViewModelProtocol {
  
  // MARK: - Properties
  
  lazy private var settingsOptions: [SettingsSection] = [
    SettingsSection(title: "Basic".localized(), options: [
      SettingsOption(title: "Apperance".localized(),
                     icon: UIImage(systemName: "paintbrush"),
                     iconBackgroundColor: .systemBlue,
                     handler: {
                       self.actions.openApperance()
                     }),
      SettingsOption(title: "App Icon".localized(),
                     icon: UIImage(systemName: "photo.circle"),
                     iconBackgroundColor: .systemMint,
                     handler: {
                       // TODO: Implement openAppIcon: method from coordinator
                     }),
      SettingsOption(title: "App Language".localized(),
                     icon: UIImage(systemName: "character.bubble"),
                     iconBackgroundColor: .systemTeal,
                     handler: {
                       self.actions.openLanguages()
                     })
    ]),
    SettingsSection(title: "Privacy".localized(), options: [
      SettingsOption(title: "Terms of Service".localized(),
                     icon: UIImage(systemName: "eye"),
                     iconBackgroundColor: .red,
                     handler: {
                       // TODO: Implement openApperance: method from coordinator
                     }),
      SettingsOption(title: "Privacy Policy & Analytics".localized(),
                     icon: UIImage(systemName: "lock"),
                     iconBackgroundColor: .black,
                     handler: {
                       // TODO: Implement openAppIcon: method from coordinator
                     }),
    ])
  ]
  
  struct Actions {
    var openLanguages: () -> ()
    var openApperance: () -> ()
  }
  
  var actions: Actions!
  
  var languages: [Language] = [.english, .polish, .russian]
  var currentLanguage: Language? {
    let locale = Locale.current.language.languageCode?.identifier ?? "en"
    return Language(rawValue: locale)
  }
  
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
