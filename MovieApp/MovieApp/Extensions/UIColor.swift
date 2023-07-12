import UIKit

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
