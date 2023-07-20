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
        static let settingsImage = UIImage(systemName: "gearshape")
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
    
    struct MockData {
        
        static let movieDetailsMock = MovieDetails(title: "Test Title",
                                year: "2023",
                                rated: "7",
                                released: "",
                                runtime: "2:00",
                                genre: "horror",
                                director: "",
                                writer: "",
                                actors: "",
                                plot: "",
                                language: "",
                                country: "",
                                awards: "",
                                poster: URL(string: "https://t.ly/fP-IJ")!,
                                ratings: [],
                                metascore: "",
                                imdbRating: "",
                                imdbVotes: "",
                                imdbID: "",
                                type: "movie",
                                dvd: "",
                                boxOffice: "",
                                production: "",
                                website: "",
                                response: "")
    }

    struct MockData {
        
        static let movieSearchMock = MovieSearch(search: [], totalResults: "", response: "")
    }
}
