import XCTest
@testable import Graphene

class GrapheneTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(Graphene().text, "Hello, World!")
    }


    static var allTests : [(String, (GrapheneTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
