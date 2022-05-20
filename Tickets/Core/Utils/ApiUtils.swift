//
//  ApiUtils.swift
//  Tickets (iOS)
//
//  Created by Stevan Rakic on 19.5.22..
//

import Foundation


enum ApiUtils {
    
    static func getImageUrl(imagePath: String) -> String {
        let uriString = "//\(APIConstants.host)/\(APIConstants.appPath)\(imagePath)"
        
        var urlComponents = URLComponents(string: uriString)!
        if urlComponents.scheme == nil { urlComponents.scheme = "https" }
        return urlComponents.url!.absoluteString
    }
    
    
}

extension DiscountEntity {
    
    var imageUrl: String {
        guard let photo = photo else { return "" }
        return ApiUtils.getImageUrl(imagePath: photo)
    }
    
}

extension EventEntity {
    var imageUrl: String {
        guard let photo = photo else { return "" }
        return ApiUtils.getImageUrl(imagePath: photo)
    }
}
