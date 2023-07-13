import XCTest
import RealmSwift
@testable import MovieApp

final class RealmServiceTests: XCTestCase {

    // MARK: - Properties
    
    private var dataService: RealmServiceProtocol?
    private let mockMovieDetails = Constants.MockData.movieDetailsMock
    
    override func setUp() {
        super.setUp()
        
        dataService = RealmService()
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }
    
    // MARK: - Tests
    
    func testSaveAndGetObject() {
        let realmMovie = RealmMovie(from: mockMovieDetails)
        dataService?.saveObject(realmMovie)
        dataService?.getObject(ofType: RealmMovie.self, by: mockMovieDetails.imdbID, completion: { result in
            switch result {
            case .success(let object):
                XCTAssert(object == realmMovie)
            case .failure(let error):
                print(error)
                XCTAssert(false)
            }
        })
    }
    
    func testGetAllObjects() {
        let realmMovies = RealmMovie(from: mockMovieDetails)
        dataService?.saveObject(realmMovies)
        dataService?.getAllObjects(ofType: RealmMovie.self, completion: { result in
            switch result {
            case .success(let movies):
                XCTAssert([realmMovies] == movies)
            case .failure(let error):
                print(error)
                XCTAssert(false)
            }
        })
    }
    
    func testDeleteObject() {
        let realmMovie = RealmMovie(from: mockMovieDetails)
        dataService?.saveObject(realmMovie)
        dataService?.deleteObject(ofType: RealmMovie.self, where: { $0.imdbID == self.mockMovieDetails.imdbID })
        dataService?.getObject(ofType: RealmMovie.self,
                               by: mockMovieDetails.imdbID,
                               completion: { result in
            switch result {
            case .success:
                XCTAssert(false)
            case .failure(let error):
                XCTAssert(error == RequestError.noData)
            }
        })
    }
}
