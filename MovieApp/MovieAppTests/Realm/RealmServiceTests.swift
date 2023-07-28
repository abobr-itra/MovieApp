import XCTest
import RealmSwift
@testable import MovieApp

final class RealmServiceTests: XCTestCase {

    // MARK: - Properties
    
    private var dataService: RealmServiceProtocol?
    private let realmMovieMock = TestsConstants.realmMovieMock
    
    override func setUp() {
        super.setUp()
        
        let realm = try? Realm(configuration: Realm.Configuration(inMemoryIdentifier: self.name))
        dataService = RealmService(realm: realm)
    }
    
    // MARK: - Tests
    
    func testSaveAndGetObject() {
        dataService?.saveObject(realmMovieMock)
        dataService?.getObject(ofType: RealmMovieMock.self, by: realmMovieMock.imdbID, completion: { result in
            switch result {
            case .success(let object):
                XCTAssertEqual(object, self.realmMovieMock)
            case .failure(let error):
                print(error)
                XCTAssert(false)
            }
        })
    }
    
    func testGetAllObjects() {
        dataService?.saveObject(realmMovieMock)
        dataService?.getAllObjects(ofType: RealmMovieMock.self, completion: { result in
            switch result {
            case .success(let movies):
                XCTAssertEqual([self.realmMovieMock], movies)
            case .failure(let error):
                print(error)
                XCTAssert(false)
            }
        })
    }
    
    func testDeleteObject() {
        dataService?.saveObject(realmMovieMock)
        dataService?.deleteObject(ofType: RealmMovieMock.self, where: { $0.imdbID == self.realmMovieMock.imdbID })
        dataService?.getObject(ofType: RealmMovieMock.self,
                               by: realmMovieMock.imdbID,
                               completion: { result in
            switch result {
            case .success:
                XCTAssert(false)
            case .failure(let error):
                XCTAssertEqual(error, DataError.notFound)
            }
        })
    }
}
