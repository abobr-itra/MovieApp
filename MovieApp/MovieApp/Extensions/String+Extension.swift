import Foundation

extension String {
    
    func prepareForUrl() -> Self {
        self.replacingOccurrences(of: " ", with: "+")
    }
    
    func localized() -> String {
        NSLocalizedString(self, tableName: nil, bundle: Bundle.localizedBundle(), value: "", comment: "")
    }
    
    func localizeWithFormat(arguments: CVarArg...) -> String{
        String(format: self.localized(), arguments: arguments)
    }
}
