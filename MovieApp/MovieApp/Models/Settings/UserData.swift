import Foundation

struct UserData: Identifiable, Codable {

    let id: String
    var firstName: String = ""
    var secondName: String = ""
    var avatarUrl: String = ""
}
