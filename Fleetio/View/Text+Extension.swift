//
//  Text+Extension.swift
//  Voyager
//
//  Created by Amit Jain on 1/5/22.
//

import SwiftUI

extension Text {
    func formatHeader() -> some View {
        self
            .frame(width: 100, height: 30)
            .font(.system(size: 12.0, weight: .light))
    }
    
    func formatLongHeader() -> some View {
        self
            .frame(width: 150, height: 30)
            .font(.system(size: 12.0, weight: .light))
    }
    
    func formatCell() -> some View {
        self
            .frame(width: 100, height: 30)
            .font(.system(size: 14.0, weight: .regular))
    }
    
    func formatLongCell() -> some View {
        self
            .font(.system(size: 14.0, weight: .regular))
            .frame(minWidth: 150, idealWidth: 150, maxWidth: 200, maxHeight: 60)
            .fixedSize()
    }
}

