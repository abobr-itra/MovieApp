import Foundation
import RealmSwift

protocol MovieModelProtocol {
  
  var title: String { get set }
  var year: String { get set }
  var imdbID: String { get set }
  var type: String { get set }
  var posterUrl: String { get set }
}

class RealmMovie: Object, ObjectKeyIdentifiable, MovieModelProtocol {

  @Persisted var title: String = ""
  @Persisted var year: String  = ""
  @Persisted(primaryKey: true) var imdbID: String = ""
  @Persisted var type: String = ""
  @Persisted var posterUrl: String
  @Persisted var plot: String?
  
  convenience init(from movie: Movie) {
    
    self.init()
    
    self.title = movie.title
    self.year = movie.year
    self.type = movie.type
    self.posterUrl = movie.posterUrl
    self.imdbID = movie.imdbID
  }
  
  convenience init(from movieDetails: MovieDetails) {
    
    self.init()
    
    self.title = movieDetails.title
    self.year = movieDetails.year
    self.type = movieDetails.type
    self.posterUrl = movieDetails.poster.absoluteString
    self.imdbID = movieDetails.imdbID
    self.plot = movieDetails.plot
  }
}
