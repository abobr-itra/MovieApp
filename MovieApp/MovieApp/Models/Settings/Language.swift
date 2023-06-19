import Foundation

enum Language: String, Codable {
  
  case english = "en"
  case russian = "ru"
  case polish = "pl"
  
  var localName: String? {
      Locale(identifier: rawValue).localizedString(forLanguageCode: rawValue)
  }
}
