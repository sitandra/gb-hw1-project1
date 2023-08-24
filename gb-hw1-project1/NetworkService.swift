//
//  NetworkService.swift
//  gb-hw1-project1
//
//  Created by Юлия Дебелова on 12.08.2023.
//

import Foundation
import Network

final class NetworkService {
    enum NetworkError: Error {
        case dataError
        case networkError
    }
    private let session = URLSession.shared
    //private let monitor = NWPathMonitor()
    
    static var token = ""
    static var userID = ""
    private static let API = "https://api.vk.com/method/"
    
    enum endpoint {
        private static let auth = "user_ids=" + userID + "&access_token=" + token + "&v=5.131"
        private static let shotAuth = "access_token=" + token + "&v=5.131"
        enum account {
            static let getProfileInfo = API + "account.getProfileInfo?" + endpoint.shotAuth
        }
        enum userFriends {
            static let get = API + "friends.get?fields=photo_200_orig,online&" + endpoint.auth
        }
        enum userGroups {
            static let get = API + "groups.get?extended=1&fields=name,description&offset=0&count=10&" + endpoint.auth
        }
        enum userPhotos {
            static let get = API + "photos.get?album_id=wall&offset=0&count=50&" + endpoint.auth
        }
    }
    
    func getFriends(completion: @escaping (Result<FriendModel, Error>) -> Void) {
        let url = URL(string: endpoint.userFriends.get)
        guard let url else { return }
        /*if monitor.currentPath.status == .unsatisfied {
            completion(.failure(NetworkError.networkError))
            return
        }*/
        session.dataTask(with: url) { (data, _, error) in
            guard let data else {
                completion(.failure(NetworkError.dataError))
                return
            }
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let response = try JSONDecoder().decode(FriendModel.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getGroups(completion: @escaping (Result<GroupModel, Error>) -> Void) {
        let url = URL(string: endpoint.userGroups.get)
        guard let url else { return }
        session.dataTask(with: url) { (data, _, error) in
            guard let data else {
                completion(.failure(NetworkError.dataError))
                return
            }
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let response = try JSONDecoder().decode(GroupModel.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getPhotos(completion: @escaping (PhotoModel) -> Void) {
        let url = URL(string: endpoint.userPhotos.get)
        guard let url else { return }
        session.dataTask(with: url) { (data, _, error) in
            guard let data else { return }
            do {
                let response = try JSONDecoder().decode(PhotoModel.self, from: data)
                completion(response)
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
    
    func getProfile(completion: @escaping (ProfileModel) -> Void) {
        let url = URL(string: endpoint.account.getProfileInfo)
        guard let url else { return }
        session.dataTask(with: url) { (data, _, error) in
            guard let data else { return }
            do {
                let response = try JSONDecoder().decode(ProfileModel.self, from: data)
                completion(response)
            } catch {
                print(error)
            }
        }.resume()
    }
}
