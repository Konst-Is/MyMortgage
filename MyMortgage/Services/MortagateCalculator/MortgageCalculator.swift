import Foundation

enum MortgateCalculatorError: Error {
    case maxCost
    case initPayment
    case termOfMortgage
    case costWithoutMortgage
    case inflation
    case costNotEqualInitialPayment
}

protocol MortgageCalculator: AnyObject {
    func calculate(userMortgage: UserMortgage) -> Result<MortgageCalculatorResult, MortgateCalculatorError>
}

final class MortgageCalculatorImpl: MortgageCalculator {
    
    private enum MortgageCalculatorSettings {
        static let monthInYear = 12
        static let maxCost = 200_000_000
        static let maxTerm = 30
        static let maxInflation = 1000
    }
    
    func calculate(userMortgage: UserMortgage) -> Result<MortgageCalculatorResult, MortgateCalculatorError> {
        if let error = validate(userMortgage: userMortgage) {
            return .failure(error)
        }
        
        let totalCostWithoutInflation = userMortgage.initialPayment + userMortgage.termOfMortgage * MortgageCalculatorSettings.monthInYear * userMortgage.monthlyPayment
        var totalCostAdjustedForInflation = userMortgage.termOfMortgage == 0
        ? userMortgage.costWithoutMortgage
        : userMortgage.initialPayment + MortgageCalculatorSettings.monthInYear * userMortgage.monthlyPayment
        var monthlyPaymentAdjustedForInflation = userMortgage.monthlyPayment
        var monthlyPaymentsAdjustedForInflation = [monthlyPaymentAdjustedForInflation]
        if userMortgage.termOfMortgage > 1 {
            for _ in 2...userMortgage.termOfMortgage {
                monthlyPaymentAdjustedForInflation = Int(Double(monthlyPaymentAdjustedForInflation) / (1.0 + Double(userMortgage.inflation) / 100.0))
                monthlyPaymentsAdjustedForInflation.append(monthlyPaymentAdjustedForInflation)
                totalCostAdjustedForInflation += MortgageCalculatorSettings.monthInYear * monthlyPaymentAdjustedForInflation
            }
        }
        
        return .success(MortgageCalculatorResult(costWithoutMortgage: userMortgage.costWithoutMortgage,
                                           totalCostWithoutInflation: totalCostWithoutInflation,
                                           totalCostAdjustedForInflation: totalCostAdjustedForInflation,
                                           monthlyPaymentsAdjustedForInflation: monthlyPaymentsAdjustedForInflation))
    }
    
    private func validate(userMortgage: UserMortgage) -> MortgateCalculatorError? {
        guard (0...MortgageCalculatorSettings.maxCost).contains(userMortgage.costWithoutMortgage) else {
            return .maxCost
        }
        
        guard userMortgage.initialPayment < userMortgage.costWithoutMortgage else {
            return .initPayment
        }
        
        guard (0...MortgageCalculatorSettings.maxTerm).contains(userMortgage.termOfMortgage) else {
            return .termOfMortgage
        }
        
        guard userMortgage.monthlyPayment < (userMortgage.costWithoutMortgage / 12) else {
            return .costWithoutMortgage
        }
        
        guard (0...MortgageCalculatorSettings.maxInflation).contains(userMortgage.inflation) else {
            return .inflation
        }
        
        // FIXME
        
//        guard userMortgage.costWithoutMortgage == userMortgage.initialPayment && userMortgage.monthlyPayment != 0 else {
//            return .costNotEqualInitialPayment
//        }
        
        return nil
    }

}


