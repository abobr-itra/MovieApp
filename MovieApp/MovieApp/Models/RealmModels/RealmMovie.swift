import Foundation
import RealmSwift

class RealmMovie: Object, ObjectKeyIdentifiable {

  @Persisted var title: String = ""
  @Persisted var year: String  = ""
  @Persisted(primaryKey: true) var imdbID: String = "" // ??
  @Persisted var type: String = ""
  @Persisted var posterUrl: String = ""
  @Persisted var plot: String?
  
  convenience init(from movie: Movie) {
    
    self.init()
    
    self.title = movie.title
    self.year = movie.year
    self.type = movie.type
    self.posterUrl = movie.poster.absoluteString
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
