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
            static let get = API + "friends.get?fields=bdate&" + endpoint.auth
        }
        enum userGroups {
            static let get = API + "groups.get?extended=1&fields=name&offset=0&count=10&" + endpoint.auth
        }
        enum userPhotos {
            static let get = API + "photos.get?album_id=wall&offset=0&count=10&" + endpoint.auth
        }
    }
    
    func getFriends() {
        let url = URL(string: endpoint.userFriends.get)
        guard let url else { return }
        session.dataTask(with: url) { (data, _, error) in
            guard let data else { return }
            do {
                let friends = try JSONDecoder().decode(FriendModel.self, from: data)
                print(friends)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getGroups() {
        let url = URL(string: endpoint.userGroups.get)
        guard let url else { return }
        session.dataTask(with: url) { (data, _, error) in
            guard let data else { return }
            do {
                let groups = try JSONDecoder().decode(GroupModel.self, from: data)
                print(groups)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getPhotos() {
        let url = URL(string: endpoint.userPhotos.get)
        guard let url else { return }
        session.dataTask(with: url) { (data, _, error) in
            guard let data else { return }
            do {
                let photos = try JSONDecoder().decode(PhotoModel.self, from: data)
                print(photos)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    /*func getData() {
        let url = URL(string: "https://kudago.com/public-api/v1.2/locations/?lang=ru&fields=timezone,name,currency,coords")
        guard let url else {
            return
        }
        session.dataTask(with: url) { (data, _, error) in
            guard let data else {
                return
            }
            do {
                let towns = try
                JSONDecoder().decode([TownModel].self, from: data)
                print(towns)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getCat(with code:Int) {
        let url = URL(string: "https://http.cat/" + String(code))
        guard let url else { return }
        session.dataTask(with: url) { (data, _, _) in
            print(data)
        }.resume()
    }
    
    func getNews() {
        let url = URL (string: "https://kudago.com/public-api/v1.2/news/?fields=publication_date,title,body_text&text_format=text&actual_only=true")
        // безопаснее, чем ! после url:
        // guard let url else { return }
        session.dataTask(with: url!) { (data, _, error) in
            guard let data else { return }
            do {
                let news = try JSONDecoder().decode(NewsModel.self, from: data)
                print(news)
            } catch {
                print(error)
            }
        }.resume()
    }*/
}
