//
//  TicTacToeModel.swift
//  TicTacToe
//
//  Created by Hani on 7/8/2023.
//

import UIKit

class TicTacToeModel {



  func checkLine(_ player: NSAttributedString?,_ elements: [UIButton]) -> Bool {
    for element in elements {
      if element.attributedTitle(for: .normal) != player {
        return false
      }
    }
    return true
  }

  func fullBoard(buttons: [UIButton]) -> Bool {
    for button in buttons {
      if button.attributedTitle(for: .normal) == nil {
        return false
      }
    }
    return true
  }

}
