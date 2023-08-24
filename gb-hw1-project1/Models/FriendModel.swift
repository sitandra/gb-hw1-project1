//
//  FriendModel.swift
//  gb-hw1-project1
//
//  Created by Юлия Дебелова on 13.08.2023.
//

struct FriendModel: Decodable {
    var response: FriendResponse
    
    struct FriendResponse: Decodable {
        var count: Int
        var items: [Friend]
        
        struct Friend: Decodable {
            var id: Int32
            //var bdate: String?
            //var trackCode: String
            var photoIcon: String?
            var isOnline: Int
            var firstName: String
            var lastName: String
            //var canAccessClosed: Bool
            //var isClosed: Bool
            enum CodingKeys: String, CodingKey {
                case id
                //case bdate
                //case trackCode = "track_code"
                case photoIcon = "photo_200_orig"
                case isOnline = "online"
                case firstName = "first_name"
                case lastName = "last_name"
                //case canAccessClosed = "can_access_closed"
                //case isClosed = "is_closed"
            }
        }
    }
}
