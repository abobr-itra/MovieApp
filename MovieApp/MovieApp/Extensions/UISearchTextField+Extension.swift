import UIKit
import Combine

extension UISearchTextField {
    
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification,
                                              object: self)
        .compactMap { ($0.object as? UISearchTextField)?.text }
        .eraseToAnyPublisher()
    }
}
