//
//  Date+Extensions.swift
//  Social
//
//  Created by John Crossley on 16/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

extension Date {
    var timestamp: TimeInterval {
        return self.timeIntervalSince1970
    }
}
