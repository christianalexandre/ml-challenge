//
//  SearchError.swift
//  ml-challenge
//
//  Created by Christian Alberton Alexandre on 23/06/24.
//

import Foundation

enum SearchError: Error {
    case noResults
    case offsetError
    case unknownError
    case imageDownloadError

    var localizedDescription: String {
        switch self {
        case .noResults:
            return String(localized: "SEARCH_NO_RESULTS")
        case .offsetError:
            return String(localized: "OFFSET_GREATER_THAN_1000_LIMIT")
        case .unknownError:
            return String(localized: "SEARCH_UNKNOWN_ERROR")
        case .imageDownloadError:
            return String(localized: "IMAGE_DOWNLOAD_ERROR")
        }
    }
}

