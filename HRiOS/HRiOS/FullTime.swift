import UIKit

class FullTime : Employee {
    var salary : Int
    var bonus : Int
    
    func getSalary() -> Int {
        return self.salary
    }
    func setSalary( pSalary : Int) {
        self.salary = pSalary
    }
    
    func getBonus() -> Int {
        return self.bonus
    }
    func setBonus( pBonus : Int) {
        self.bonus = pBonus
    }
    
    init (pName : String, pDob : String, pCountry : String, pSalary : Int, pBonus : Int){
        self.salary = pSalary
        self.bonus = pBonus
        super.init(pName: pName, pDob: pDob, pCountry : pCountry)
    }
    
    override func calcEarnings() -> Int {
        return (salary + bonus)
    }
    
    
    override func toString() -> String{
        return super.toString() + ", Salary: \(self.salary)" + ", Bonus: \(self.bonus)"
    }
    
    override func displayData() {
        print(toString())
    }
    
    
    
    
    required convenience public init?(coder aDecoder: NSCoder){
        guard let Name = aDecoder.decodeObject(forKey: "name") as? String,
        let Dob = aDecoder.decodeObject(forKey: "dob") as? String,
        let Country = aDecoder.decodeObject(forKey: "country") as? String,
        let Salary = aDecoder.decodeObject(forKey: "salary") as? Int,
        let Bonus = aDecoder.decodeObject(forKey: "bonus") as? Int
        else    {return nil}
        self.init(pName: Name, pDob: Dob, pCountry: Country, pSalary : Salary, pBonus : Bonus)
    }
    
    public override func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(dob, forKey: "dob")
        aCoder.encode(country, forKey: "country")
        aCoder.encode(salary, forKey: "salary")
        aCoder.encode(bonus, forKey: "bonus")
    }
    
    
}


