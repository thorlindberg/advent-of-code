public struct DataModel {

  var rounds: [Round]
  var score: Int {
    return self.rounds.map({$0.score}).reduce(0, +)
  }

  init(jsonFilename: String) {

    let jsonData = try! Data(contentsOf: URL(fileURLWithPath: jsonFilename))
    let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options: [])
    let data = jsonObject as! [[String]]

    self.rounds = data.map({
      Round(
        opponent: $0[0],
        response: $0[1]
      )
    })

  }
}

struct Round {
  let opponent: Shape
  let response: Shape
  var score: Int {

    var points: Int = 0
    var result: Result?

    switch (opponent, response) {
    case (.rock, .rock):
      result = .draw
    case (.rock, .paper):
      result = .win
    case (.rock, .scissors):
      result = .lose
    case (.paper, .rock):
      result = .lose
    case (.paper, .paper):
      result = .draw
    case (.paper, .scissors):
      result = .win
    case (.scissors, .rock):
      result = .win
    case (.scissors, .paper):
      result = .lose
    case (.scissors, .scissors):
      result = .draw
    }

    switch response {
    case .rock:
      points += 1
    case .paper:
      points += 2
    case .scissors:
      points += 3
    }

    if let result {
      switch result {
      case .win:
        points += 6
      case .lose:
        points += 0
      case .draw:
        points += 3
      }
    }

    return points
    
  }

}

enum Shape {
  case rock
  case paper
  case scissors
}

enum Result {
  case win
  case lose
  case draw
}