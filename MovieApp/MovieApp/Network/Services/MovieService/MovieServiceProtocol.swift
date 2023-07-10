import Foundation
import Combine

protocol MovieServiceProtocol {
    
    func fetchMovies(by title: String, completion: @escaping (Result<MovieSearch, RequestError>) -> Void)
    func fetchMovies(by title: String) -> AnyPublisher<MovieSearch, RequestError>
    func fetchMovieDetails(by id: String, completion: @escaping (Result<MovieDetails, RequestError>) -> Void)
}
