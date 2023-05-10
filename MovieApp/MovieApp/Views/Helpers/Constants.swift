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
    static let deleteButtonDarkTheme: UIColor = UIColor(red: 139, green: 0, blue: 0, alpha: 0)
  }
  
  struct Sizes {
    
    static let tableViewRowStandart: CGFloat = 100
  }
}
