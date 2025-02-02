//
//  NYTResponse.swift
//  NYTimesApp
//
//  Created by Muhammad Iqbal on 31/01/2025.
//

import Foundation

struct NYTResponse: Decodable {
    let status: String?
    let copyright: String?
    let numResults: Int?
    let results: [Article]?

    enum CodingKeys: String, CodingKey {
        case status
        case copyright
        case numResults = "num_results"
        case results
    }
    
    init(status: String? = nil, copyright: String? = nil, numResults: Int? = nil, results: [Article]? = nil) {
        self.status = status
        self.copyright = copyright
        self.numResults = numResults
        self.results = results
    }
}
