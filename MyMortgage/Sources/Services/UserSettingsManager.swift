import Foundation

final class UserSettingsManager {
    
    private enum UserDefaultsKey {
        
        static let isOnboardingPassed = "isOnboardingPassed"
        
    }
    
    static var isOnboardingPassed: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDefaultsKey.isOnboardingPassed)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.isOnboardingPassed)
        }
    }
    
}
