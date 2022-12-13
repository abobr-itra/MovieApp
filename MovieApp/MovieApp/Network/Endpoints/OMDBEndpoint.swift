import Foundation

enum OMDBEndpoint {
  var baseURL: String { "http://www.omdbapi.com" }
  var apiKey: String { "438f83f" }
  
  case byID(String, Plot)
  case byTitle(String, Plot)
  
  private var fullPath: String {
    var endpoint = "/?apiKey=\(apiKey)"
    switch self {
    case .byID(let id, let plot):
      endpoint += "&i=\(id)&plot=\(plot)"
    case .byTitle(let title, let plot):
      endpoint += "&t=\(title)&plot=\(plot)"
    }
    return baseURL + endpoint
  }
  
  var url: URL {
      guard let url = URL(string: fullPath) else {
          preconditionFailure("The url used in \(String(describing: self)) is not valid")
      }
      return url
  }
}

enum Plot: String {
  case short, full
}
