import Foundation

public struct DataModel {

  var data: [Range]

  init(path: String) {
    var file: String? = File.read(path)
    if let file {
      let pairs: [String] = file.components(separatedBy: "\n")
      pairs.map({
        $0.components(separatedBy: ",").map({
          let pair: [String] = $0.components(separatedBy: "-")
          return Pair(
            lower: Int(pair.first),
            upper: Int(pair.last)
          )
        })
      })
    }
  }

}

struct Pair {
  let lower: Int
  let upper: Int
  var range: Range {
    lower...upper
  }
}

extension Array where Element == Pair {
  var overlapping: Bool {
    for pair in self {
      //
    }
  }
}

extension Array where Element == Int {
  var sum: Int {
    self.reduce(0, +)
  }
}