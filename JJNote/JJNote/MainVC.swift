//
//  TableVC.swift
//  JJNote
//
//  Created by MAC on 2017-04-07.
//  Copyright © 2017 MAC. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UITableViewController {
    
    fileprivate var noteEntityArray = [NoteEntity]()
    
    
    @IBOutlet var table: UITableView!
    
    
    var data:[String] = []
    var selRow:Int = -1
    var newRowText:String = ""
    
    var selNote: NoteEntity? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateData()
    }
    
    func updateData() {
//        CoreDataManager.cleanNoteData();
        noteEntityArray = CoreDataManager.fetchNote()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteEntityArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoteTableViewCell

        if noteEntityArray[indexPath.row].photo != nil{
            if let img = UIImage(data: noteEntityArray[indexPath.row].photo! as Data){
                cell.photo.image = img
            }
        }

        cell.note.text = noteEntityArray[indexPath.row].note
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let row = indexPath.row
            CoreDataManager.removeNoteEnetity(ne: noteEntityArray[row])
            noteEntityArray.remove(at: row)
            updateData()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func save() {
    }
    
    func load() {
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selRow = (tableView.indexPathForSelectedRow?.row)!
        self.selNote = self.noteEntityArray[self.selRow]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add"{
            let vc:NoteVC = segue.destination as! NoteVC
            vc.mainvc = self
            vc.saveMode = eSaveType.add
            vc.photoEntityArray.removeAll()
            vc.updateOnce = true;
        }else if segue.identifier == "edit"{
            let vc:NoteVC = segue.destination as! NoteVC
            vc.mainvc = self
            vc.updateOnce = true
            vc.saveMode = eSaveType.edit
        }
    }
    
    
    func addNote(note: String, photo: NSData? = nil)->NoteEntity? {
        if note == ""   {   return nil }
        let ne = CoreDataManager.storeNote(note: note, photo: photo!)
        updateData();
        table.reloadData()
        return ne
    }

    func editNote(note: String) {
        selNote?.note = note
        //CoreDataManager.storeNote(note: note)
        CoreDataManager.saveContext()
        updateData();
        table.reloadData()
//        data[selRow] = note
    }
    
}
