import Foundation

protocol MortgageCalculator {
    var userMortgage: UserMortgage { get set }
    var mortgageCalcResult: MortgageCalcResult { get }
}

enum MortgageCalculatorSettings {
    static let monthInYear = 12
    static let maxCost = 200_000_000
    static let maxTerm = 30
    static let maxInflation = 1000
}

final class MortgageCalculatorImpl: MortgageCalculator {
    
    static let shared = MortgageCalculatorImpl()
    
    var userMortgage = UserMortgage()
    
    var mortgageCalcResult: MortgageCalcResult {
        guard self.isValid else {
            return MortgageCalcResult(costWithoutMortgage: 0, totalCostWithoutInflation: 0, totalCostAdjustedForInflation: 0, monthlyPaymentsAdjustedForInflation: [])
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
        
        return MortgageCalcResult(costWithoutMortgage: userMortgage.costWithoutMortgage, totalCostWithoutInflation: totalCostWithoutInflation, totalCostAdjustedForInflation: totalCostAdjustedForInflation, monthlyPaymentsAdjustedForInflation: monthlyPaymentsAdjustedForInflation)
    }
    
    var isValid: Bool {
        guard (0...MortgageCalculatorSettings.maxCost).contains(userMortgage.costWithoutMortgage) else { return false }
        guard userMortgage.initialPayment < userMortgage.costWithoutMortgage else { return false }
        guard (0...MortgageCalculatorSettings.maxTerm).contains(userMortgage.termOfMortgage) else { return false }
        guard userMortgage.monthlyPayment < (userMortgage.costWithoutMortgage / 12) else { return false }
        guard (0...MortgageCalculatorSettings.maxInflation).contains(userMortgage.inflation) else { return false }
        guard userMortgage.costWithoutMortgage != userMortgage.initialPayment else { return userMortgage.monthlyPayment == 0 }
        return true
    }
    
    
    private init() {}
}


