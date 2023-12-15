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
            let onboardingController = OnboardingBuilder().build()
            onboardingController.coordinator = self
            navigationController.pushViewController(onboardingController, animated: false)
            return
        }
        
        openMortgageInput()
    }
    
    func openMortgageInput() {
        let mortgageInputController = MortgageInputBuilder(calculator: serviceContainer.mortgageCalculator).build()
        mortgageInputController.coordinator = self
        navigationController.pushViewController(mortgageInputController, animated: true)
    }
    
    func openMortgageOutput(mortgageCalculatorResult: MortgageCalculatorResult) {
        let mortgageOutputController = MortgageOutputBuilder().build()
        mortgageOutputController.coordinator = self
        mortgageOutputController.mortgageCalculatorResult = mortgageCalculatorResult
        navigationController.pushViewController(mortgageOutputController, animated: true)
    }
    
    func openDiagram(mortgageCalculatorResult: MortgageCalculatorResult) {
        let diagramController = DiagramBuilder().build()
        diagramController.mortgageCalculatorResult = mortgageCalculatorResult
        navigationController.pushViewController(diagramController, animated: true)
    }
    
}
