//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import Foundation
import RealmSwift

protocol DatabaseManagerProtocol {
    func writeTransaction(execute: () -> Void)
    func save(object: RealmSwift.Object)
    func delete<T: Object>(id: String, object: T.Type)
    func deleteAll()
    func deleteAll<T: Object>(of type: T.Type)
    func fetch<T>(type: T.Type) -> RealmSwift.Results<T> where T: Object
}


final class DatabaseManager: DatabaseManagerProtocol {
    private let realm = try! Realm()
    
    func writeTransaction(execute: () -> Void) {
        let realm = try! Realm()
        try! realm.write {
            execute()
        }
    }
    
    func save(object: RealmSwift.Object) {
        DispatchQueue.main.async { [weak self] in
            try! self?.realm.write {
                self?.realm.add(object, update: .all)
            }
        }
    }
    
    func delete<T: Object>(id: String, object: T.Type) {
        DispatchQueue.main.async { [weak self] in
            let object = self?.realm.objects(T.self).filter("id=%@", id)
            try! self?.realm.write {
                self?.realm.delete(object!)
            }
        }
    }
    
    func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func deleteAll<T: Object>(of type: T.Type) {
        let objects = self.realm.objects(type.self)
        try! realm.write {
            realm.delete(objects)
        }
    }
    
    func fetch<T>(type: T.Type) -> RealmSwift.Results<T> where T: Object {
        realm.objects(type)
    }
}
