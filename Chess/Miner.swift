//
//  Miner.swift
//  Battle
//
//  Created by Bill He on 3/5/17.
//

import Cocoa

class Miner: ChessPiece {
    
    var moved = false
    
    override func isValidMove(_ startX: Int, startY: Int, destinationX: Int, destinationY: Int, board: [[BoardSpace]]) -> (Bool){
        
        let validMove = parseRookMovement(startX, startY: startY, destinationX: destinationX, destinationY: destinationY, board: board)
        if(validMove){
            moved = true
        }
        return validMove
    }
}
