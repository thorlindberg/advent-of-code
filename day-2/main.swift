import Foundation
import model

let dataModel = DataModel(jsonFilename: "data.json")
let score = dataModel.score
print(score)