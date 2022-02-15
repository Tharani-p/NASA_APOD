//
//  NASAModel.swift
//  NASA_APOD
//
//  Created by Tharani on 15/02/22.
//

import Foundation

// MARK: - NASAModel
struct NASAModel: Codable {
    let date, explanation: String
    let hdurl: String
    let mediaType, serviceVersion, title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}
