public struct DataModel {

  var rounds: [Round?]
  var score: Int {
    return rounds.map({ $0?.score ?? 0 }).sum()
  }

  init(jsonFilename: String) {

    let jsonData = try! Data(contentsOf: URL(fileURLWithPath: jsonFilename))
    let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options: [])
    let data = jsonObject as! [[String]]

    rounds = data.map({
      if let opponent = $0[0].sign, let outcome = $0[1].outcome {
        return Round(
          opponent: opponent,
          outcome: outcome
        )
      }
      return nil
    })

  }

}

struct Round {
  let opponent: HandSign
  let outcome: Result
  var response: HandSign {
    if outcome == .draw {
      return opponent
    } else if opponent == .rock && outcome == .win {
      return .paper
    } else if opponent == .rock && outcome == .lose {
      return .scissors
    } else if opponent == .paper && outcome == .win {
      return .scissors
    } else if opponent == .paper && outcome == .lose {
      return .rock
    } else if opponent == .scissors && outcome == .win {
      return .rock
    } else {
      return .paper
    }
  }
  var score: Int {
    return response.points + outcome.points
  }
}

enum HandSign {
  case rock
  case paper
  case scissors
}

extension HandSign {
  var points: Int {
    switch self {
    case .rock: return 1
    case .paper: return 2
    case .scissors: return 3
    }
  }
}

enum Result {
  case win
  case lose
  case draw
}

extension Result {
  var points: Int {
    switch self {
    case .win: return 6
    case .lose: return 0
    case .draw: return 3
    }
  }
}

extension String {
  var sign: HandSign? {
    switch self {
    case "A": return .rock
    case "B": return .paper
    case "C": return .scissors
    default: return nil
    }
  }
}

extension String {
  var outcome: Result? {
    switch self {
    case "X": return .lose
    case "Y": return .draw
    case "Z": return .win
    default: return nil
    }
  }
}

extension Array where Element == Int {
  func sum() -> Int {
    return self.reduce(0, +)
  }
}