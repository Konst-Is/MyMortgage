import Foundation

struct MortgageCalculatorResult {
   
    let costWithoutMortgage: Int
    let totalCostWithoutInflation: Int
    let totalCostAdjustedForInflation: Int
    let monthlyPaymentsAdjustedForInflation: [Int]
    
}

