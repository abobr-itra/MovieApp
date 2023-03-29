import Foundation
import RealmSwift

class RealmMovieSearch: Object {
  
  @Persisted var movies: List<RealmMovie>
  
  convenience init(from movies: MovieSearch) {
    
    self.init()
    
    for movie in movies.search {
      let realmMovie = RealmMovie(from: movie)
      self.movies.append(realmMovie)
    }
  }
}
