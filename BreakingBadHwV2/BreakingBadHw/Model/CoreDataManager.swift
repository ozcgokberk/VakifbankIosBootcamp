//
//  CoreDataManager.swift
//  BreakingBadHw
//
//  Created by Gokberk Ozcan on 30.11.2022.
//


import UIKit
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private let managedContext: NSManagedObjectContext! //içerisne not eklediğimiz persistent  container
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    func saveNote(id: String, episodeInfo:String, text: String, seasonInfo: String) -> Note? {
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        note.setValue(id, forKey: "id")
        note.setValue(episodeInfo, forKey: "episode")
        note.setValue(text, forKey: "noteText")
        note.setValue(seasonInfo, forKey: "season")
        if save() {
            return note as? Note
        }
        return nil
    }
    
    func getNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
        do {
            let notes = try managedContext.fetch(fetchRequest)
            return notes as! [Note]
        } catch  let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return []
    }
    
    func notGuncelle(id: String, episodeInfo:String, text: String, seasonInfo: String) {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", argumentArray: [id])
        
        do {
            let results = try managedContext.fetch(request)
            if results.count != 0 {
                let note = results[0]
                
                note.setValue(id, forKey: "id")
                note.setValue(episodeInfo, forKey: "episode")
                note.setValue(text, forKey: "noteText")
                note.setValue(seasonInfo, forKey: "season")
                self.save()
            }
        } catch {
            print("Fetch Failed: \(error)")
        }
        
    }
    
    @discardableResult
    func save() -> Bool {
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Could not save. \(error.localizedDescription), \(error.userInfo)")
        }
        return false
    }
    
    func notVarMi(id: String) -> Bool {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", argumentArray: [id])
        do {
            let results = try managedContext.fetch(request)
            return results.count > 0
        } catch {
            print("Fetch Failed: \(error)")
            return false
        }
    }
}
