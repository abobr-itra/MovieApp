import Foundation

protocol SettingsViewModelProtocol {
    
    var languages: [Language] { get set }
    var currentLanguage: Language? { get }
    var sectionsCount: Int { get }
    
    func optionsCount(in section: Int) -> Int
    func option(at index: Int, section: Int) -> SettingsOption
    func sectionTitle(for index: Int) -> String
}
