import Foundation

protocol MovieServiceProtocol {
    
    func fetchMovies(by title: String, completion: @escaping (Result<MovieSearch, RequestError>) -> Void)
    func fetchMovieDetails(by id: String, completion: @escaping (Result<MovieDetails, RequestError>) -> Void)
}
