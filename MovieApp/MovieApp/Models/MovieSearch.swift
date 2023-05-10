import Foundation

struct MovieSearch: Codable {

    let search: [Movie]
    let totalResults, response: String

    enum CodingKeys: String, CodingKey {

        case search = "Search"
        case totalResults
        case response = "Response"
    }
}
