import Combine

protocol MovieServiceProtocol {

    func fetchMovies(by title: String) -> AnyPublisher<MovieSearch, RequestError>
    func fetchMovieDetails(by id: String) -> AnyPublisher<MovieDetails, RequestError>
}
