//
//  ViewController.swift
//  TicTacToe
//
//  Created by Hani on 2/8/2023.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var NaughtsScore: UILabel!
  @IBOutlet weak var DrawsScore: UILabel!
  @IBOutlet weak var CrossesScore: UILabel!
  @IBOutlet weak var TurnLabel: UILabel!

  @IBOutlet weak var BoxOne: UIButton!
  @IBOutlet weak var BoxTwo: UIButton!
  @IBOutlet weak var BoxTree: UIButton!
  @IBOutlet weak var BoxFour: UIButton!
  @IBOutlet weak var BoxFive: UIButton!
  @IBOutlet weak var BoxSix: UIButton!
  @IBOutlet weak var BoxSeven: UIButton!
  @IBOutlet weak var BoxEight: UIButton!
  @IBOutlet weak var BoxNine: UIButton!

  //MARK: - Constants

  enum Constants {
    static let fontFamilyName: String = "IndieFlower"
    static let turnTitle: String = "Turn"
    static let noughtResultTitle: String = "Naughts"
    static let crossResultTitle: String = "Crosses"
    static let drawResultTitle: String = "Draw"
    static let noughtSymbol: Character = "O"
    static let crossSymbol: Character = "X"
    static let resetAlertButtonText: String = "Reset"

    enum Styles {
      static let fontSize: CGFloat = CGFloat(80)
      static let boardFont: UIFont = UIFont(name: Constants.fontFamilyName , size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
      static let titleAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font: boardFont]
      static let crossAttributes: NSAttributedString = NSAttributedString(
        string: String(Constants.crossSymbol), attributes: [
          .font : Constants.Styles.boardFont
        ])
      static let noughtAttributes: NSAttributedString = NSAttributedString(
        string: String(Constants.noughtSymbol), attributes: [
          .font : Constants.Styles.boardFont
        ])
    }

    enum Turn {
      case Nought
      case Cross
    }
  }

  var ticTacToeModel = TicTacToeModel()

  //MARK: - CurrentTurn

  var currentTurn = Constants.Turn.Cross
  var firstTurn = Constants.Turn.Cross

//MARK: - Score

  var crossScore: Int = 0
  var noughtScore: Int = 0
  var drawScore: Int = 0


  override func viewDidLoad() {
    super.viewDidLoad()
    initButtons()
    TurnLabel.attributedText = Constants.Styles.crossAttributes
  }

  var buttons = [UIButton]()

  func initButtons() {
    buttons.append(BoxOne)
    buttons.append(BoxTwo)
    buttons.append(BoxTree)
    buttons.append(BoxFour)
    buttons.append(BoxFive)
    buttons.append(BoxSix)
    buttons.append(BoxSeven)
    buttons.append(BoxEight)
    buttons.append(BoxNine)
  }

  @IBAction func selectedBox(_ sender: UIButton) {

    addAction(sender)
    if ticTacToeModel.fullBoard(buttons: buttons) {
      endGameAlert(title: Constants.drawResultTitle)
      drawScore += 1
      DrawsScore.text = String(drawScore)
    } else if isCurrentPlayerWins(sender.attributedTitle(for: .normal)) {
      endGameAlert(title: " \(currentTurn == Constants.Turn.Cross ? Constants.noughtResultTitle : Constants.crossResultTitle ) wins")
      if (currentTurn == Constants.Turn.Cross) {
        noughtScore += 1
        NaughtsScore.text = String(noughtScore)
      } else {
        crossScore += 1
        CrossesScore.text = String(crossScore)
      }
    }
  }

  func isCurrentPlayerWins(_ player: NSAttributedString?) -> Bool {

    ticTacToeModel.checkLine(player, [BoxOne,BoxTwo,BoxTree]) || ticTacToeModel.checkLine(player, [BoxFour,BoxFive,BoxSix]) ||
    ticTacToeModel.checkLine(player, [BoxSeven,BoxEight,BoxNine]) || ticTacToeModel.checkLine(player, [BoxOne,BoxFour,BoxSeven]) ||
    ticTacToeModel.checkLine(player, [BoxTwo,BoxFive,BoxEight]) || ticTacToeModel.checkLine(player, [BoxTree,BoxSix,BoxNine]) ||
    ticTacToeModel.checkLine(player, [BoxOne,BoxFive,BoxNine]) || ticTacToeModel.checkLine(player, [BoxTree,BoxFive,BoxSeven])

  }

  func endGameAlert(title: String) {
    let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: Constants.resetAlertButtonText, style: .default, handler: { _ in
      self.resetBoard()
    }))
    self.present(alert, animated: true)
  }

  func resetBoard() {
    for button in buttons {
      button.setAttributedTitle(nil, for: .normal)
      button.isEnabled = true
    }
    firstTurn = firstTurn == Constants.Turn.Cross ?  Constants.Turn.Nought : Constants.Turn.Cross
    currentTurn = firstTurn
  }

  func addAction(_ sender: UIButton) {

    if sender.attributedTitle(for: .normal) == nil {
      if currentTurn == Constants.Turn.Cross {
        sender.setAttributedTitle(Constants.Styles.crossAttributes,for: .normal)
        currentTurn = Constants.Turn.Nought
        TurnLabel.attributedText = Constants.Styles.noughtAttributes
      } else if currentTurn == Constants.Turn.Nought {
        sender.setAttributedTitle(Constants.Styles.noughtAttributes,for: .normal)
        currentTurn = Constants.Turn.Cross
        TurnLabel.attributedText = Constants.Styles.crossAttributes
      }
    }
    sender.isEnabled = false
  }

}

