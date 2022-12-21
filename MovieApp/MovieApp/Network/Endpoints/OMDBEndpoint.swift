import Foundation

enum OMDBEndpoint {

  case byID(String)
  case byTitle(String)
  case bySearch(String)
  
  // MARK: Public
  
  var url: URL {
    guard let url = URL(string: fullPath) else {
      preconditionFailure("The url used in \(String(describing: self)) is not valid")
    }
    return url
  }
  
  // MARK: Private
  
  // FIXME: Not secure, store separate enum
  private var baseURL: String { "http://www.omdbapi.com" }
  // FIXME: Not secure, store in info.plist or separate file
  private var apiKey: String { "438f83f" }
  
  private var fullPath: String {
    var endpoint = "/?apiKey=\(apiKey)"
    switch self {
    case .byID(let id):
      endpoint += "&i=\(id)"
    case .byTitle(let title):
      endpoint += "&t=\(title.prepareForUrl())"
    case .bySearch(let request):
      endpoint += "&s=\(request.prepareForUrl())"
    }
    return baseURL + endpoint
  }
}
