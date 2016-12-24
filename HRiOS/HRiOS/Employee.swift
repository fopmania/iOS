
import UIKit

public class Employee : NSObject, IDisplayable, NSCoding {
    public var name : String
    public var dob : String
    public var country : String
    
    func getName() -> String {
        return self.name
    }
    func setName( pName : String) {
        self.name = pName
    }

    func getDOB() -> String {
        return self.dob
    }
    func setDOB( pDOB : String) {
        self.dob = pDOB
    }

    func getCountry() -> String {
        return self.country
    }
    func setCountry( pCountry : String) {
        self.country = pCountry
    }
    
     
    
    init(pName : String, pDob : String, pCountry : String){
        self.name = pName
        self.dob = pDob
        self.country = pCountry
    }
    
    
    
    deinit {
        print("Empoyee's destructor");
    }
    
    func calcAge() -> Int {
        let df : DateFormatter = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        let birth = df.date(from: dob)!
        
        let comps = Calendar.current.dateComponents([.year], from: birth, to : Date())
        
        return comps.year!
    }
    
    func calcEarnings() -> Int {
        return 1000
    }
    
    
    func toString() -> String{
        return "Name: \(self.name)" + "\nBirth: \(self.dob)" + ", Age: " + String(calcAge())
    }
    
    func displayData() {
        print(toString())
    }
    
    
    required public convenience init?(coder aDecoder: NSCoder){
        guard let Name = aDecoder.decodeObject(forKey: "name") as? String,
        let Dob = aDecoder.decodeObject(forKey: "dob") as? String,
        let Country = aDecoder.decodeObject(forKey: "country") as? String
        else {return nil}
        self.init(pName: Name, pDob: Dob, pCountry: Country)
    }
    
    
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(dob, forKey: "dob")
        aCoder.encode(country, forKey: "country")
    }
    
}

