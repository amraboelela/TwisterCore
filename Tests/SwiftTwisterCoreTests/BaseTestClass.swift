//
//  BaseTestClass.swift
//  SwiftTwisterCoreAppTests
//
//  Created by: Amr Aboelela on 2/18/21.
//

import XCTest
import Foundation
//import Dispatch
//import SwiftTwisterCore

@testable import SwiftTwisterCore

class BaseTestClass: XCTestCase {
    
    //var db : LevelDB?
    var twisterCore : TwisterCore?
    
    override func setUp() {
        super.setUp()
        twisterCore = TwisterCore()
        
        /*db = LevelDB(name: "TestDB")
        guard let db = db else {
            print("Database reference is not existent, failed to open / create database")
            return
        }
        db.removeAllValues()

        db.encoder = {(key: String, value: Data) -> Data? in
            do {
                let data = value
                #if TwisterServer || DEBUG
                return data
                #else
                return try data.encryptedWithSaltUsing(key: myDevice.id)
                #endif
            } catch {
                NSLog("Problem encoding data: \(error)")
                return nil
            }
        }
        db.decoder = {(key: String, data: Data) -> Data? in
            do {
                #if TwisterServer || DEBUG
                return data
                #else
                if let decryptedData = try data.decryptedWithSaltUsing(key: myDevice.id) {
                    return decryptedData
                } else {
                    return nil
                }
                #endif
            } catch {
                NSLog("Problem decoding data: \(data.simpleDescription) key: \(key) error: \(error)")
                return nil
            }
        }*/
    }
    
    override func tearDown() {
        twisterCore = nil
        //db?.close()
        //db = nil
        super.tearDown()
    }
}
