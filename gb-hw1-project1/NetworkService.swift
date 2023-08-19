//
//  NetworkService.swift
//  gb-hw1-project1
//
//  Created by Юлия Дебелова on 12.08.2023.
//

import Foundation
final class NetworkService {
    private let session = URLSession.shared
    
    static var token = ""
    static var userID = ""
    static let API = "https://api.vk.com/method/"
    
    enum endpoint {
        static let auth = "user_ids=" + userID + "&access_token=" + token + "&v=5.131"
        enum userFriends {
            static let get = API + "friends.get?fields=photo_50,online&" + endpoint.auth
        }
        enum userGroups {
            static let get = API + "groups.get?extended=1&fields=name,description&offset=0&count=10&" + endpoint.auth
        }
        enum userPhotos {
            static let get = API + "photos.get?album_id=wall&offset=0&count=50&" + endpoint.auth
        }
    }
    
    func getFriends(completion: @escaping (FriendModel) -> Void) {
        let url = URL(string: endpoint.userFriends.get)
        guard let url else { return }
        session.dataTask(with: url) { (data, _, error) in
            guard let data else { return }
            do {
                let friends = try JSONDecoder().decode(FriendModel.self, from: data)
                completion(friends)
                //print(friends)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getGroups(completion: @escaping (GroupModel) -> Void) {
        let url = URL(string: endpoint.userGroups.get)
        guard let url else { return }
        session.dataTask(with: url) { (data, _, error) in
            guard let data else { return }
            do {
                let groups = try JSONDecoder().decode(GroupModel.self, from: data)
                completion(groups)
                //print(groups)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getPhotos(completion: @escaping (PhotoModel) -> Void) {
        let url = URL(string: endpoint.userPhotos.get)
        guard let url else { return }
        session.dataTask(with: url) { (data, _, error) in
            guard let data else { return }
            do {
                let photos = try JSONDecoder().decode(PhotoModel.self, from: data)
                completion(photos)
                //print(photos)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getPhoto(imageURL: String?, completion: @escaping (Data) -> Void) {
        DispatchQueue.global().async {
            if let url = URL(string: imageURL ?? ""), let data = try? Data(contentsOf: url) {
                //DispatchQueue.main.async {
                    completion(data)
                //}
            }
        }
    }
}
