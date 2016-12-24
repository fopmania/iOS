import UIKit

class Intern : Employee {
    var schoolName : String

    func getSchool() -> String {
        return self.schoolName
    }
    func setSchool( pSchool : String) {
        self.schoolName = pSchool
    }

    init (pName : String, pDob : String, pCountry : String, pSchool : String){
        self.schoolName = pSchool
        super.init(pName: pName, pDob: pDob, pCountry : pCountry)
    }
    
    
    deinit {
        print("I am in the Intern's destructor")
    }
    
    override func toString() -> String{
        return super.toString() + ", School: \(self.schoolName)"
    }
    
    override func displayData() {
        print(toString())
    }
    
    
    
    required convenience public init?(coder aDecoder: NSCoder){
        guard let Name = aDecoder.decodeObject(forKey: "name") as? String,
        let Dob = aDecoder.decodeObject(forKey: "dob") as? String,
        let Country = aDecoder.decodeObject(forKey: "country") as? String,
        let SchoolName = aDecoder.decodeObject(forKey: "schoolName") as? String
            else    {return nil}
        self.init(pName: Name, pDob: Dob, pCountry: Country, pSchool : SchoolName)
    }
    
    public override func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(dob, forKey: "dob")
        aCoder.encode(country, forKey: "country")
        aCoder.encode(schoolName, forKey: "schoolName")
    }
    
}



