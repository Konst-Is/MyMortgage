import UIKit

protocol Coordinator: AnyObject {
    
    func start()
    func openMortgageInput()
    func openMortgageOutput(mortgageCalculatorResult: MortgageCalculatorResult)
    func openDiagram(mortgageCalculatorResult: MortgageCalculatorResult)
    
}

protocol Coordinatable {
    
    var coordinator: Coordinator? { get set }
    
}

final class CoordinatorImpl: Coordinator {

    private let navigationController: UINavigationController
    private let serviceContainer: ServiceContainer
    
    init(navigationController: UINavigationController,
         serviceContainer: ServiceContainer) {
        self.navigationController = navigationController
        self.serviceContainer = serviceContainer
    }
    
    func start() {
        guard UserSettingsManager.isOnboardingPassed else {
            let onboardingController = ViewController.create()
            onboardingController.coordinator = self
            navigationController.pushViewController(onboardingController, animated: false)
            return
        }
        
        openMortgageInput()
    }
    
    func openMortgageInput() {
        let mortgageInputController = InputViewController.create()
        mortgageInputController.mortgageCalculator = serviceContainer.mortgageCalculator
        mortgageInputController.coordinator = self
        navigationController.pushViewController(mortgageInputController, animated: true)
    }
    
    func openMortgageOutput(mortgageCalculatorResult: MortgageCalculatorResult) {
        let mortgageOutputController = OutputViewController.create()
        mortgageOutputController.coordinator = self
        mortgageOutputController.mortgageCalculatorResult = mortgageCalculatorResult
        navigationController.pushViewController(mortgageOutputController, animated: true)
    }
    
    func openDiagram(mortgageCalculatorResult: MortgageCalculatorResult) {
        let diagramController = DiagramViewController.create()
        diagramController.mortgageCalculatorResult = mortgageCalculatorResult
        navigationController.pushViewController(diagramController, animated: true)
    }
    
}
