import UIKit

final class OnboardingBuilder: BaseBuilder {
    
    override func build() -> ViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.onboarding)
        guard let vc = vc as? ViewController else {
            fatalError("Wrong identifier")
        }
        
        return vc
    }
    
}
