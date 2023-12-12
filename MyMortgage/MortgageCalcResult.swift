//
//  MortgageCalcResult.swift
//  MyMortgage
//
//  Created by Константин on 05.12.2023.
//

import Foundation

struct MortgageCalcResult {
    var costWithoutMortgage: Int = 0
    var totalCostWithoutInflation: Int = 0
    var totalCostAdjustedForInflation: Int = 0
    var monthlyPaymentsAdjustedForInflation: [Int] = []
}

