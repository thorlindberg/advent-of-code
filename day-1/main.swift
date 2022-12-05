import Foundation
import model

let dataModel = DataModel(jsonFilename: "data.json")

let maxSum = dataModel.maximumSum()
print(maxSum)

let topThreeSums = dataModel.topThreeSums()
print(topThreeSums)