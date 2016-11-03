//
//  FasterBitBoard.swift
//  FlatReversi
//
//  Created by Kodama Yoshinori on 12/16/14.
//  Copyright (c) 2014 Yoshinori Kodama. All rights reserved.
//

import Foundation

open class FastBitBoard : Board {
    open func getUnsafeBitBoard() -> BitBoard { fatalError("Implement actual class by inheriting this class.") }

    // MARK: Board functions
    open func initialize(_ width: Int, height: Int) { fatalError("Implement actual class by inheriting this class.") }

    // MARK: Basic functions
    open func withinBoard(_ x: Int, y: Int) -> Bool { fatalError("Implement actual class by inheriting this class.") }

    open func set(_ color: Pieces, x: Int, y: Int) { fatalError("Implement actual class by inheriting this class.") }
    open func get(_ x: Int, y: Int) -> Pieces { fatalError("Implement actual class by inheriting this class.") }
    open func isPieceAt(_ piece: Pieces, x: Int, y: Int) -> Bool { fatalError("Implement actual class by inheriting this class.") }
    open func put(_ color: Pieces, x: Int, y: Int, guides: Bool, returnChanges: Bool) -> [(Int, Int)] { fatalError("Implement actual class by inheriting this class.") }

    open func width() -> Int { fatalError("Implement actual class by inheriting this class.") }
    open func height() -> Int { fatalError("Implement actual class by inheriting this class.") }

    // MARK: Query functions
    open func getNumBlack() -> Int { fatalError("Implement actual class by inheriting this class.") }
    open func getNumWhite() -> Int { fatalError("Implement actual class by inheriting this class.") }

    open func canPut(_ color: Pieces, x: Int, y: Int) -> Bool { fatalError("Implement actual class by inheriting this class.") }
    open func getPuttables(_ color: Pieces) -> [(Int, Int)] { fatalError("Implement actual class by inheriting this class.") }
    open func isAnyPuttable(_ color: Pieces) -> Bool { fatalError("Implement actual class by inheriting this class.") }
    open func getReversible(_ color: Pieces, x: Int, y: Int) -> [(Int, Int)] { fatalError("Implement actual class by inheriting this class.") }
    open func isEmpty(_ x: Int, y: Int) -> Bool { fatalError("Implement actual class by inheriting this class.") }

    open func numPeripherals(_ color: Pieces, x: Int, y: Int) -> Int { fatalError("Implement actual class by inheriting this class.") }

    open func hashValue() -> Int { fatalError("Implement actual class by inheriting this class.") }

    // MARK: Update functions
    open func updateGuides(_ color: Pieces) -> Int { fatalError("Implement actual class by inheriting this class.") }

    // MARK: Utility functions
    open func clone() -> Board { fatalError("Implement actual class by inheriting this class.") }
    func cloneBitBoard() -> FastBitBoard { fatalError("Implement actual class by inheriting this class.") }

    open func toString() -> String { fatalError("Implement actual class by inheriting this class.") }

    func isTerminal() -> Bool { fatalError("Implement actual class by inheriting this class.") }

    func nextTurn(_ color: Pieces) -> Pieces {
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
