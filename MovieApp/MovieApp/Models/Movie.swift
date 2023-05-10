import Foundation

struct Movie: Codable, MovieModelProtocol {

    var title, year, imdbID: String
    var type: String
    var posterUrl: String
    lazy var poster = URL(string: posterUrl)

    enum CodingKeys: String, CodingKey {

        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case posterUrl = "Poster"
    }
}
