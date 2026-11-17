import Foundation
import UIKit

class LicenseManager {
    static let shared = LicenseManager()
    
    // Hàm này giả lập gọi API server
    func checkLicense(key: String, completion: @escaping (Bool, String, String) -> Void) {
        let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? "unknown"
        
        // TẠM THỜI: Hardcode key test là MducXios
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if key == "MducXios" {
                completion(true, "28 ngày 20 giờ", deviceId)
            } else {
                completion(false, "Key không hợp lệ", "")
            }
        }
    }
}
