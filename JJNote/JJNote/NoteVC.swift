//
//  ViewController.swift
//  JJNote
//
//  Created by MAC on 2017-04-07.
//  Copyright © 2017 MAC. All rights reserved.
//

import UIKit
import CoreData
import MapKit
import AssetsLibrary

enum eSaveType: Int {
    case null = 0
    case add = 1
    case edit = 2
}


class NoteVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate  {
    let context:NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var table: UICollectionView!

    fileprivate var photoEntityArrayAll = [PhotoEntity]()
    var photoEntityArray = [PhotoEntity]()
    
    @IBOutlet weak var txtNote: UITextView!
    
    let manager = CLLocationManager()
    
    var saveMode : eSaveType = eSaveType.null;
    
    var mainvc:MainVC!
    
    var curPC:PhotoCell? = nil
    
    var updateOnce : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoEntityArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCell
        let row = indexPath.row
        
        if let img = UIImage(data: photoEntityArray[row].image! as Data){
            cell.image.image = img
            cell.image.contentMode = .scaleToFill
            cell.lat = photoEntityArray[row].lat
            cell.lon = photoEntityArray[row].lon
//            cell.btnMap.setValue(cell.lat, forKey: "lat")
//            cell.btnMap.setValue(cell.lon, forKey: "lon")
            
            let lat = Double(round(cell.lat*1000)/1000)
            let lon = Double(round(cell.lat*1000)/1000)
            cell.label.text = "Lat:\(lat), Lon:\(lon)"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        curPC = collectionView.cellForItem(at: indexPath) as! PhotoCell
        print("photo_cell")
    }
    
    func updateData() {
        //        CoreDataManager.cleanNoteData();
        photoEntityArrayAll = CoreDataManager.fetchPhoto()
        table.reloadData()
    }
    
    func addPhotoEntity( ph : PhotoEntity ){
        photoEntityArray.insert(ph, at: 0)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addPhoto(photo: UIImage, lat: Double, lon: Double) {
        if photo == nil  {   return  }
        
        
        let pe = CoreDataManager.storePhoto(photo: photo, lat: lat, lon: lon)
        addPhotoEntity(ph: pe)
        updateData()
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "map"{
            let vc: MapVC = segue.destination as! MapVC
            
            if curPC != nil{
//                let bt = sender as? UIButton
                
//                vc.lat = bt?.value(forKey: "lat") as! Double
//                vc.lon = bt?.value(forKey: "lon") as! Double
                let index = txtNote.text.index(txtNote.text.startIndex, offsetBy: 10)
                vc.disc = txtNote.text.substring(to: index)
            }
            
            
        }
        else if segue.identifier != "save"{
            txtNote.text = ""
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if saveMode == eSaveType.edit{
            txtNote.text = mainvc.selNote?.note
            
            if updateOnce {
                photoEntityArray.removeAll()
                let items = mainvc.selNote?.mutableSetValue(forKey: "photo_relationship")
                for value in items! {
                    photoEntityArray.append(value as! PhotoEntity)
//                    addPhotoEntity(ph: value as! PhotoEntity)
                }
                updateOnce = false
            }

            
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainvc.newRowText = txtNote.text!
    }
    
    @IBAction func clickCencel(_ sender: Any) {
        dismissVC()
    }
    @IBAction func clickSave(_ sender: UIBarButtonItem) {
        
        if saveMode == eSaveType.add{
            
            if photoEntityArray.count > 0{
                var ne = mainvc.addNote(note: txtNote.text!, photo: photoEntityArray[0].image!)
                for p in photoEntityArray{
                    ne?.addToPhoto_relationship(p)
                }
            }else{
                var ne = mainvc.addNote(note: txtNote.text!)
                for p in photoEntityArray{
                    ne?.addToPhoto_relationship(p)
                }
            }
        }
        else if saveMode == eSaveType.edit{
            mainvc.editNote(note: txtNote.text!)
            var items = mainvc.selNote?.mutableSetValue(forKeyPath: "photo_relationship")
            for value in items! {
                items?.remove(value)
            }
            if mainvc.selNote != nil && photoEntityArray.count > 0{
                
                mainvc.selNote?.photo = photoEntityArray[0].image
            }
            for p in photoEntityArray{
                mainvc.selNote?.addToPhoto_relationship(p)
            }
        }
        CoreDataManager.saveContext()
        
        dismissVC()
    }
    
    func dismissVC(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    func newNote(){
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        //map.setRegion(region, animated: true)
        print(location.coordinate.longitude)
        print(location.coordinate.latitude)
        
        //self.map.showsUserLocation = true
    }
    
    @IBAction func clickCamera(_ sender: UIButton) {
        // Take a picture
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let lat = manager.location?.coordinate.longitude
        let lon = manager.location?.coordinate.latitude
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //           let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            let library = ALAssetsLibrary()
            let metadata = info[UIImagePickerControllerMediaMetadata] as? NSDictionary //Try to get gps info
            
              addPhoto(photo: pickedImage, lat: lat!, lon: lon!)
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func clickPhoto(_ sender: UIButton) {
        // take a pic from gallary
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    @IBAction func clickEmail(_ sender: UIButton) {
        // send email
    }
    
    @IBAction func clickMap(_ sender: Any) {
        
        
    }
    
   
    
}

