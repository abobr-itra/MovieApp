import Foundation

struct Movie: Codable {
    let title, year, imdbID: String
    let type: String
    let poster: URL

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
