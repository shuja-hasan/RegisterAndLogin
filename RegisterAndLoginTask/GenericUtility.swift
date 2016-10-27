//
//  GenericUtility.swift
//  RegisterAndLoginTask
//
//  Created by Shuja Hasan on 27/10/2016.
//  Copyright © 2016 Shuja Hasan. All rights reserved.
//

import Foundation
import UIKit

class GenericUtility: NSObject {
    
    static let sharedInstance = GenericUtility();
    
    func isValidEmail(emailAddress: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailAddress)
    }
    
}
