import UIKit

struct Constants {
    
    struct Cell {

        static let borderColor = UIColor.adaptiveColor(light: .black, dark: .orange)

        static let borderWidth: CGFloat = 0.5
        static let cornerRadius: CGFloat = 10.0
        static let shadowOffset = CGSize(width: -1, height: 1)
        static let inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        static let highlightColor: UIColor = .systemGray
    }
    
    struct Colors {
        
        static let clear: UIColor = .clear
    }
    
    struct TabBar {

        static let color = UIColor.adaptiveColor(light: .red, dark: .orange)
        
        static let searchImage = UIImage(systemName: "magnifyingglass")
        static let personImage = UIImage(systemName: "person")
        static let wishlistImage = UIImage(systemName: "star")
        static let settingsImage = UIImage(systemName: "gearshape")
    }

    struct Buttons {
        
        static let saveButtonColor = UIColor.adaptiveColor(light: .systemGreen, dark: .orange)
        static let deleteButton = UIColor.adaptiveColor(light: .red, dark: UIColor(red: 139, green: 0, blue: 0, alpha: 1))
    }

    struct Sizes {
        
        static let tableViewRowStandart: CGFloat = 100
    }

    struct MockData {
        
        static let movieSearchMock = MovieSearch(search: [], totalResults: "", response: "")
    }

    struct TextFields {
        
        static let sideMargin: CGFloat = 16.0
        static let buttonsSideMargin: CGFloat = 90.0
    }
    
    struct CustomField {
        
        static let fielCornerRadius: CGFloat = 15
        static let leadingPadding: CGFloat = 16
        
        static let labelDefaultFontSize: CGFloat = 15
        static let labelSmallFontSize: CGFloat = 10
        
        static let backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04)
        static let mainColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.87)
        static let secondaryColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        static let errorColor = UIColor(red: 0.69, green: 0, blue: 0.13, alpha: 1)
    }
}
