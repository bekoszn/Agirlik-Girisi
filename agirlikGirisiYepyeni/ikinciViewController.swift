//
//  ikinciViewController.swift
//  agirlikGirisiYepyeni
//
//  Created by Berke Özgüder on 6.09.2023.
//

import UIKit
import CoreData

class ikinciViewController: UIViewController {



    
    @IBOutlet weak var benchPress: UITextField!
    

    @IBOutlet weak var kaydetButon: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cableCurl: UITextField!
    @IBOutlet weak var hammerCurl: UITextField!
    @IBOutlet weak var barbellRow: UITextField!
    @IBOutlet weak var latPulldown: UITextField!
    @IBOutlet weak var overHeadPress: UITextField!
    @IBOutlet weak var dumbellFly: UITextField!
    @IBOutlet weak var inclinePress: UITextField!
    
    @IBOutlet weak var zaman: UIDatePicker!
    @IBOutlet weak var isimm: UITextField!
    var secilenHareketIsmi = ""
    var secilenHareketUUID : UUID?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if secilenHareketIsmi != "" {
            
            kaydetButon.isHidden = true
            zaman.isUserInteractionEnabled = false
            
            if let uuidString = secilenHareketUUID?.uuidString {
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
                fetchRequest.predicate = NSPredicate(format: "id = %@", uuidString)
                fetchRequest.returnsObjectsAsFaults = false
                
                
                do {
                    let sonuclar = try context.fetch(fetchRequest)
                    
                    if sonuclar.count > 0 {
                        for sonuc in sonuclar as! [NSManagedObject] {
                            
                            if let bench2 = sonuc.value(forKey: "bench") as? Int {
                                benchPress.text = String(bench2)
                            }
                            if let incline2 = sonuc.value(forKey: "inclinebench") as? Int {
                                inclinePress.text = String(incline2)
                            }
                            if let dumbellfly2 = sonuc.value(forKey: "dumbellfly") as? Int {
                                dumbellFly.text = String(dumbellfly2)
                            }
                            if let ohp2 = sonuc.value(forKey: "overheadpress") as? Int {
                                overHeadPress.text = String(ohp2)
                            }
                            if let latpulldown2 = sonuc.value(forKey: "latpulldown") as? Int {
                                latPulldown.text = String(latpulldown2)
                            }
                            if let barbellrow2 = sonuc.value(forKey: "barbellrow") as? Int {
                                barbellRow.text = String(barbellrow2)
                            }
                            if let hammercurl2 = sonuc.value(forKey: "hammercurl") as? Int {
                                hammerCurl.text = String(hammercurl2)
                            }
                            if let cablecurl2 = sonuc.value(forKey: "cablecurl") as? Int {
                                cableCurl.text = String(cablecurl2)
                            }
                            if let isimm2 = sonuc.value(forKey: "isimyeni") as? String {
                                isimm.text = isimm2
                            }
                            if let zaman2 = sonuc.value(forKey: "zaman") as? Date {
                                zaman.date = zaman2
                            }


                        }
                    }
                } catch {
                    print("hata yakalandı")
                }
            }
            
        } else {
            
            kaydetButon.isHidden = false
            isimm.text = ""
            benchPress.text = ""
            inclinePress.text = ""
            dumbellFly.text = ""
            overHeadPress.text = ""
            latPulldown.text = ""
            barbellRow.text = ""
            hammerCurl.text = ""
            cableCurl.text = ""

        }

        let gestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(gestureRecogniser)
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func kaydetButon(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        

        
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Entity", into: context)

        
        if let bench = Int(benchPress.text!) {
            entity.setValue(bench, forKey: "bench")
        }
        if let dumbellfly = Int(dumbellFly.text!) {
            entity.setValue(dumbellfly, forKey: "dumbellfly")
        }
        if let incline = Int(inclinePress.text!) {
            entity.setValue(incline, forKey: "inclinebench")
        }
        if let ohp = Int(overHeadPress.text!) {
            entity.setValue(ohp, forKey: "overheadpress")
        }
        if let lat = Int(latPulldown.text!) {
            entity.setValue(lat, forKey: "latpulldown")
        }
        if let barbellrow = Int(barbellRow.text!) {
            entity.setValue(barbellrow, forKey: "barbellrow")
        }
        if let hammer = Int(hammerCurl.text!) {
            entity.setValue(hammer, forKey: "hammercurl")
        }
        if let cable = Int(cableCurl.text!) {
            entity.setValue(cable, forKey: "cablecurl")
        }
        entity.setValue(UUID(), forKey: "id")
        entity.setValue(isimm.text, forKey: "isimyeni")
        entity.setValue(zaman.date, forKey: "zaman")
        
        
        do {
            try context.save()
            print("kaydedildi")
        } catch {
            print("hata yakalandı")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "veriGirildi"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
}
