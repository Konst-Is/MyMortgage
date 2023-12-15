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
