//
//  FetchNewsDTO.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 17/10/21.
//

import Foundation

public extension CMSAPIEndPoint {
    
    struct FetchNewsDTO {
        
        static func path(source: String) -> String {
            return "v1/\(source)-news"
        }
        
        public struct Request {}
        
        public struct Response {
            var body: Body
        }
        
    }
    
}

extension CMSAPIEndPoint.FetchNewsDTO.Response {
    
    public struct Body: Codable {
        var data: [NewsResultDTO]
    }
    
    public struct NewsResultDTO: Codable {
        var title: String
        var link: String
        var description: String
        var isoDate: String
        var image: NewsResultImageDTO
    }
    
    public struct NewsResultImageDTO: Codable {
        var small: String
        var large: String
    }
    
}

public extension CMSAPIEndPoint.FetchNewsDTO.Response.NewsResultDTO {
    func toDomain() -> NewsDomain {
        return NewsDomain(
            title: self.title,
            sourceUrl: self.link,
            description: self.description,
            date: Date.isoDate(from: self.isoDate) ?? Date(),
            imageUrl: self.image.large
        )
    }
}
