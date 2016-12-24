//
//  ViewController.swift
//  HRiOS
//
//  Created by MAC on 2016-12-05.
//  Copyright © 2016 MAC. All rights reserved.
//

import UIKit

var arrEmployee:[Employee] = [Employee]()


var arrSave:[String] = [String]()

let kHRKey:String = "hr_employee"

let userDefaults = UserDefaults.standard

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var tableEmployee: UITableView!
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var typeWork: UISegmentedControl!
    
    
    @IBOutlet weak var lblWorkType1: UILabel!
    @IBOutlet weak var lblWorkType2: UILabel!
    @IBOutlet weak var txtWTVal1: UITextField!
    @IBOutlet weak var txtWTVal2: UITextField!
    
    private static let dateFMT : String = "MM/dd/yyyy"

    let datePicker = UIDatePicker()
    let countryPicker = UIPickerView()
    
    private var currentEmloyee : Employee!
    
    let arrCountry = ["Korea","USA" , "Canada", "India", "China", "Brazil"]
    
//    var curCountry = "Korea"

    static func getDate(date_str : String) -> Date{
        let df : DateFormatter = DateFormatter()
        df.dateFormat = dateFMT
        return df.date(from: date_str)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableEmployee.delegate = self
        tableEmployee.dataSource = self
        createDatePicker()
        createCountryPicker()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func BuildEmployee() -> Employee!{
        var em : Employee!
        if ((txtName.text?.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty)!){
            txtName.becomeFirstResponder()
            return em
        }
        if ((txtDOB.text?.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty)!){
            txtDOB.becomeFirstResponder()
            return em
        }
        if ((txtCountry.text?.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty)!){
            txtCountry.becomeFirstResponder()
            return em
        }
        
        switch(typeWork.selectedSegmentIndex){
        case 0: //  Full Time
            if(txtWTVal1.text?.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty)!{
                txtWTVal1.becomeFirstResponder()
                return em
            }
            else if(txtWTVal2.text?.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty)!{
                txtWTVal2.becomeFirstResponder()
                return em
            }else{
                em = FullTime(
                    pName: txtName.text!
                    , pDob: txtDOB.text!
                    , pCountry: txtCountry.text!
                    , pSalary: Int(txtWTVal1.text!)!
                    , pBonus: Int(txtWTVal2.text!)!)
            }
            break
        case 1:
            if (txtWTVal1.text?.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty)!{
                txtWTVal1.becomeFirstResponder()
                return em
            }else if(txtWTVal2.text?.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty)!
            {
                txtWTVal2.becomeFirstResponder()
                return em
            }
            em = PartTime(
                pName: txtName.text!
                , pDob: txtDOB.text!
                , pCountry: txtCountry.text!
                , pHours : Int(txtWTVal1.text!)!
                , pRate : Int(txtWTVal2.text!)!)
            break
        case 2:
            if (txtWTVal1.text?.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty)! {
                txtWTVal1.becomeFirstResponder()
                return em
            }
            em = Intern(
                pName: txtName.text!
                , pDob: txtDOB.text!
                , pCountry: txtCountry.text!
                , pSchool: txtWTVal1.text!)
            break
        default:
            break
        }
        return em
    }
    
    
    @IBAction func onClickAdd(_ sender: UIButton) {
        let em = BuildEmployee()
        if em != nil {
            
            arrEmployee.insert(em!, at: 0)
            tableEmployee.reloadData()
            save()
            clearInputData()
        }
    }
    @IBAction func onClickDel(_ sender: UIButton) {
        if tableEmployee.indexPathForSelectedRow == nil { return }
        
        arrEmployee.remove(at: (tableEmployee.indexPathForSelectedRow!).row )
        tableEmployee.reloadData()
        save()
        clearInputData()
   }
    
    
    @IBAction func onClickUpdate(_ sender: UIButton) {
        if tableEmployee.indexPathForSelectedRow == nil { return }
        let em = BuildEmployee()
        if em != nil {
            let idx = (tableEmployee.indexPathForSelectedRow!).row
            arrEmployee[idx] = em!
            tableEmployee.reloadData()
            save()
        }
        /*
        if !((txtName.text?.isEmpty)!){
            let idx = (tableEmployee.indexPathForSelectedRow!).row
            switch typeWork!.selectedSegmentIndex {
            case 0: //  Full Time
                if (txtWTVal1.text?.isEmpty)! || (txtWTVal2.text?.isEmpty)!{ return }
                if let em  = arrEmployee[idx] as? FullTime{
                    em.setName(pName: txtName.text!)
                    em.setDOB(pDOB: txtDOB.text!)
                    em.setCountry(pCountry: txtCountry.text!)
                    em.setSalary(pSalary: Int(txtWTVal1.text!)!)
                    em.setBonus(pBonus: Int(txtWTVal2.text!)!)
                }
                break
            case 1:
                if (txtWTVal1.text?.isEmpty)! || (txtWTVal2.text?.isEmpty)!{ return }
                if let em  = arrEmployee[idx] as? PartTime{
                    em.setName(pName: txtName.text!)
                    em.setDOB(pDOB: txtDOB.text!)
                    em.setCountry(pCountry: txtCountry.text!)
                    em.setHours(pSalary: Int(txtWTVal1.text!)!)
                    em.setRate(pRate: Int(txtWTVal2.text!)!)
                }
                break
            case 2:
                if (txtWTVal1.text?.isEmpty)!{ return }
                if let em  = arrEmployee[idx] as? Intern{
                    em.setName(pName: txtName.text!)
                    em.setDOB(pDOB: txtDOB.text!)
                    em.setCountry(pCountry: txtCountry.text!)
                    em.setSchool(pSchool: txtWTVal1.text!)
                }
                break
            default:
                break
            }
            tableEmployee.reloadData()
            save()
        }*/
    }
    
    
    
    func getCountryNumber(name : String) -> Int
    {
        var i : Int = 0;
        for curC in arrCountry{
            if(curC == name)
            {
                return i
            }
            i += 1
        }
        return -1
    }

    func setGUI(row: Int){
        setGUI(em: arrEmployee[row])
    }
    
    func setGUI(em: Employee){
        txtName.text = em.getName()
        txtDOB.text = em.getDOB()
        txtCountry.text = em.getCountry();
        if let ft = em as? FullTime{
            typeWork.selectedSegmentIndex = 0
            typeWorkSelected(typeWork)
            txtWTVal1.text = String(ft.getSalary())
            txtWTVal2.text = String(ft.getBonus())
        }
        else if let pt = em as? PartTime{
            typeWork.selectedSegmentIndex = 1
            typeWorkSelected(typeWork)
            txtWTVal1.text = String(pt.getHours())
            txtWTVal2.text = String(pt.getRate())
        }
        else if let it = em as? Intern{
            typeWork.selectedSegmentIndex = 2
            typeWorkSelected(typeWork)
            txtWTVal1.text = String(it.getSchool())
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cel", for: indexPath) as! EmployeeCell
        let fm :  DateFormatter = DateFormatter()
        fm.dateFormat = ViewController.dateFMT
        let em = arrEmployee[indexPath.row];

        cell.txtVal2.isHidden = false
        
        if let ft = em as? FullTime{
            cell.imgType.image = UIImage(named: "fulltime24.png")
            cell.txtVal1.text = String(ft.getSalary())
            cell.txtVal2.text = String(ft.getBonus())
        }
        else if let pt = em as? PartTime{
            cell.imgType.image = UIImage(named: "parttime24.png")
//            cell.txtType.text = "P"
            cell.txtVal1.text = String(pt.getHours())
            cell.txtVal2.text = String(pt.getRate())
        }
        else if let it = em as? Intern{
            cell.imgType.image = UIImage(named: "intern24.png")
//            cell.txtType.text = "I"
            cell.txtVal1.text = it.getSchool()
            cell.txtVal2.isHidden = true
        }
        
        cell.txtName.text = em.getName()
        cell.txtDate.text = em.getDOB()
        cell.txtCountry.text = em.getCountry()
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEmployee.count;
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        save()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setGUI(row: indexPath.row)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
            return "Employee list"
//        } else {
//            return ""
//        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtCountry.text = arrCountry[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrCountry[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrCountry.count
    }
    //"Times New Roman"
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.font = UIFont(name: "SanFranciscoText-Light", size: 20.0)
        label.text = arrCountry[row]
        return label
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    
    func EmployeeToString( em : Employee) -> String{
        var out_str : String = ""
        let common_str = em.getName() + " " + em.getDOB() + " " + em.getCountry()
        if let ft = em as? FullTime{
            out_str = "0 " + common_str + " " + String(ft.getSalary()) + " " + String(ft.getBonus())
        }
        else if let pt = em as? PartTime{
            out_str = "1 " + common_str + " " + String(pt.getHours()) + " " + String(pt.getRate())
        }
        else if let it = em as? Intern{
            out_str = "2 " + common_str + " " + String(it.getSchool())
        }
        return out_str
    }
    
    func StringToEmployee( str : String) -> Employee{
        var em : Employee!
        
        let tok = str.components(separatedBy: " ")
        
        if tok[0] == "0"{
            em = FullTime(pName: tok[1], pDob: tok[2], pCountry: tok[3], pSalary: Int(tok[4])!, pBonus: Int(tok[5])!)
        }
        else if tok[0] == "1"{
            em = PartTime(pName: tok[1], pDob: tok[2], pCountry: tok[3], pHours : Int(tok[4])!, pRate: Int(tok[5])!)
        }
        else if tok[0] == "2"{
            em = Intern(pName: tok[1], pDob: tok[2], pCountry: tok[3], pSchool: tok[4])
        }
        return em
    }
    
    
    func save() {
        arrSave.removeAll()
        for emp in arrEmployee{
            arrSave.append(EmployeeToString(em: emp))
        }
        userDefaults.set(arrSave, forKey: kHRKey)
        userDefaults.synchronize()

        
       /* NSKeyedArchiver.setClassName(kHRKey, for: FullTime.self )
        let data = NSKeyedArchiver.archivedData(withRootObject: arrEmployee)
        userDefaults.set(data, forKey: kHRKey)
        userDefaults.synchronize()*/
    }
    
    func load() {
//        userDefaults.removeObject(forKey: kHRKey)
        
        arrEmployee.removeAll()
        if let data = userDefaults.object(forKey: kHRKey) as? [String] {
            for str in data{
                let em = StringToEmployee(str: str)
                arrEmployee.append(em)
            }
        }else{
            arrEmployee.append(FullTime(pName: "Jun", pDob: "04/18/1997", pCountry: arrCountry[0], pSalary: 10000, pBonus: 2000))
            arrEmployee.append(PartTime(pName: "Jiwon", pDob: "12/04/1987", pCountry: arrCountry[1], pHours: 5, pRate: 100))
            arrEmployee.append(Intern(pName: "Ansony", pDob: "11/28/1999", pCountry: arrCountry[2], pSchool: "Lambton" ))
            arrEmployee.append(PartTime(pName: "Sague", pDob: "05/17/1981", pCountry: arrCountry[3], pHours: 8, pRate: 250))
            arrEmployee.append(FullTime(pName: "Mario", pDob: "07/22/1972", pCountry: arrCountry[4], pSalary: 11000, pBonus: 5500))
        }
        
/*        NSKeyedUnarchiver.setClass(FullTime.self, forClassName: kHRKey)
        if let data = userDefaults.data(forKey: kHRKey) {
            let ft = NSKeyedUnarchiver.unarchiveObject(with: data) as? FullTime
            arrEmployee.append(ft!)
//            arrEmployee = (NSKeyedUnarchiver.unarchiveObject(with: data) as? [Employee])!
        }*/
 
    }
    
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        txtDOB.inputAccessoryView = toolbar
        
        datePicker.maximumDate = Date()
        datePicker.datePickerMode = .date
        txtDOB.inputView = datePicker
    }
    func donePressed(){
        let fm :  DateFormatter = DateFormatter()
        fm.dateFormat = ViewController.dateFMT
//        fm.dateStyle = .short
//        fm.timeStyle = .none
        txtDOB.text = fm.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    func createCountryPicker(){
        txtCountry.inputView = countryPicker
        countryPicker.delegate = self
        countryPicker.dataSource = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func typeWorkSelected(_ sender: UISegmentedControl) {
        lblWorkType2.isHidden = false
        txtWTVal2.isHidden = false
        txtWTVal1.text = ""
        txtWTVal2.text = ""
        switch sender.selectedSegmentIndex{
        case 0:
            lblWorkType1.text = "Salary"
            lblWorkType2.text = "Bonus"
            break
        case 1:
            lblWorkType1.text = "Hours"
            lblWorkType2.text = "Rate"
            break
        case 2:
            lblWorkType1.text = "School"
            lblWorkType2.isHidden = true
            txtWTVal2.isHidden = true
            break
        default:
            break;
        }
    }
    
    func clearInputData(){
        clearInputData(bAll: true)
    }

    func clearInputData( bAll : Bool){
        if(bAll){
            txtName.text = ""
            txtDOB.text = ""
            txtCountry.text = ""
        }
        txtWTVal1.text = ""
        txtWTVal2.text = ""
    }
    
    func createTextView(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        txtDOB.inputAccessoryView = toolbar
        
        datePicker.maximumDate = Date()
        datePicker.datePickerMode = .date
        txtDOB.inputView = datePicker
    }
    
    @IBAction func onClickSearch(_ sender: UIButton) {
        if (txtName.text?.isEmpty)! {  return  }
        let nameToSearch = txtName.text
        var idx : Int?
        
        for i in 0..<arrEmployee.count {
            if arrEmployee[i].getName() == nameToSearch {
                idx = i
                break
            }
        }
        
        if idx != nil{
            let indexPath = IndexPath(row: idx!, section: 0);
            tableEmployee.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
            setGUI(row: indexPath.row)
        }
        
        
    }
    
}



