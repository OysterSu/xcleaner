//
//  Target.swift
//  xclean
//
//  Created by Deszip on 04/01/2017.
//  Copyright © 2017 Deszip. All rights reserved.
//

import Foundation

enum TargetType {
    case derivedData
    case archives
    case deviceSupport
    case coreSimulator
    case iphoneSimulator
    case xcodeCaches
    case backup
    case docSets
    
    case all
}

struct TargetSignature: Equatable {
    
    static let derivedDataPath          = "~/Library/Developer/Xcode/DerivedData"
    static let archivesPath             = "~/Library/Developer/Xcode/Archives"
    static let deviceSupportIOSPath     = "~/Library/Developer/Xcode/iOS DeviceSupport"
    static let deviceSupportWatchOSPath = "~/Library/Developer/Xcode/watchOS DeviceSupport"
    static let coreSimulatorUserPath    = "~/Library/Developer/CoreSimulator"
    static let coreSimulatorSystemPath  = "/Library/Developer/CoreSimulator"
    static let iphoneSimulatorPath      = "~/Library/Application Support/iPhone Simulator"
    static let xcodeCachesPath          = "~/Library/Caches/com.apple.dt.Xcode"
    static let backupPath               = "~/Library/Application Support/MobileSync/Backup"
    static let docSetsPath              = "~/Library/Developer/Shared/Documentation/DocSets"
    
    let type: TargetType
    let pathes:[NSURL]
    
    
    init(type: TargetType) {
        self.type = type
        switch type {
            case .derivedData: self.pathes      = [TargetSignature.urlForPath(TargetSignature.derivedDataPath)]
            case .archives: self.pathes         = [TargetSignature.urlForPath(TargetSignature.archivesPath)]
            case .deviceSupport: self.pathes    = [TargetSignature.urlForPath(TargetSignature.deviceSupportIOSPath),
                                                   TargetSignature.urlForPath(TargetSignature.deviceSupportWatchOSPath)]
            case .coreSimulator: self.pathes    = [TargetSignature.urlForPath(TargetSignature.coreSimulatorUserPath),
                                                   TargetSignature.urlForPath(TargetSignature.coreSimulatorSystemPath)]
            case .iphoneSimulator: self.pathes  = [TargetSignature.urlForPath(TargetSignature.iphoneSimulatorPath)]
            case .xcodeCaches: self.pathes      = [TargetSignature.urlForPath(TargetSignature.xcodeCachesPath)]
            case .backup: self.pathes           = [TargetSignature.urlForPath(TargetSignature.backupPath)]
            case .docSets: self.pathes          = [TargetSignature.urlForPath(TargetSignature.docSetsPath)]
            
            default: self.pathes = []
        }
    }
    
    static func all() -> [TargetSignature] {
        return [TargetSignature(type: TargetType.derivedData),
                TargetSignature(type: TargetType.archives),
                TargetSignature(type: TargetType.deviceSupport),
                TargetSignature(type: TargetType.coreSimulator),
                TargetSignature(type: TargetType.iphoneSimulator),
                TargetSignature(type: TargetType.xcodeCaches),
                TargetSignature(type: TargetType.backup),
                TargetSignature(type: TargetType.docSets)]
    }
    
    private static func urlForPath(_ path: String) -> NSURL {
        let expandedPath = NSString(string: (path as NSString).expandingTildeInPath) as String
        return NSURL(fileURLWithPath: expandedPath, isDirectory: true)
    }
}

func ==(lhs: TargetSignature, rhs: TargetSignature) -> Bool {
    return lhs.type == rhs.type
}

protocol Target {
    var signature: TargetSignature { get }
    var name: String { get }
    
    func updateMetadata()
    
    func metadataDescription() -> String
    func safeSize() -> Int64
    func clean()
}