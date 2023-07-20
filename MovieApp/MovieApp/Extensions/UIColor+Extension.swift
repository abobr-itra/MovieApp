import UIKit

extension UIColor {
    
    static func adaptiveColor(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traits) -> UIColor in
                traits.userInterfaceStyle == .light ? light : dark
            }
        } else {
            return light
        }
    }
}
