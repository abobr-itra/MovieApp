import Foundation

enum OMDBEndpoint {
  private var baseURL: String { "http://www.omdbapi.com" }
  private var apiKey: String { "438f83f" }
  
  case byID(String)
  case byTitle(String)
  
  private var fullPath: String {
    var endpoint = "/?apiKey=\(apiKey)"
    switch self {
    case .byID(let id):
      endpoint += "&i=\(id)"
    case .byTitle(let title):
      endpoint += "&s=\(title)"
    }
    return baseURL + endpoint
  }
  
  var url: URL {
    guard let url = URL(string: fullPath) else {
      preconditionFailure("The url used in \(String(describing: self)) is not valid")
    }
    print(url)
    return url
  }
}

enum Plot: String {
  case short, full
}
