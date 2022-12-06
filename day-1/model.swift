public struct DataModel {

  let jsonFilename: String
  var data: [[Int]]

  init(jsonFilename: String) {

    self.jsonFilename = jsonFilename

    // Load and parse the JSON file
    let jsonData = try! Data(contentsOf: URL(fileURLWithPath: jsonFilename))
    let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options: [])

    // Convert the JSON object to an array of arrays of integers
    self.data = jsonObject as! [[Int]]

  }

  func maximumSum() -> Int? {

    // Find the maximum sum of integers by using the map method to sum the integers
    // in each array and then finding the maximum sum
    let sums = self.data.map { array in
      return array.reduce(0, +)
    }
    return sums.max()
    
  }

  func topThreeSums() -> Int {
    let sums = self.data.map({ row in row.reduce(0, +) }).sorted(by: >)
    let topThreeSums = Array(sums[0..<min(3, sums.count)]).reduce(0, +)
    return topThreeSums
  }

}