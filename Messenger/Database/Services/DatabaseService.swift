//
//  DatabaseService.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import Foundation
import RealmSwift

protocol DatabaseServiceProtocol {
    
}

final class DatabaseService: DatabaseServiceProtocol {
    private let realm = try! Realm()
    
    var databaseManager: DatabaseManagerProtocol
    
    init(databaseManager: DatabaseManagerProtocol) {
        self.databaseManager = databaseManager
    }
    
    func save(object: RealmSwift.Object) {
        try! realm.write {
            realm.add(object)
        }
    }
    
    func update(object: RealmSwift.Object) {
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
    
    func fetch<T>(type: T.Type) -> RealmSwift.Results<T> where T: Object {
        realm.objects(type)
    }
}

