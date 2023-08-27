//
//  FileCache.swift
//  gb-hw1-project1
//
//  Created by Юлия Дебелова on 20.08.2023.
//

import Foundation
import CoreData

final class FileCache {
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores(completionHandler: {(_, error) in
            if let error = error {
                print(error)
            }
        })
        return persistentContainer
    } ()
    
    func save() {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    func delete(object: NSManagedObject) {
        persistentContainer.viewContext.delete(object)
        save()
    }
    
    func addFriends(friends: [FriendModel.FriendResponse.Friend]) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FriendModelCD")
        for friend in friends {
            fetchRequest.predicate = NSPredicate(format: "id = %@", argumentArray: [friend.id])
            let result = try? persistentContainer.viewContext.fetch(fetchRequest)
            guard result?.first == nil else {
                continue
            }
            let friendModel = FriendModelCD(context: persistentContainer.viewContext)
            friendModel.id = Int64(friend.id)
            friendModel.firstName = friend.firstName
            friendModel.lastName = friend.lastName
            friendModel.photo = friend.photoIcon
            friendModel.online = Int64(friend.isOnline)
        }
        save()
        addFriendDate()
    }
    
    func fetchFriends() -> FriendModel? {
        let fetchRequest: NSFetchRequest<FriendModelCD> = FriendModelCD.fetchRequest()
        guard let friends = try? persistentContainer.viewContext.fetch(fetchRequest) else {
            return nil
        }
        var newFriends: [FriendModel.FriendResponse.Friend] = []
        for friend in friends {
            newFriends.append(FriendModel.FriendResponse.Friend(
                id: Int32(friend.id),
                photoIcon: friend.photo,
                isOnline: Int(friend.online),
                firstName: friend.firstName ?? "",
                lastName: friend.lastName ?? ""
            ))
        }
        let newModel: FriendModel = FriendModel(response: FriendModel.FriendResponse(count: 0, items: newFriends))
        return newModel
    }
    
    func addGroups(groups: [GroupModel.GroupResponse.UserGroup]) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GroupModelCD")
        for group in groups {
            fetchRequest.predicate = NSPredicate(format: "id = %@", argumentArray: [group.id])
            let result = try? persistentContainer.viewContext.fetch(fetchRequest)
            guard result?.first == nil else {
                continue
            }
            let groupModel = GroupModelCD(context: persistentContainer.viewContext)
            groupModel.id = Int64(group.id)
            groupModel.name = group.name
            groupModel.photo = group.photoIcon
            groupModel.caption = group.description
        }
        save()
        addGroupDate()
    }
    
    func fetchGroups() -> GroupModel? {
        let fetchRequest: NSFetchRequest<GroupModelCD> = GroupModelCD.fetchRequest()
        guard let groups = try? persistentContainer.viewContext.fetch(fetchRequest) else {
            return nil
        }
        var newGroups: [GroupModel.GroupResponse.UserGroup] = []
        for group in groups {
            newGroups.append(GroupModel.GroupResponse.UserGroup(
                id: Int32(group.id),
                name: group.name ?? "",
                description: group.caption ?? "",
                photoIcon: group.photo ?? ""
            ))
        }
        let newModel: GroupModel = GroupModel(response: GroupModel.GroupResponse(count: 0, items: newGroups))
        return newModel
    }
    
    func addFriendDate() {
        //let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FriendDateCD")
        let date = FriendDateCD(context: persistentContainer.viewContext)
        date.date = Date()
        save()
    }
    
    func fetchFriendDate() -> Date? {
        let fetchRequest: NSFetchRequest<FriendDateCD> = FriendDateCD.fetchRequest()
        guard let data = try? persistentContainer.viewContext.fetch(fetchRequest) else {
            return nil
        }
        return data.first?.date
    }
    
    func addGroupDate() {
        //let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GroupDateCD")
        let date = GroupDateCD(context: persistentContainer.viewContext)
        date.date = Date()
        save()
    }
    
    func fetchGroupDate() -> Date? {
        let fetchRequest: NSFetchRequest<GroupDateCD> = GroupDateCD.fetchRequest()
        guard let data = try? persistentContainer.viewContext.fetch(fetchRequest) else {
            return nil
        }
        return data.first?.date
    }
}
