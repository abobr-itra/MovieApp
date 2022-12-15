import UIKit

extension UIImageView {
  func load(from url: URL) {
    DispatchQueue.global().async { [weak self] in // Download on background
      if let data = try? Data(contentsOf: url) {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async { // Setting on main
            self?.image = image
          }
        }
      }
    }
  }
}
