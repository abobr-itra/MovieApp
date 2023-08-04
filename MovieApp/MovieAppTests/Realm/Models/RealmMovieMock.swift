import Foundation
import RealmSwift

class RealmMovieMock: Object, ObjectKeyIdentifiable {
    
    @Persisted var title: String = ""
    @Persisted var year: String  = ""
    @Persisted(primaryKey: true) var imdbID: String = ""
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
    }
}
