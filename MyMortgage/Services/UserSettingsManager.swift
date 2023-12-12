import Foundation

final class UserSettingsManager {
    
    private enum UserDefaultsKey {
        static let missInformation = "missInformation"
    }
    
    static var isOnboardingPassed: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDefaultsKey.missInformation)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.missInformation)
            print("Установлено новое значение в UserDefaults \(newValue)")
        }
    }
    
}
