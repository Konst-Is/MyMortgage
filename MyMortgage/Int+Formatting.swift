import Foundation

extension Int {
    var formatted: String {
        var str = ""
        var count = 0
        for number in String(abs(self)).reversed() {
            if count == 3 {
                str = String(number) + " " + str
                count = 1
            } else {
                str = String(number) + str
                count += 1
            }
        }
        return self < 0 ? "-" + str : str
    }
}
