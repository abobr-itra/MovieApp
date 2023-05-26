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
    
    static let highlightColor: UIColor = .systemGray
  }
  
  struct Colors {
    
    static let clear: UIColor = .clear
  }
  
  struct TabBar {
    
    static let light: UIColor = .systemRed
    static let dark: UIColor = .orange
    
    static let searchImage = UIImage(systemName: "magnifyingglass")
    static let personImage = UIImage(systemName: "person")
    static let wishlistImage = UIImage(systemName: "star")
  }
  
  struct SaveButton {
    
    static let lightThemeColor: UIColor = .systemGreen
    static let darkThemeColor: UIColor = .orange
  }
  
  struct DeleteButton {
    
    static let lightThemeColor: UIColor = .systemRed
    static let darkThemeColor: UIColor = UIColor(red: 139, green: 0, blue: 0, alpha: 1)
  }
  
  struct Sizes {
    
    static let tableViewRowStandart: CGFloat = 100
  }
}

extension UIColor {
  
  static var deleteButtonColor: UIColor {
    if #available(iOS 13.0, *) {
      return UIColor { (traits) -> UIColor in
        return traits.userInterfaceStyle == .light ? Constants.DeleteButton.lightThemeColor: Constants.SaveButton.lightThemeColor
      }
    } else {
      return .systemRed
    }
  }
  
  static var tabBarTintColor: UIColor {
    if #available(iOS 13.0, *) {
      return UIColor { (traits) -> UIColor in
        return traits.userInterfaceStyle == .light ? Constants.TabBar.light: Constants.TabBar.dark
      }
    }
  }
}
