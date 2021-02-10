//
//  LevelDB.swift
//
//  Copyright 2011-2016 Pave Labs. All rights reserved.
//
//  Modified by: Amr Aboelela <amraboelela@gmail.com>
//  Date: Aug 2016
//
//  See LICENCE for details.
//

import Foundation
import twisterd

public typealias LevelDBKeyCallback = (String, UnsafeMutablePointer<Bool>) -> Void

public func SearchPathForDirectoriesInDomains(_ directory: FileManager.SearchPathDirectory, _ domainMask: FileManager.SearchPathDomainMask, _ expandTilde: Bool) -> [String] {
    let bundle = Bundle.main
    let bundlePath = bundle.bundlePath
    if domainMask == .userDomainMask {
        switch directory {
        case .libraryDirectory:
            return [bundlePath + "/Library"]
        case .documentDirectory:
            return [bundlePath + "/Documents"]
        default:
            break
        }
    }
    return [""]
}

open class TwisterCore {
    public let serialQueue = DispatchQueue(label: "org.amr.twisterCore")
    
    var name: String
    var path: String
	//public var dictionaryEncoder: (String, [String : Any]) -> Data?
    //public var dictionaryDecoder: (String, Data) -> [String : Any]?
    //public var encoder: (String, Data) -> Data?
    //public var decoder: (String, Data) -> Data?
    //public var db: UnsafeMutableRawPointer?
    
    // MARK: - Life cycle
    
    required public init(path: String, name: String) {
        //NSLog("LevelDB init")
        self.name = name
        //NSLog("LevelDB self.name: \(name)")
        self.path = path
        //NSLog("LevelDB path: \(path)")
        /*self.dictionaryEncoder = { key, value in
            #if DEBUG
            NSLog("No encoder block was set for this database [\(name)]")
            NSLog("Using a convenience encoder/decoder pair using NSKeyedArchiver.")
            #endif
            return key.data(using: .utf8)
        }
        //NSLog("LevelDB self.encoder")
        self.dictionaryDecoder = {key, data in
            return ["" : ""]
        }
        self.encoder = { key, value in
            #if DEBUG
            NSLog("No encoder block was set for this database [\(name)]")
            NSLog("Using a convenience encoder/decoder pair using NSKeyedArchiver.")
            #endif
            return key.data(using: .utf8)
        }
        //NSLog("LevelDB self.encoder")
        self.decoder = {key, data in
            return Data()
        }
        //NSLog("LevelDB self.decoder")
        #if os(Linux)
        do {
            let dirpath =  NSURL(fileURLWithPath:path).deletingLastPathComponent?.path ?? ""
            //NSLog("LevelDB dirpath: \(dirpath)")
            let fileManager = FileManager.default
            if !fileManager.fileExists(atPath: dirpath) {
                try fileManager.createDirectory(atPath: dirpath, withIntermediateDirectories:false, attributes:nil)
            }
            //NSLog("try FileManager.default")
        } catch {
            NSLog("Problem creating parent directory: \(error)")
        }
        #endif
        //self.open()*/
    }
    
    convenience public init(name: String) {
        self.init(path: name, name: name)
    }
    
    deinit {
        //self.close()
    }
    
    // MARK: - Class methods
    
    public class func getLibraryPath() -> String {
        #if os(Linux)
            let paths = SearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)
            return paths[0]
        #else
        let libraryDirectory = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
            return libraryDirectory.absoluteString
        #endif
    }
    
    // MARK: - Accessors
    
    open func description() -> String {
        return "<LevelDB:\(self) path: \(path)>"
    }
}
