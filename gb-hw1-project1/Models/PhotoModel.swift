//
//  PhotoModel.swift
//  gb-hw1-project1
//
//  Created by Юлия Дебелова on 13.08.2023.
//

struct PhotoModel: Decodable {
    var response: PhotoResponse
    
    struct PhotoResponse: Decodable {
        var count: Int
        var items: [Photo]
        
        struct Photo: Decodable {
            var id: Int
            var sizes: [Size]
            
            struct Size: Decodable {
                var height: UInt
                var type: String
                var width: UInt
                var url: String
            }
        }
    }
}
