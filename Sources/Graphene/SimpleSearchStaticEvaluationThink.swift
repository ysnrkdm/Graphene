//
//  SimpleSearchStaticEvaluationThink.swift
//  Graphene
//
//  Created by KodamaYoshinori on 2016/10/31.
//
//

import Foundation

public class SimpleSearchStaticEvaluationThink : Think {
    var zones: Zones? = nil
    var pnsLessThan: Int = 0
    var searchDepth: Int = 1
    
    var wPossibleMoves: [Double] = [1.0]
    var wEdge: [Double] = [1.0]
    var wFixedPieces: [Double] = [1.0]
    var wOpenness: [Double] = [1.0]
    var wBoardEvaluation: [Double] = [1.0]
    
    var evaluator = ClassicalEvaluator()
    var sst = NegaAlphaSearch()
    
    public init(zones: Zones, pnsLessThan: Int, searchDepth: Int, wPossibleMoves: [Double], wEdge: [Double], wFixedPieces: [Double], wOpenness: [Double], wBoardEvaluation: [Double]) {
        self.zones = zones
        self.pnsLessThan = pnsLessThan
        self.searchDepth = searchDepth
        
        self.wPossibleMoves = wPossibleMoves
        self.wEdge = wEdge
        self.wFixedPieces = wFixedPieces
        self.wOpenness = wOpenness
        self.wBoardEvaluation = wBoardEvaluation
        
        evaluator.configure(wPossibleMoves, wEdge: wEdge, wFixedPieces: wFixedPieces, wOpenness: wOpenness, wBoardEvaluation: wBoardEvaluation, zones: zones)
    }
    
    public func think(_ color: Pieces, board: BoardRepresentation, info: Info) -> Hand {
        var retx = 0
        var rety = 0
        
        let puttables = board.getPuttables(color)
        
        if board.getNumVacant() < pnsLessThan {
            let solver = SimpleProofSolver()
            let answer = solver.solve(board.clone(), forPlayer: color)
            info.say(message: "Solving by PNS search...")
            if ((answer.proof == .blackWin && color == .black) || (answer.proof == .whiteWin && color == .white)) && answer.moves.count > 0 {
                (retx, rety) = answer.moves[0]
                info.say(message: "Found PV! Answer is \(retx), \(rety)")
                return Hand(row: rety, col: retx, color: color)
            }
            info.say(message: "No PV found. Doing random.")
        }
        
        if puttables.count > 0 {
            let res = sst.search(board.clone(), forPlayer: color, evaluator: evaluator, depth: searchDepth)
            
            info.say(message: "Searched -- " + res.toString())
            let coords = res.pv
            if coords.count > 0 {
                (retx, rety) = coords[0]
            }
        }
        return Hand(row: rety, col: retx, color: color)
    }
}
