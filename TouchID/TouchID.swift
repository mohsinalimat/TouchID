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
    
    open static let kDefaultLAPolicy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
    
    /// is TouchID enabled for current device
    open static var isEnabled: Bool {
        return isTouchIDEnabled().isEnabled
    }
    
    /// is TouchID enabled for specific `LAPolicy`
    ///
    ///   - policy: LAPolicy, default is `deviceOwnerAuthenticationWithBiometrics`
    /// - Returns: isEnabled: Bool, error: NSError?
    open class func isTouchIDEnabled(policy: LAPolicy = TouchID.kDefaultLAPolicy) -> (isEnabled: Bool, error: NSError?) {
        let context = LAContext()
        var error: NSError?
        return (context.canEvaluatePolicy(policy, error: &error), error)
    }
    
    // MARK: - Evaluate
    /// Evaluate with `deviceOwnerAuthenticationWithBiometrics` Policy
    ///
    /// - Parameters:
    ///   - policy: LAPolicy, default is `deviceOwnerAuthenticationWithBiometrics`
    ///   - reason: Reason Message String
    ///   - fallbackTitle: Fallback Title String
    ///   - cancelTitle: Cancel Title String, Only Available on iOS 10.0 and later
    ///   - completion: Evaluation Completion Action
    open class func evaluate(_ policy: LAPolicy = TouchID.kDefaultLAPolicy,
                             reason: String,
                             fallbackTitle: String? = nil,
                             cancelTitle: String? = nil,
                             completion: @escaping TouchIDEvaluateCompletionClosure) {
        if !isTouchIDEnabled(policy: policy).isEnabled {
            completion(false, LAError.touchIDNotAvailable as? Error)
            return
        }
        
        let context = LAContext()
        context.localizedFallbackTitle = fallbackTitle
        if #available(iOS 10.0, *) {
            context.localizedCancelTitle = cancelTitle
        }
        
        context.evaluatePolicy(policy, localizedReason: reason) { (success, error) in
            completion(success, error)
        }
    }
    
    // MARK: - Evaluate
    /// Evaluate with specific `SecAccessControl` and `LAAccessControlOperation`
    ///
    /// - Parameters:
    ///   - accessControl: `SecAccessControl`
    ///   - operation: `LAAccessControlOperation`
    ///   - reason: Reason Message String
    ///   - fallbackTitle: Fallback Title String
    ///   - cancelTitle: Cancel Title String, Only Available on iOS 10.0 and later
    ///   - completion: Evaluation Completion Action
    @available(iOS 9.0, *)
    open class func evaluate(_ accessControl: SecAccessControl,
                             operation: LAAccessControlOperation,
                             reason: String,
                             fallbackTitle: String? = nil,
                             cancelTitle: String? = nil,
                             completion: @escaping TouchIDEvaluateCompletionClosure) {
        let context = LAContext()
        context.localizedFallbackTitle = fallbackTitle
        if #available(iOS 10.0, *) {
            context.localizedCancelTitle = cancelTitle
        }
        context.evaluateAccessControl(accessControl, operation: operation, localizedReason: reason, reply: completion)
    }

}
