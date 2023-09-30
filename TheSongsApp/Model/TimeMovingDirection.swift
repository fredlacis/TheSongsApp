//
//  TimeMovingDirection.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 30/09/23.
//

import Foundation

enum TimeMovingDirection {
    
    case forward
    case backward
    
    var seconds: Int64 {
        switch self {
            case .forward:
                return 5
            case .backward:
                return -5
        }
    }
    
}
