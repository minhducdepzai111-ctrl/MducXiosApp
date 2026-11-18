import Foundation
import UIKit

class LicenseManager {
    static let shared = LicenseManager()
    
    func checkLicense(key: String, completion: @escaping (Bool, String, String) -> Void) {
        let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? "unknown"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if key == "MducXios" {
                completion(true, "28 ngày 20 giờ", deviceId)
            } else {
                completion(false, "Key không hợp lệ", "")
            }
        }
    }
}
