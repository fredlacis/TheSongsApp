//
//  Double.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 29/09/23.
//

import CoreMedia

extension Double {
    
    var formattedAsHourMinSec: String {
        let totalSeconds = Int(self)
        let hours:Int = Int(totalSeconds / 3600)
        let minutes:Int = Int(totalSeconds % 3600 / 60)
        let seconds:Int = Int((totalSeconds % 3600) % 60)

        if hours > 0 {
            return String(format: "%i:%02i:%02i", hours, minutes, seconds)
        }
        
        return String(format: "%i:%02i", minutes, seconds)
    }
    
}
