//
//  ChessPiece.swift
//  Chess
//
//  Created by Jack Cousineau on 10/14/15.
//

import Cocoa

enum PieceColor{
    case black
    case white
}

class ChessPiece: NSObject{
    
    var pieceImage: NSImage!
    var pieceColor: PieceColor!
    
    init(image: NSImage, color: PieceColor){
        super.init()
        pieceColor = color
        pieceImage = image
    }
    
    func isValidMove(_ startX: Int, startY: Int, destinationX: Int, destinationY: Int, board: [[BoardSpace]]) -> (Bool){
        return false
    }
    
    func spaceIsEmpty(_ x: Int, y: Int, board: [[BoardSpace]]) -> Bool{
        return board[x][y].occupyingPiece == nil
    }
    
    func parseBishopMovement(_ startX: Int, startY: Int, destinationX: Int, destinationY: Int, board: [[BoardSpace]]) -> Bool{
        let xChange = abs(startX - destinationX)
        let yChange = abs(startY - destinationY)
        
        if(xChange == yChange){
            if(startX > destinationX){
                if(startY > destinationY){ // Southwest
                    for i in 1...xChange{
                        if(board[startX - i][startY - i].occupyingPiece != nil && (i != xChange)){
                            return false;
                        }
                    }
                }
                else{ // Northwest
                    for i in 1...xChange{
                        if(board[startX - i][startY + i].occupyingPiece != nil && (i != xChange)){
                            return false;
                        }
                    }
                }
            }
            else{
                if(startY > destinationY){ // Southeast
                    for i in 1...xChange{
                        if(board[startX + i][startY - i].occupyingPiece != nil && (i != xChange)){
                            return false;
                        }
                    }
                }
                else{ // Northeast
                    for i in 1...xChange{
                        if(board[startX + i][startY + i].occupyingPiece != nil && (i != xChange)){
                            return false;
                        }
                    }
                }
            }
            return true
        }
        return false
    }
    
    func parseRookMovement(_ startX: Int, startY: Int, destinationX: Int, destinationY: Int, board: [[BoardSpace]]) -> (Bool){
        if(startX == destinationX || startY == destinationY){ // Straight line
            
            if(startX != destinationX){
                if(startX < destinationX){ // Moving to the right
                    return (parseHorizontal(startX+1, endPos: destinationX, destinationY: destinationY, movementLeft: false, board: board))
                }
                else{ // Moving to the left
                    return (parseHorizontal(destinationX, endPos: startX-1, destinationY: destinationY, movementLeft: true, board: board))
                }
            }
            else{
                if(startY < destinationY){ // Moving up
                    return (parseVertical(startY+1, endPos: destinationY, destinationX: destinationX, movementDown: false, board: board))
                }
                else{ // Moving down
                    return (parseVertical(destinationY, endPos: startY-1, destinationX: destinationX, movementDown: true, board: board))
                }
            }
        }
        return false
    }
    
    func parseHorizontal(_ startPos: Int, endPos: Int, destinationY: Int, movementLeft: Bool, board: [[BoardSpace]]) -> Bool{
        for i in startPos...endPos{
            if let obstructingPiece = board[i][destinationY].occupyingPiece{
                if(((!movementLeft && i == endPos) || (movementLeft && i == startPos)) && obstructingPiece.pieceColor != pieceColor){
                    continue
                }
                return false
            }
        }
        return true
    }
    
    func parseVertical(_ startPos: Int, endPos: Int, destinationX: Int, movementDown: Bool, board: [[BoardSpace]]) -> Bool{
        for i in startPos...endPos{
            if let obstructingPiece = board[destinationX][i].occupyingPiece{
                if(((!movementDown && i == endPos) || (movementDown && i == startPos)) && obstructingPiece.pieceColor != pieceColor){
                    continue
                }
                return false
            }
        }
        return true
    }
}
