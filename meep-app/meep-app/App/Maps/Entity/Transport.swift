//
//  Transport.swift
//  meep-app
//
//  Created by David Garcia on 27/07/2020.
//  Copyright © 2020 David Garcia. All rights reserved.
//

import Foundation

struct TransportElement: Codable {
    let id, name: String
    let x, y: Double
    let scheduledArrival, locationType: Int?
    let companyZoneID: Int
    let lat, lon: Double?
    let licencePlate: String?
    let range, batteryLevel, seats: Int?
    let model: Model?
    let resourceImageID: ResourceImageID?
    let realTimeData: Bool?
    let resourceType: ResourceType?
    let helmets: Int?
    let station: Bool?
    let availableResources, spacesAvailable: Int?
    let allowDropoff: Bool?
    let bikesAvailable: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, x, y, scheduledArrival, locationType
        case companyZoneID = "companyZoneId"
        case lat, lon, licencePlate, range, batteryLevel, seats, model
        case resourceImageID = "resourceImageId"
        case realTimeData, resourceType, helmets, station, availableResources, spacesAvailable, allowDropoff, bikesAvailable
    }
}

enum Model: String, Codable {
    case askoll = "Askoll"
    case nullDS3 = "null DS3"
}

enum ResourceImageID: String, Codable {
    case vehicleGenEcooltra = "vehicle_gen_ecooltra"
    case vehicleGenEmov = "vehicle_gen_emov"
}

enum ResourceType: String, Codable {
    case electricCar = "ELECTRIC_CAR"
    case moped = "MOPED"
}

typealias Transport = [TransportElement]
