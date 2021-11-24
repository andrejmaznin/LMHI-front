import Foundation

struct TestResultsModel {
    let data: [String: String]
    
    init(main: String, blue: String, green: String, red: String, yellow: String) {
        data = ["main": main, "blue": blue, "green": green, "red": red, "yellow": yellow]
    }
}
