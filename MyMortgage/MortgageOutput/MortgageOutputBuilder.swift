import UIKit

final class MortgageOutputBuilder: BaseBuilder {

    override func build() -> OutputViewController {
        
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.mortgageOutput)
        guard let vc = vc as? OutputViewController else {
            fatalError("Wrong identifier")
        }
        
        return vc
    }
    
}
