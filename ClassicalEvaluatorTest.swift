//
//  ClassicalEvaluatorTest.swift
//  Graphene
//
//  Created by KodamaYoshinori on 2016/12/27.
//
//

import Graphene
import XCTest

class ClassicalEvaluatorTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let board = BoardBuilder.build("----O-X------X-----XXXO-OXXXXXOO-XXOOXOOXXOXXXOO--OOOO-O----OO--")
        let c = ClassicalEvaluator()
        if let bb = board.boardMediator.getBoard() as? SimpleBitBoard {
            let openness = c.openness(bb.getUnsafeBitBoard(), forPlayer: .black)
            XCTAssertEqual(openness, 30)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
