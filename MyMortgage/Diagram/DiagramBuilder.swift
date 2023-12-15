import UIKit

import UIKit

final class DiagramBuilder: BaseBuilder {

    override func build() -> DiagramViewController {
        
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.diagram)
        guard let vc = vc as? DiagramViewController else {
            fatalError("Wrong identifier")
            
        }
        
        return vc
    }
    
}
