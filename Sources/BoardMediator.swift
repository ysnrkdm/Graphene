//
//  BoardMediator.swift
//  MyFirstSpriteKit
//
//  Created by Kodama Yoshinori on 10/17/14.
//  Copyright (c) 2014 Yoshinori Kodama. All rights reserved.
//

import Foundation

open class BoardMediator {
    fileprivate var board: Board

    // MARK: Initialization
    public init(board:Board) {
        self.board = board
    }

    open func initializeBoard() {
        // FIXME: This assumes 8x8
        board.initialize(8, height: 8)
        updateGuides(.black)
    }

    // MARK: Direct access to Board

    open func height() -> Int {
        return self.board.height()
    }

    open func width() -> Int {
        return self.board.width()
    }

    open func withinBoard(_ x: Int, y: Int) -> Bool {
        return self.board.withinBoard(x, y: y)
    }

    open func set(_ color: Pieces, x: Int, y: Int) {
        self.board.set(color, x: x, y: y)
    }

    open func get(_ x: Int, y: Int) -> Pieces {
        return self.board.get(x, y: y)
    }

    open func isPieceAt(_ piece: Pieces, x: Int, y: Int) -> Bool {
        return self.board.isPieceAt(piece, x: x, y: y)
    }

    // MARK: Query functions
    open func getNumBlack() -> Int {
        return self.board.getNumBlack()
    }

    open func getNumWhite() -> Int {
        return self.board.getNumWhite()
    }

    open func canPut(_ color: Pieces, x: Int, y: Int) -> Bool {
        return self.board.canPut(color, x: x, y: y)
    }

    open func getPuttables(_ color: Pieces) -> [(Int, Int)] {
        return self.board.getPuttables(color)
    }

    open func isAnyPuttable(_ color: Pieces) -> Bool {
        return self.board.isAnyPuttable(color)
    }

    open func isEmpty(_ x: Int, y: Int) -> Bool {
        return self.board.isEmpty(x, y: y)
    }

    open func numPeripherals(_ color: Pieces, x: Int, y: Int) -> Int {
        return self.board.numPeripherals(color, x: x, y: y)
    }

    open func hashValue() -> Int {
        return self.board.hashValue()
    }

    // Only diag or horizontal/vertical lines can change by putting piece at x,y
    open func getReversible(_ color: Pieces, x: Int, y: Int) -> [(Int, Int)] {
        return self.board.getReversible(color, x: x, y: y)
    }

    // MARK: Board update functions

    open func updateGuides(_ color: Pieces) -> Int {
        return self.board.updateGuides(color)
    }

    // Does set and reverse pieces
    // Returns [x,y] of changes (except put piece)
    open func put(_ color: Pieces, x: Int, y: Int, guides: Bool = true, returnChanges: Bool = true) -> [(Int, Int)] {
        return self.board.put(color, x: x, y: y, guides: guides, returnChanges: returnChanges)
    }

    // Normalize the board

    open func toString() -> String {
        return self.board.toString()
    }

    open func clone() -> BoardMediator {
        let b = self.board.clone()
        let bm = BoardMediator(board:b)
        return bm
    }

    open func getBoard() -> Board {
        return self.board
    }

    open func nextTurn(_ color: Pieces) -> Pieces {
        var s : Pieces = .black
        switch color {
        case .black:
            s = .white
        case .white:
            s = .black
        default:
            s = .black
        }
        return s
    }
}
