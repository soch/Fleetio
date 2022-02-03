//
//  FuelEntry.swift
//  Fleetio
//
//  Created by Amit Jain on 1/28/22.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let fuelEntry = try? newJSONDecoder().decode(FuelEntry.self, from: jsonData)

import Foundation

// MARK: - FuelEntry
struct FuelEntry : Decodable {
    let id: Int
    let costPerHr, costPerKM, costPerMi: Double?
    let date: String
    let externalID: String?
    let fuelTypeID: Int?
    let fuelTypeName: String?
    let kpl: Double?
    let liters: String?
    let litersPerHr, lp100K, mpgUk, mpgUs: Double?
    let partial:Bool?
    let personal: Bool?
    let pricePerVolumeUnit: Double?
    let rawTransactionData:RawTransactionData?
    let reference, region: String?
    let reset: Bool?
    let ukGallons: String?
    let ukGallonsPerHr: Double?
    let usGallons: String
    let usGallonsPerHr: Double?
    let usageInHr, usageInKM, usageInMi: String?
    let vehicleID: Int?
    let vehicleName: String
    let vendorID:Int?
    let vendorName: String?
    let imagesCount, documentsCount, commentsCount: Int
    let isSample: Bool
    let customFields: CustomFields?
    @StringForcible var fuelEconomyForCurrentUser: String?
    let fuelEconomyUnitsForCurrentUser: String
    let totalAmount: Double
    let meterEntry: MeterEntry?
    let geolocation: Geolocation?
    let comments: [Comment?]
    let mapPreviews: MapPreviews
    let createdAt, updatedAt: String
    let attachmentPermissions: AttachmentPermissions
    let documents:[Document?]?
    let images: [Image?]
}

// MARK: - Comment
struct Comment: Decodable {
    let id: Int
    let title:String?
    let comment, commentableType: String
    let commentableID:Int?
    let userID: Int?
    let userFullName: String?
    let userImageURL: String?
    let createdAt, updatedAt: String
}


// MARK: - Image
struct Image: Decodable {
    let id: Int
    let imageableID:Int?
    let imageableType, fileName: String?
    let fileMIMEType:String?
    let fileSize: Int?
    let fileURL: String?
    let createdAt, updatedAt: String
    let fullURL: String?
}
// MARK: - RawTransactionData
struct RawTransactionData: Decodable  {
    let space, filler, gallons, odometer: String
    let pinPlain, siteCity, siteName, unitCost: String
    let siteState, billedFlag, cardSuffix, postingDate: String
    let productCode, productName, siteAddress, grossDollars: String
    let siteZipCode, accountNumber, vehicleNumber, fuelTaxAmount: String
    let sequenceNumber, driverLastName, recordTypeCode, transactionDate: String
    let transactionTime, departmentNumber, driverFirstName, fleetAccountNumber: String
    let licensePlateNumber, wexTransactionCode, driverMiddleInitial, companyVehicleNumber: String
    let volumeDiscountAmount, transactionSquenceNumber: String
}

// MARK: - Document
struct Document: Decodable  {
    let id: Int
    let name, description: String?
    let documentableID: Int?
    let documentableType, fileName: String?
    let fileMIMEType:String?
    let fileSize: Int?
    let createdAt, updatedAt: String
    let fileURL, fullFileURL: String?
}
// MARK: - AttachmentPermissions
struct AttachmentPermissions: Decodable {
}

// MARK: - CustomFields
struct CustomFields: Decodable {
    let expenseType, usedCard, cardNumber, fuelUnitNumber: String
    let testRestrictedCustomFields, secondTankGallons, juanTypeOfFuel: String
    let fuelUpState: String?
}

// MARK: - Geolocation
struct Geolocation: Decodable {
    let latitude, longitude, altitude: Double?
    let speed: Double?
    let accuracy: Double?
    let fleetioFuel: FleetioFuel?
    let gpsDevice: GpsDevice?
}

// MARK: - FleetioFuel
struct FleetioFuel: Decodable {
    let latitude, longitude, altitude: Double?
    let speed: Double?
    let accuracy: Double?
}

/* - Corrupted data on page 3
"gps_device": {
  "latitude": "20.694265",
  "longitude": "-103.385182"
},
 
 */
// MARK: - GpsDevice
struct GpsDevice: Decodable {
    let latitude, longitude, speed: ForceDouble?
//    @StringForcible var latitude: String?
//    @StringForcible var longitude: String?
//    @StringForcible var speed: String?
    
    // TODO: Data corruption fix
//    enum CodingKeys : CodingKeys {
//        case latitude, longitude, speed
//    }
//
//    var latitude, longitude, speed: Double?
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKey.self)
//        self.latitude = try? container.decodeIfPresent(Double.self, forKey: .latitude)
//        self.longitude = try? container.decodeIfPresent(Double.self, forKey: .longitude)
//        self.speed = try? container.decodeIfPresent(Double.self, forKey: .speed)
//    }
}

// MARK: - MapPreviews
struct MapPreviews: Decodable {
    let small, large, smallShort, largeShort: String?
}

// MARK: - MeterEntry
struct MeterEntry: Decodable {
    let id: Int
    let autoVoidedAt, category: String?
    let date: String
    let meterType: String?
    let meterableID: Int?
    let meterableType, value: String
    let vehicleID: Int?
    let void: Bool
    let type: String?
    let createdAt, updatedAt: String
}

enum StringOrDouble: Decodable {
    
    case string(String)
    case double(Double)
    
    init(from decoder: Decoder) throws {
        if let double = try? decoder.singleValueContainer().decode(Double.self) {
            self = .double(double)
            return
        }
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }
        throw Error.couldNotFindStringOrDouble
    }
    enum Error: Swift.Error {
        case couldNotFindStringOrDouble
    }
}

enum ForceDouble: Decodable {

    case string(Double)
    case double(Double)

    init(from decoder: Decoder) throws {
        if let double = try? decoder.singleValueContainer().decode(Double.self) {
            self = .double(double)
            return
        }
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(Double(string) ?? 0.0)
            return
        }
        throw Error.couldNotFindStringOrDouble
    }

    enum Error: Swift.Error {
        case couldNotFindStringOrDouble
    }
}
