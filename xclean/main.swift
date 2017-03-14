//
//  main.swift
//  xclean
//
//  Created by Deszip on 04/01/2017.
//  Copyright © 2017 Deszip. All rights reserved.
//

import Foundation

let environment = Environment()

if environment.helpOption.wasSet {
    environment.printUsage()
    environment.terminate()
}

if environment.versionOption.wasSet {
    environment.printVersion()
    environment.terminate()
}

let cleaner = Cleaner(environment: environment)

if environment.listOption.wasSet {
    cleaner.list(targetSignatures: TargetSignature.signaturesForOption(environment.listOption))
}

if environment.removeOption.wasSet {
    cleaner.remove(targetSignatures: TargetSignature.signaturesForOption(environment.removeOption))
}

environment.terminate()
