extension Double {
    
    var roundToTwoDecimalPlaces: Double {
        
        return Double((1e2 * self).rounded(.down) / 1e2)
    }
    
}
