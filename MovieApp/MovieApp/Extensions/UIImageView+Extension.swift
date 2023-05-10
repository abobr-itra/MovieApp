import UIKit

extension UIImageView {
  
  func load(from url: URL?) {
    guard let url = url else { return }
    DispatchQueue.global().async { [weak self] in // Download on background

      if let data = try? Data(contentsOf: url),
         let image = UIImage(data: data) {
        DispatchQueue.main.async { // Setting on main
          self?.image = image
        }
      }

    }
  }
}
