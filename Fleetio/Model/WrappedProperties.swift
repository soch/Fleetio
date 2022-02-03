//
//  WrappedProperties.swift
//  Fleetio
//
//  Created by Amit Jain on 1/28/22.
//

import Foundation
@propertyWrapper
struct StringForcible: Codable {
    
    var wrappedValue: String?
    
    enum CodingKeys: CodingKey {}
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let string = try? container.decode(String.self) {
            wrappedValue = string
        } else if let integer = try? container.decode(Int.self) {
            wrappedValue = "\(integer)"
        } else if let double = try? container.decode(Double.self) {
            wrappedValue = "\(double)"
        } else if container.decodeNil() {
            wrappedValue = nil
        }
        else {
            throw DecodingError.typeMismatch(String.self, .init(codingPath: container.codingPath, debugDescription: "Could not decode incoming value to String. It is not a type of String, Int or Double."))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
    
    init() {
        self.wrappedValue = nil
    }
    
}

//https://stackoverflow.com/questions/47935705/using-codable-with-value-that-is-sometimes-an-int-and-other-times-a-string
@propertyWrapper
struct DoubleForcible: Codable {
    
    var wrappedValue: Double?
    
    enum CodingKeys: CodingKey {}
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let double = try? container.decode(Double.self) {
            wrappedValue = double
        } else if let string = try? container.decode(String.self) {
            wrappedValue = Double(string)
        } else if let integer = try? container.decode(Int.self) {
            wrappedValue = Double(integer)
        } else if container.decodeNil() {
            wrappedValue = nil
        }
        else {
            throw DecodingError.typeMismatch(String.self, .init(codingPath: container.codingPath, debugDescription: "Could not decode incoming value to Double. It is not a type of String, Int or Double."))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
    
    init() {
        self.wrappedValue = nil
    }
    
}


@propertyWrapper struct Flexible<T: FlexibleDecodable>: Decodable {
    var wrappedValue: T
    
    init(from decoder: Decoder) throws {
        wrappedValue = try T(container: decoder.singleValueContainer())
    }
}

protocol FlexibleDecodable {
    init(container: SingleValueDecodingContainer) throws
}

extension Double: FlexibleDecodable {
    init(container: SingleValueDecodingContainer) throws {
        if let double = try? container.decode(Double.self) {
            self = double
        } else if let string = try? container.decode(String.self), let double = Double(string) {
            self = double
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Invalid double value"))
        }
    }
}
