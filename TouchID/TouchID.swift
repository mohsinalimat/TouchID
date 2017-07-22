//
//  TouchID.swift
//  TouchID
//
//  Created by Meniny on 15/8/8.
//  Copyright (c) 2015 Meniny. All rights reserved.
//
//  Powerd by Meniny.
//  See https://meniny.cn/ for more informations.
//

import Foundation
import LocalAuthentication

public typealias TouchIDEvaluateCompletionClosure = (_ success: Bool, _ error: Error?) -> Swift.Void

open class TouchID {
    
    /// is TouchID enabled for current device
    open static var isEnabled: Bool {
        return isTouchIDEnabled.isEnabled
    }
    
    open static var isTouchIDEnabled: (isEnabled: Bool, error: NSError?) {
        let context = LAContext()
        var error: NSError?
        return (context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error), error)
    }
    
    // MARK: - Evaluate
    /// Evaluate with `deviceOwnerAuthenticationWithBiometrics` Policy
    ///
    /// - Parameters:
    ///   - reason: Reason Message String
    ///   - fallbackTitle: Fallback Title String
    ///   - cancelTitle: Cancel Title String, Only Available on iOS 10.0 and later
    ///   - completion: Evaluation Completion Action
    open class func evaluate(reason: String,
                             fallbackTitle: String? = nil,
                             cancelTitle: String? = nil,
                             completion: @escaping TouchIDEvaluateCompletionClosure) {
        if !isEnabled {
            completion(false, LAError.touchIDNotAvailable as? Error)
            return
        }
        
        let context = LAContext()
        context.localizedFallbackTitle = fallbackTitle
        if #available(iOS 10.0, *) {
            context.localizedCancelTitle = cancelTitle
        }
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, error) in
            completion(success, error)
        }
    }

}
