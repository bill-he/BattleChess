//
//  BoardSpace.swift
//  Chess
//
//  Created by Jack Cousineau on 10/14/15.
//

import Cocoa

class BoardSpace: NSBox {
    
    var occupyingPiece: ChessPiece!
    var occupyingPieceImageView: NSImageView!
    var x: Int!
    var y: Int!
    var clickEventBlock: ((BoardSpace)->())?
    
    init(xPixels: Int, yPixels: Int, fillWhite: Bool, clickEventHandler: ((BoardSpace)->())?){
        x = (xPixels-2)/70
        y = (yPixels-2)/70
        super.init(frame: NSMakeRect(CGFloat(xPixels), CGFloat(yPixels), 41, 41))
        titlePosition = NSTitlePosition.noTitle
        boxType = .custom
        borderType = .noBorder
        if(fillWhite){
            fillColor = NSColor.white
        }
        else{
            fillColor = NSColor.gray
        }
        clickEventBlock = clickEventHandler
    }
    
    func setPiece(_ chessPiece: ChessPiece){
        occupyingPiece = chessPiece
        if(occupyingPieceImageView == nil){
            occupyingPieceImageView = NSImageView(frame: NSMakeRect(-1, 0, 40, 40))
            contentView?.addSubview(occupyingPieceImageView)
        }
        occupyingPieceImageView.image = chessPiece.pieceImage
    }
    
    func clearPiece(){
        occupyingPieceImageView.removeFromSuperview()
        occupyingPiece = nil
        occupyingPieceImageView = nil
    }
    
    override func mouseDown(with theEvent: NSEvent){
        clickEventBlock!(self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
