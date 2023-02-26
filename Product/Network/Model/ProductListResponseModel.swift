//
//  ProductListResponseModel.swift
//  Product
//
//  Created by Sangat Baral on 26/02/23.
//

import Foundation

// MARK: - ProductListResponseModelElement
struct ProductListResponseModel: Codable {
    let id: Int?
    let title: String?
    let price: Double?
    let description: String?
    let category: String?
    let image: String?
    let rating: Rating?
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}
