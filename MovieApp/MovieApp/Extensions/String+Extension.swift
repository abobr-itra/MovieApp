import Foundation

extension String {

  func prepareForUrl() -> Self {
    self.replacingOccurrences(of: " ", with: "+")
  }
  
  func localized() -> String {
      return NSLocalizedString(self, tableName: nil, bundle: Bundle.localizedBundle(), value: "", comment: "")
  }
  
  func localizeWithFormat(arguments: CVarArg...) -> String{
      return String(format: self.localized(), arguments: arguments)
  }
}
