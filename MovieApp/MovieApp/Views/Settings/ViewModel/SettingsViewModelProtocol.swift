import Foundation

protocol SettingsViewModelProtocol {
    
    var languages: [Language] { get set }
    var currentLanguage: Language? { get }
    
    func sectionsCount() -> Int
    func optionsCount(section: Int) -> Int
    func option(at index: Int, section: Int) -> SettingsOption
    func sectionTitle(for index: Int) -> String
}
