//
//  GroupModel.swift
//  gb-hw1-project1
//
//  Created by Юлия Дебелова on 13.08.2023.
//

struct GroupModel: Decodable {
    var response: GroupResponse
    
    struct GroupResponse:Decodable {
        var count: Int
        var items: [UserGroup]
        
        struct UserGroup: Decodable {
            var id: Int32
            var name: String
        }
    }
}
