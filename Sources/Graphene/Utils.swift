//
//  Utils.swift
//  FlatReversi
//
//  Created by Kodama Yoshinori on 11/14/14.
//  Copyright (c) 2014 Yoshinori Kodama. All rights reserved.
//

import Foundation

func sum (_ array : [Int]) -> Int {
    if array.isEmpty {
        return 0
    }
    return array.reduce(array[0], {$0 + $1})
}

func min (_ array : [Int]) -> Int {
    if array.isEmpty {
        return Int.max
    }
    return array.reduce(array[0], {$0 > $1 ? $1 : $0})
}

func min(_ a: Double, b: Double) -> Double {
    return a > b ? b : a
}

func max (_ array : [Int]) -> Int {
    if array.isEmpty {
        return Int.min
    }
    return array.reduce(array[0], {$0 < $1 ? $1 : $0})
}

func max (_ array : [Double]) -> Double {
    if array.isEmpty {
        return 0.0
    }
    return array.reduce(array[0], {$0 < $1 ? $1 : $0})
}

func max(_ a: Double, b: Double) -> Double {
    return a > b ? a : b
}

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

#if os(Linux)
    import Glibc
    import SwiftShims
#else
    import Darwin
#endif

func cs_arc4random_uniform(upperBound : UInt32 = UINT32_MAX) -> UInt32 {
    #if os(Linux)
        return _swift_stdlib_arc4random_uniform(upperBound)
    #else
        return arc4random_uniform(upperBound)
    #endif
}

func cs_double_random() -> Double {
    return Double(cs_arc4random_uniform(upperBound: UINT32_MAX)) / Double(UINT32_MAX)
}
