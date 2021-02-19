//
//  String.swift
//  SwiftTwisterCore
//
//  Created by Amr Aboelela on 8/22/16.
//  Copyright © 2016 Amr Aboelela. All rights reserved.
//
//  See LICENCE for details.
//

import Foundation

public extension String {
    
    var cString: UnsafeMutablePointer<Int8> {
        return UnsafeMutablePointer<Int8>(mutating: NSString(string: self).utf8String)!
    }
    
    static func fromCString(_ cString: UnsafeRawPointer, length: Int) -> String {
        if let result = NSString(bytes: cString, length: length, encoding: String.Encoding.utf8.rawValue) {
            return result as String
        } else {
            let data = Data(bytes: cString, count: length)
            let result = String(decoding: data, as: UTF8.self)
            NSLog("fromCString error result: \(result)")
            return result
        }
    }

    func truncate(length: Int, trailing: String = "…") -> String {
        if self.count > length {
            return String(self.prefix(length)) + trailing
        } else {
            return self
        }
    }
}
