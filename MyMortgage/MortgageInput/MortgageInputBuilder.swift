import UIKit

final class MortgageInputBuilder: BaseBuilder {
    weak var calculator: MortgageCalculator!
    
    init(calculator: MortgageCalculator) {
        self.calculator = calculator
    }
    
    override func build() -> InputViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.mortgageInput)
        guard let vc = vc as? InputViewController else {
            fatalError("Wrong identifier")
        }
        
        vc.mortgageCalculator = calculator
        
        return vc
    }
    
}
