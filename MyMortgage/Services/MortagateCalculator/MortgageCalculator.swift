import Foundation

enum MortgateCalculatorError: Error {
    
    case noData
    case maxCostExceeded(maxCost: Int)
    case incorrectInitialPayment
    case termOfMortgageExceeded(maxTerm: Int)
    case incorrectMonthlyPayment
    case inflationExceeded(maxInflation: Int)
    
}

extension MortgateCalculatorError: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .noData: return "Вы не указали стоимость квартиры без ипотеки"
        case .maxCostExceeded(let maxCost):
            return "Cтоимость недвижимости без ипотеки превышает предельную для данной программы - \(maxCost) руб."
        case .incorrectInitialPayment:
            return "Первоначальный платёж должен быть меньше стоимости недвижимости без ипотеки"
        case .termOfMortgageExceeded(let maxTerm):
            return "Срок ипотеки превышает максимальный срок ипотеки в РФ - \(maxTerm) лет"
        case .incorrectMonthlyPayment:
            return "Ежемесячный платёж должен быть меньше для данных условий"
        case .inflationExceeded(let maxInflation):
            return "Годовой процент инфляции превышает предельный для данной программы - \(maxInflation) %"
        }
    }
    
}

protocol MortgageCalculator: AnyObject {
    
    func calculate(userMortgage: UserMortgage) -> Result<MortgageCalculatorResult, MortgateCalculatorError>
    
}

final class MortgageCalculatorImpl: MortgageCalculator {
    
    private enum MortgageCalculatorSettings {
       
        static let monthInYear = 12
        static let maxCost = 500_000_000
        static let maxTerm = 30
        static let maxInflation = 1000
        
    }
    
    func calculate(userMortgage: UserMortgage) -> Result<MortgageCalculatorResult, MortgateCalculatorError> {
        
        if let error = validate(userMortgage: userMortgage) {
            return .failure(error)
        }
        
        let totalCostWithoutInflation = userMortgage.initialPayment == 0 && userMortgage.monthlyPayment == 0
        ? userMortgage.costWithoutMortgage
        : userMortgage.initialPayment + userMortgage.termOfMortgage * MortgageCalculatorSettings.monthInYear * userMortgage.monthlyPayment
        
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
        
        guard userMortgage.costWithoutMortgage != 0 else {
            return .noData
        }
        
        guard (1...MortgageCalculatorSettings.maxCost).contains(userMortgage.costWithoutMortgage) else {
            return .maxCostExceeded(maxCost: MortgageCalculatorSettings.maxCost)
        }
        
        guard userMortgage.initialPayment < userMortgage.costWithoutMortgage else {
            return .incorrectInitialPayment
        }
        
        guard (0...MortgageCalculatorSettings.maxTerm).contains(userMortgage.termOfMortgage) else {
            return .termOfMortgageExceeded(maxTerm: MortgageCalculatorSettings.maxTerm)
        }
        
        guard userMortgage.monthlyPayment < (userMortgage.costWithoutMortgage - userMortgage.initialPayment) else {
            return .incorrectMonthlyPayment
        }
        
        guard (0...MortgageCalculatorSettings.maxInflation).contains(userMortgage.inflation) else {
            return .inflationExceeded(maxInflation: MortgageCalculatorSettings.maxInflation)
        }
        
        return nil
    }

}


