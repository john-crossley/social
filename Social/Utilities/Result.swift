//
//  Result.swift
//  Social
//
//  Created by John Crossley on 11/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(String)
}
