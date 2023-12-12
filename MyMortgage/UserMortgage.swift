//
//  UserMortgage.swift
//  MyMortgage
//
//  Created by Константин on 05.12.2023.
//

import Foundation

struct UserMortgage {
    var costWithoutMortgage: Int
    var initialPayment: Int
    var termOfMortgage: Int
    var monthlyPayment: Int
    var inflation: Int
    
    init(costWithoutMortgage: Int = 0, initialPayment: Int = 0, termOfMortgage: Int = 0, monthlyPayment: Int = 0, inflation: Int = 0) {
        self.costWithoutMortgage = costWithoutMortgage
        self.initialPayment = initialPayment
        self.termOfMortgage = termOfMortgage
        self.monthlyPayment = monthlyPayment
        self.inflation = inflation
    }
}

