import UIKit
class PartTime : Employee {
    var hoursWorked : Int
    var rate : Int
    
    func getHours() -> Int {
        return self.hoursWorked
    }
    func setHours( pSalary : Int) {
        self.hoursWorked = pSalary
    }
    
    func getRate() -> Int {
        return self.rate
    }
    func setRate( pRate : Int) {
        self.rate = pRate
    }

    init (pName : String, pDob : String, pCountry : String, pHours : Int, pRate : Int){
        self.hoursWorked = pHours
        self.rate = pRate
        super.init(pName: pName, pDob: pDob, pCountry : pCountry)
    }
     
    deinit {
        print("I am in the PartTime's destructor")
    }
    
    
    override func calcEarnings() -> Int {
        return (hoursWorked * rate)
    }
    
    override func toString() -> String{
        return super.toString() + ", Rate: \(self.rate)" + ", Hours: \(self.hoursWorked)"
    }
    
    override func displayData() {
        print(toString())
    }
    

    required convenience public init?(coder aDecoder: NSCoder){
        guard let Name = aDecoder.decodeObject(forKey: "name") as? String,
        let Dob = aDecoder.decodeObject(forKey: "dob") as? String,
        let Country = aDecoder.decodeObject(forKey: "country") as? String,
        let HoursWorked = aDecoder.decodeObject(forKey: "hoursWorked") as? Int,
        let Rate = aDecoder.decodeObject(forKey: "rate") as? Int
        else    {   return nil  }
        self.init(pName: Name, pDob: Dob, pCountry: Country, pHours : HoursWorked, pRate : Rate)
    }
    
    public override func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(dob, forKey: "dob")
        aCoder.encode(country, forKey: "country")
        aCoder.encode(hoursWorked, forKey: "hoursWorked")
        aCoder.encode(rate, forKey: "rate")
    }

    
}

