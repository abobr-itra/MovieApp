import XCTest
@testable import MovieApp

final class MovieAppUITests: XCTestCase {
    
    // MARK: - Properties

    private let app = XCUIApplication()
    
    override func setUp() {
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    // MARK: - Tests
    
    func testSwitchTabBar() {
        let tabBar = app.tabBars.element(boundBy: 0)
        XCTAssert(app.tables.element(boundBy: 0).exists)

        tabBar.buttons.element(boundBy: 1).tap()
        XCTAssert(app.tables.element(boundBy: 0).exists)

        tabBar.buttons.element(boundBy: 2).tap()
        XCTAssert(app.tables.element(boundBy: 0).exists)
        XCTAssert(app.tables.staticTexts["Basic"].exists)
        XCTAssert(app.tables.staticTexts["Privacy"].exists)
    }
    
    func testSearch() throws {

        let searchBar = app.searchFields.element(boundBy: 0)
        searchBar.accessibilityTraits = UIAccessibilityTraits.searchField
        searchBar.tap()
        searchBar.typeText("Thing")

        let table = app.tables
        table.cells.element(boundBy: 0).tap()
        XCTAssert(app.staticTexts["The Thing"].exists)
    }
    
    func testSwitchTheme() {
        let tabBar = app.tabBars.element(boundBy: 0)
        tabBar.buttons.element(boundBy: 2).tap()
        app.tables.cells.element(boundBy: 0).tap()
        app.switches.element(boundBy: 0).tap()
        
        tabBar.buttons.element(boundBy: 0).tap()
    }
    
    func testSaveAndDelete() {
        let searchBar = app.searchFields.element(boundBy: 0)
        searchBar.accessibilityTraits = UIAccessibilityTraits.searchField
        searchBar.tap()
        searchBar.typeText("The Thing")

        let table = app.tables
        table.cells.element(boundBy: 0).tap()
        app.buttons["Save"].tap()

        let tabBar = app.tabBars.element(boundBy: 0)
        tabBar.buttons.element(boundBy: 1).tap()
        let wishlistTable = app.tables.element(boundBy: 0)
        XCTAssert(wishlistTable.cells.element(matching: .cell, identifier: "MovieCell.The Thing").exists)
        
        tabBar.buttons.element(boundBy: 0).tap()

        app.buttons["Delete"].tap()
        tabBar.buttons.element(boundBy: 1).tap()
        XCTAssertFalse(wishlistTable.cells.element(matching: .cell, identifier: "MovieCell.The Thing").exists)
    }
}
