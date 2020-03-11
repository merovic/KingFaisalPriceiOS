//
//  SelectWinnersViewController.swift
//  KingFaisalPrice
//
//  Created by Apple on 12/14/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyGif

class SelectWinnersViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var search: UITextField!
    
    @IBOutlet weak var picker1: UIPickerView!
    @IBOutlet weak var picker2: UIPickerView!
    @IBOutlet weak var picker3: UIPickerView!
    @IBOutlet weak var imagefile: UIImageView!
    
    var picker1Data: [String] = [String]()
    
    var picker2Data: [String] = [String]()
    
    var picker3Data = Array<choiceItem>()
    
    var selection1:String?
    var selection2:String?
    
    var ln = Ln()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.title = ln.winners
        
        search.placeholder = ln.search
        
        do{
            let gif = try UIImage(gifName: "logoprize.gif")
            self.imagefile.setGifImage(gif, manager: SwiftyGifManager.defaultManager, loopCount: 10)
        }catch{
            print("asfa")
        }

        for i in 1979..<2026 {
            
            picker1Data.append(String(i))
        }
        
        picker2Data.append(ln.eslam)
        picker2Data.append(ln.studies)
        picker2Data.append(ln.arabic)
        picker2Data.append(ln.medical)
        picker2Data.append(ln.science)
        
        selection1 = "1979"
        selection2 = ln.eslam
        
        picker3.isHidden = true
        
    }
    
    
    @IBAction func okayClicked(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "WinnersListViewController") as! WinnersListViewController
        
        vc.search = search.text!
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(pickerView == picker1)
        {
            return picker1Data[row]
        }else if(pickerView == picker2)
        {
            return picker2Data[row]
        }else
        {
            return picker3Data[row].name
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(pickerView == picker1)
        {
            return picker1Data.count
        }else if(pickerView == picker2)
        {
            return picker2Data.count
        }else
        {
            return picker3Data.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(pickerView == picker1)
        {
            selection1 = picker1Data[row]
            Winners()
        }else if(pickerView == picker2)
        {
            selection2 = picker2Data[row]
            Winners()
        }else
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let vc = storyboard.instantiateViewController(withIdentifier: "WebView2Controller") as! WebView2Controller
            
            vc.link = picker3Data[row].link
            vc.file = picker3Data[row].file
            vc.image = picker3Data[row].certif
            vc.video = picker3Data[row].video
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label = UILabel()
        
        if let v = view as? UILabel { label = v }
        label.font = UIFont (name: "Helvetica Neue", size: 15)
        
        if(pickerView == picker1)
        {
            label.text =  picker1Data[row]
        }else if(pickerView == picker2)
        {
            label.text =  picker2Data[row]
        }else
        {
            label.text =  picker3Data[row].name
        }
        
        label.textAlignment = .center
        return label
    }

    
    
    @IBAction func facebook(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        vc.link = "https://www.facebook.com/KingFaisalPrize/"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func twitter(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        vc.link = "https://twitter.com/KingFaisalPrize"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func instagram(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        vc.link = "https://www.instagram.com/kingfaisalprize/"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func youtube(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        vc.link = "https://www.youtube.com/user/KFIP1"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func linkedin(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        vc.link = "https://www.linkedin.com/company/king-faisal-international-prize"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func share(_ sender: Any) {
        
        // text to share
               let text = "https://www.facebook.com/KingFaisalPrize/"

               // set up activity view controller
               let textToShare = [ text ]
               let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
               activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

               // present the view controller
               self.present(activityViewController, animated: true, completion: nil)
    }
    
    func Winners()
    {
        
        picker3Data.removeAll()
        AF.request("https://technowow.net/webservice_prize.asmx/select_all_prize_winer_by_year_type", method: .get, parameters: [ "year": selection1,"type": selection2 ] ).responseData { (dataResponse) in

            if let data = dataResponse.data {
                print(String(data: data, encoding: .utf8) ?? "")
                
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
                    {
                        
                        let itemsArray : NSArray  = jsonArray as NSArray
                        
                        for i in 0..<itemsArray.count {
                            
                            self.picker3Data.append(choiceItem(name: ((itemsArray[i] as AnyObject).value(forKey: "name") as? String)!, link: ((itemsArray[i] as AnyObject).value(forKey: "url") as? String)!, video: ((itemsArray[i] as AnyObject).value(forKey: "video") as? String)!, certif: ((itemsArray[i] as AnyObject).value(forKey: "certif") as? String)!, file: ((itemsArray[i] as AnyObject).value(forKey: "file") as? String)!))
                            
                        }
                        
                        if(jsonArray.count == 0)
                        {
                            self.picker3.isHidden = true
                        }else
                        {
                            self.picker3.isHidden = false
                        }
                        
                        self.picker3.reloadAllComponents()
                        
                    //    let id = String(((itemsArray[0] as AnyObject).value(forKey: "id") as! Int))
                        
                    //    let year = ((itemsArray[0] as AnyObject).value(forKey: "year") as? String)!
                        
                    //    let name = ((itemsArray[0] as AnyObject).value(forKey: "name") as? String)!
                        
                    //    let date_prize = ((itemsArray[0] as AnyObject).value(forKey: "date_prize") as? String)!
                        
                    //    let image = ((itemsArray[0] as AnyObject).value(forKey: "img") as? String)!
                        
                    //    let type = ((itemsArray[0] as AnyObject).value(forKey: "type") as? String)!
                        
                    //    let url = ((itemsArray[0] as AnyObject).value(forKey: "url") as? String)!
                    
            
                    } else {
                        print("bad json")
                    }
                } catch let error as NSError {
                    print(error)
                }
                
            }
        }
        
        
    }
    
}
