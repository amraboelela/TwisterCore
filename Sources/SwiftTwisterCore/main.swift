//
//  main.swift
//  SwiftTwisterCore
//
//  Created by Amr Aboelela on 2/18/21.
//

import Foundation
import CTwisterCore

print("hi")
let twisterCore = TwisterCore()
let result = twisterCore.postsFor(username: "bbc_world")
print("result: \(result)")
