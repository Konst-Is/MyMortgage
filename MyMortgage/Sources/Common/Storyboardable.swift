import UIKit

protocol Storyboardable {
    
    static func create() -> Self
    
}

extension Storyboardable where Self: UIViewController {
    
    static func create() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
    
}
