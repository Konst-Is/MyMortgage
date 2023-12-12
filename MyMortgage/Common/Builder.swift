import UIKit

protocol Builder {
    
    associatedtype Controller
    func build() -> Controller
    
}

class BaseBuilder: Builder {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func build() -> UIViewController {
        fatalError("Should be overriten")
    }
    
}
