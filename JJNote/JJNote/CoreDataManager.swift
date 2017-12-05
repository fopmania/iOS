//
//  CoreDataManager.swift
//  JJNote
//
//  Created by MAC on 2017-04-07.
//  Copyright © 2017 MAC. All rights reserved.
//


import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    class func storePhoto(photo: UIImage, lat: Double, lon: Double) -> PhotoEntity {
        let context = getContext()

        let newPhoto = NSEntityDescription.insertNewObject(forEntityName: "PhotoEntity", into: context) as! PhotoEntity
        let imageData = UIImageJPEGRepresentation(photo, 1)
        newPhoto.image = imageData! as NSData
        newPhoto.lat = lat
        newPhoto.lon = lon
        //let image : UIImage = UIImage(data: imageData)
        
        do {
            try context.save()
            print("saved!")
        } catch {
            print(error.localizedDescription)
        }
        return newPhoto;
    }
    
    class func storeNote(note:String, photo: NSData) ->NoteEntity{
        let context = getContext()
       
        let newNote = NSEntityDescription.insertNewObject(forEntityName: "NoteEntity", into: context) as! NoteEntity
        if(photo != nil){
            newNote.photo = photo
        }
        newNote.note = note;
        
        do {
            try context.save()
            print("saved!")
        } catch {
            print(error.localizedDescription)
        }
        return newNote
    }
    
    
    

    class func fetchNote() -> [NoteEntity]{
        var array = [NoteEntity]()
        let fetchRequest:NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()

        do {
            let fetchResult = try getContext().fetch(fetchRequest)
            
            for item in fetchResult {
//                let note = noteItem(note: item.note!)
                array.insert(item, at: 0)
            }
        }catch {
            print(error.localizedDescription)
        }
        
        return array
    }

    class func fetchPhoto() -> [PhotoEntity]{
        var array = [PhotoEntity]()
        let fetchRequest:NSFetchRequest<PhotoEntity> = PhotoEntity.fetchRequest()
        
        do {
            let fetchResult = try getContext().fetch(fetchRequest)
            
            for item in fetchResult {
                //                let note = noteItem(note: item.note!)
                array.insert(item, at: 0)
            }
        }catch {
            print(error.localizedDescription)
        }
        
        return array
    }
    
/*    class func fetchNote(selectedScopeIdx:Int?=nil,targetText:String?=nil) -> [noteItem]{
        var aray = [noteItem]()
        
        let fetchRequest:NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        
        if selectedScopeIdx != nil && targetText != nil{
            
            var filterKeyword = ""
            switch selectedScopeIdx! {
            case 0:
                filterKeyword = "note"
            case 1:
                filterKeyword = "by"
            default:
                filterKeyword = "year"
            }

            var predicate = NSPredicate(format: "\(filterKeyword) contains[c] %@", targetText!)
            //predicate = NSPredicate(format: "by == %@" , "wang")
            //predicate = NSPredicate(format: "year > %@", "2015")
        
            fetchRequest.predicate = predicate
        }
        
        do {
            let fetchResult = try getContext().fetch(fetchRequest)
            
            for item in fetchResult {
                let img = imageItem(name: item.name!, year: item.year!, by: item.by!)
                aray.append(img)
                print("image name:"+img.imageName!+"\nimage year:"+img.imageYear!+"\nimage by:"+img.imageBy!+"\n")
            }
        }catch {
            print(error.localizedDescription)
        }
        
        return aray
    }*/

    ///delete all the data in core data
    class func cleanPhotoData() {
        
        let fetchRequest:NSFetchRequest<PhotoEntity> = PhotoEntity.fetchRequest()
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            print("deleting all photo contents")
            try getContext().execute(deleteRequest)
        }catch {
            print(error.localizedDescription)
        }
        
    }

    
    class func cleanNoteData() {
        
        let fetchRequest:NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            print("deleting all note contents")
            try getContext().execute(deleteRequest)
        }catch {
            print(error.localizedDescription)
        }
        
    }

    class func saveContext(){
        let context = getContext()
        do {
            try context.save()
            print("saved!")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    class func removeNoteEnetity(ne : NoteEntity ){
        getContext().delete(ne);
        saveContext()
    }
    class func removePhotoEnetity(pe : PhotoEntity ){
        getContext().delete(pe);
        saveContext()
    }
    
    
    
//    
//    class func deleteCoreDataItemWithIndex() {
//        
//        var predicate = NSPredicate(format: "name contains[c] %@", "001")
//
//        let fetchRequest:NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
//        fetchRequest.predicate = predicate
//
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
//        
//        do {
//            print("deleting all contents")
//            try getContext().execute(deleteRequest)
//        }catch {
//            print(error.localizedDescription)
//        }
//        
//        
//    }
    
    
    
}


