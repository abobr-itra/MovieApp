import Foundation

extension String {

  func prepareForUrl() -> Self {
    self.replacingOccurrences(of: " ", with: "+")
  }
}
