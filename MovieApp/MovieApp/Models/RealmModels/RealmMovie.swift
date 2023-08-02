import Foundation
import RealmSwift

class RealmMovie: Object, ObjectKeyIdentifiable, MovieModelProtocol {
    
    @Persisted var title: String = ""
    @Persisted var year: String  = ""
    @Persisted var imdbID: String = ""
    @Persisted(primaryKey: true) var id: Int
    @Persisted var type: String = ""
    @Persisted var posterUrl: String
    @Persisted var plot: String?
    
    convenience init(title: String, year: String, imdbID: String, type: String, posterUrl: String, plot: String? = nil) {
        self.init()
        
        self.title = title
        self.year = year
        self.imdbID = imdbID
        self.type = type
        self.posterUrl = posterUrl
        self.plot = plot
        id = imdbID.hashValue
    }
    
    convenience init(from movie: Movie) {
        self.init()
        
        self.title = movie.title
        self.year = movie.year
        self.type = movie.type
        self.posterUrl = movie.posterUrl
        self.imdbID = movie.imdbID
        id = imdbID.hashValue
    }
    
    convenience init(from movieDetails: MovieDetails) {
        self.init()
        
        self.title = movieDetails.title
        self.year = movieDetails.year
        self.type = movieDetails.type
        self.posterUrl = movieDetails.poster.absoluteString
        self.imdbID = movieDetails.imdbID
        self.plot = movieDetails.plot
        id = imdbID.hashValue
    }
}
