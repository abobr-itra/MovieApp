import Foundation
import UIKit

struct Constants {
  
  struct Cell {
    static let lightBorderColor: UIColor = .black
    static let darkBorderTheme: UIColor = .orange
    static let borderWidth: CGFloat = 0.5
    static let cornerRadius: CGFloat = 10.0
    static let shadowOffset: CGSize = CGSize(width: -1, height: 1)
    static let inset: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
  }
  
  struct Colors {
    
    static let clear: UIColor = .clear
    
    static let saveButtonLightThemeColor: UIColor = .systemGreen
    static let saveButtonDarkThemeColor: UIColor = .orange
    
    static let deleteButtonLightTheme: UIColor = .systemRed
    static let deleteButtonDarkTheme: UIColor = UIColor(red: 139, green: 0, blue: 0, alpha: 1)
  }
  
  struct Sizes {
    
    static let tableViewRowStandart: CGFloat = 100
  }
}

extension UIColor {
    static var deleteButton: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traits) -> UIColor in
              return traits.userInterfaceStyle == .light ? Constants.Colors.deleteButtonLightTheme : Constants.Colors.deleteButtonDarkTheme
            }
        } else {
            return .systemRed
        }
    }
}
