//
//  TwisterCore.h
//  SwiftTwisterCore
//
//  Created by Amr Aboelela on 2/18/21.
//

import Foundation
import CTwisterCore

open class TwisterCore {
    
    open func postsFor(username: String) -> String? {
        var rawData: UnsafeMutableRawPointer? = nil
        var rawDataLength: Int = 0
        let username = "bbc_world"
        let status = twisterCoreGetPosts(username.cString, username.count, 20, &rawData, &rawDataLength)
        if status != 0 {
            return nil
        }
        if let rawData = rawData {
            let data = Data(bytes: rawData, count: rawDataLength)
            return data.simpleDescription
        }
        return nil
    }
}
