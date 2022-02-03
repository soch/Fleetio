//
//  String+Extension.swift
//  Fleetio
//
//  Created by Amit Jain on 1/29/22.
//

import Foundation
extension String  {
    func formatDateString() ->  String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'H:mm:ss.SSSSZ"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
            return dateFormatter.string(from: date)
        } else {
            return  ""
        }
    }
    
   
}
