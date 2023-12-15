import UIKit

extension UIColor {
    
    static func createFrom(red: Int, green: Int, blue: Int, alpha: Int) -> Self {
        return Self(red: CGFloat(red) / 255,
                    green: CGFloat(green) / 255,
                    blue: CGFloat(blue) / 255,
                    alpha: CGFloat(alpha))
    }
    
}
