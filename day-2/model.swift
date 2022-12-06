public struct DataModel {

  let jsonFilename: String
  var data: [[String]]

  init(jsonFilename: String) {
    self.jsonFilename = jsonFilename
    let jsonData = try! Data(contentsOf: URL(fileURLWithPath: jsonFilename))
    let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options: [])
    self.data = jsonObject as! [[String]]
  }

  var shapes: [[Shape?]]? {
    if let data {
      return data.map({
        switch $0 {
        case "A", "X":
          return .rock
        case "B", "Y":
          return .paper
        case "C", "Z":
          return .scissors
        default:
          return nil
        }
      })
    }
    return nil
  }
  
  var score: Int? {
    if let shapes {
      return shapes.map({
        point($0[1]) + result(battle($0[0], $0[1]))
      }).reduce(0, +)
    }
    return nil
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

func battle(_ opponent: Shape, _ response: Shape) -> Result {

  if opponent == response {
    return .draw
  }

  switch (opponent, response) {
  case (.rock, .paper):
    return .win
  case (.rock, .scissors):
    return .lose
  case (.paper, .rock):
    return .lose
  case (.paper, .scissors):
    return .win
  case (.scissors, .rock):
    return .win
  case (.scissors, .paper):
    return .lose
  }

}

func point(_ shape: Shape) -> Int {
  switch shape {
  case .rock:
    return 1
  case .paper:
    return 2
  case .scissors:
    return 3
  }
}

func result(_ result: Result) -> Int {
  switch result {
  case .win:
    return 6
  case .lose:
    return 0
  case .draw:
    return 3
  }
}