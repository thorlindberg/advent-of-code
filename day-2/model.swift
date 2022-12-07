public struct DataModel {

    var rounds: [Round?]
    var score: Int {
        return rounds.map({$0?.score ?? 0}).sum()
    }

    init(jsonFilename: String) {

        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: jsonFilename))
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options: [])
        let data = jsonObject as! [[String]]

        rounds = data.map({
            if let opponent = $0[0].sign, let response = $0[1].sign {
                return Round(
                    opponent: opponent,
                    response: response
                )
            }
            return nil
        })

    }

}

struct Round {
    let opponent: HandSign
    let response: HandSign
    var result: Result {
        if opponent == response {
            return .draw
        } else if opponent == .rock && response == .scissors {
            return .lose
        } else if opponent == .scissors && response == .paper {
            return .lose
        } else if opponent == .paper && response == .rock {
            return .lose
        } else {
            return .win
        }
    }
    var score: Int {
        return response.points + result.points
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
    case "A", "X": return .rock
    case "B", "Y": return .paper
    case "C", "Z": return .scissors
    default: return nil
    }
  }
}

extension Array where Element == Int {
  func sum() -> Int {
    return self.reduce(0, +)
  }
}