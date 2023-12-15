protocol ServiceContainer {
    
    var mortgageCalculator: MortgageCalculator { get }
    
}

final class ServiceContainerImpl: ServiceContainer {
    
    let mortgageCalculator: MortgageCalculator
    
    init() {
        self.mortgageCalculator = MortgageCalculatorImpl()
    }
    
}
