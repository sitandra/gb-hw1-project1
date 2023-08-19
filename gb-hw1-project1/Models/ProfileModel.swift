//
//  ProfileModel.swift
//  gb-hw1-project1
//
//  Created by Юлия Дебелова on 20.08.2023.
//

struct ProfileModel: Decodable {
    var response: Profile
    
    struct Profile: Decodable {
        var photo: String
        var firstName: String
        var lastName: String
        
        enum CodingKeys: String, CodingKey {
            case photo = "photo_200"
            case firstName = "first_name"
            case lastName = "last_name"
        }
    }
}
