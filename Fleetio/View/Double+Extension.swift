//
//  Double+Extension.swift
//  Fleetio
//
//  Created by Amit Jain on 1/28/22.
//

import Foundation
extension Double  {
    func formatDouble() ->  String {
        return "$" + String(format: "%0.2f",  self)
    }
}
