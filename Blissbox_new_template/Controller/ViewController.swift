//
//  ViewController.swift
//  Blissbox_new_template
//
//  Created by ANG RUI XIAN  on 19/12/17.
//  Copyright © 2017 ANG RUI XIAN . All rights reserved.
// 

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import NVActivityIndicatorView

class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource, UISearchBarDelegate {
    
    // data structure to store data for the DataController
    let giftboxDataClass = giftboxData.sharedInstance
    let experienceDataClass = experienceData.sharedInstance
    let fileAPI = apiFile.sharedInstance
    let URL = "https://dev.blissbox.asia/api/giftbox/all"
    let urlExperience = "https://dev.blissbox.asia/api/experience/all"
    var headers: HTTPHeaders = [:]
    var api : String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjRmYTY5YzJiNmUwNzRkNDk4NmZkZWZmNjRhODFmZjc0MmJlNjliNTQ0YmFmZGRlNDExYjhlNjg5OTQ0ODQ2OGFkMjdkNDZiNTUyNjNjYmQxIn0.eyJhdWQiOiI1IiwianRpIjoiNGZhNjljMmI2ZTA3NGQ0OTg2ZmRlZmY2NGE4MWZmNzQyYmU2OWI1NDRiYWZkZGU0MTFiOGU2ODk5NDQ4NDY4YWQyN2Q0NmI1NTI2M2NiZDEiLCJpYXQiOjE1MTAyMTU3MDAsIm5iZiI6MTUxMDIxNTcwMCwiZXhwIjoxNTQxNzUxNzAwLCJzdWIiOiIxMCIsInNjb3BlcyI6W119.gVwm4kgq3FROqeNr-P1AE1wNdhtCsBrmMPORHo96_J9oMTyQhaxEvzn5T6qWGO4gfxPXhKnF6YCSBhXE5JjjJgtWZqybjqXx7YO1ERNdKn_XI2qZmsQ_3BpzCB2CQfTUSCOdrWZcEZuyZ5ixV3m6Zr8jdUbZUSUdl-GjKML6aGSOuYFXcFNpL56pF_OYcYPwmVgqjincQlWgUbZP0wYMk3badIBjXzYJZ9xqZTY_3E1Chdfxp6ul2gzUzWjmariFSrhvKtI0nbAfBvQCdi8mOdhlxR_zXY79PQYM6_btD-sK1hrOkmkCU9abFp_Gwr9cXCbQCfOS3J58Om_cnlYi9KF6p_VZpabRV0tZeEQ2D6nHodmCkwAhJTDAk4xMq8wLMqfDJFfhWfMDzMhGl8KlEITXj5qkLgI5S9oklCrqawzlgPr_bVAf-gR6UP_boplaufI6SaiTKSMH7Ff7WmRjEQINheq1YuaOj4hVBfCOXOrLOQ6Gnk0WPN9x0mVNZoZtR3A4SEQgZhIT3Y5q5FuNmnjbSJyuZBADrNHmJTZzi8c4EgEkW20rcY78QmnUmDqL8gTPzXNyrzJZWcfeCJYsx2LgEF66ysicu6_xVIykJV4KlSabfABUV5M3GIOiJ40nrMXZtCwpysW6YfqR0MXA0TOMALLBjCZ6Ofsb1-JgtUE"
    let activityIndicatorView = NVActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100), type: NVActivityIndicatorType.ballScaleMultiple, color: UIColor(red:1.00, green:0.81, blue:0.32, alpha:1.0), padding: nil)
    
    @IBOutlet weak var outCollectionViewUniverseList: UICollectionView!
    @IBOutlet weak var outCollectioViewFeatureBox: UICollectionView!
    @IBOutlet weak var outCollectionViewRandomExperience: UICollectionView!
    let universeArray : [String] = ["Multi-theme","Indulge","Relax","Energize","Escape"]
    let image = ["INDULGE1","INDULGE2","INDULGE3","ESCAPE4","ESCAPE5","RELAX6","RELAX7","ENERGIZE8","ENERGIZE9"]
    let imageExperience = ["absolute_skin","absoluteskin","beautyEmpire","bobby","go60","jezBrows","nkj","segway","summerHaven"]
    let universeBackgroundImage = ["multiUniverseBackground","indulgeUniverseBackground","relaxUniverseBackground","energyUniverseBackground","escapeUniverseBackground"]
    let universeIcon = ["gastro","gastro","wellness","adventure","hotel"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.outCollectioViewFeatureBox.delegate = self;
        self.outCollectioViewFeatureBox.dataSource = self
        self.outCollectionViewUniverseList.delegate = self;
        self.outCollectionViewUniverseList.dataSource = self
        self.outCollectionViewRandomExperience.delegate = self;
        self.outCollectionViewRandomExperience.dataSource = self
        createSearchBar()
        displayExperience(url: urlExperience)
        headers = ["Authorization": "Bearer \(api)",
            "Accept": "application/json"]
        activityIndicatorView.center = self.view.center
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        displayGiftbox(url: URL)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.outCollectioViewFeatureBox{
            return self.giftboxDataClass.giftboxArray.count
        }else if collectionView == self.outCollectionViewUniverseList{
            return universeArray.count
        }else{
            return experienceDataClass.experienceArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.outCollectioViewFeatureBox{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFeatureBox", for: indexPath) as! FeatureBoxCollectionViewCell
            // get the item number
            let item = indexPath.item
            let row = indexPath.row
            cell.outImageViewFeatureBox.sd_setImage(with: Foundation.URL(string: self.giftboxDataClass.giftboxArray[row].thumbnail!))
            cell.outLabelFeatureBoxName.text = self.giftboxDataClass.giftboxArray[row].name
            cell.outLabelFeatureBoxPrice.text = "SGD" + String(describing: self.giftboxDataClass.giftboxArray[row].price!) + "0"
            cell.outButtonBuyNow.clipsToBounds = true
            cell.outButtonBuyNow.layer.cornerRadius = 10
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 10
            
            return cell
        }else if collectionView == self.outCollectionViewUniverseList{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellUniverseList", for: indexPath) as! HomepageUniverseListCollectionViewCell
            let item = indexPath.item
            let row = indexPath.row
            cell.outImageViewUniverse.image = UIImage(named:universeIcon[row])
            //            cell.outImageViewUniverse.layer.borderWidth = 2
            //            cell.outImageViewUniverse.layer.borderColor = UIColor.blue.cgColor
            //            cell.outImageViewUniverse.clipsToBounds = true
            //            cell.outImageViewUniverse.layer.cornerRadius = 10
            cell.outLabelUniverseName.text = universeArray[row]
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellRandomExperience", for: indexPath) as! HomepageRandomExperienceCollectionViewCell
            let item = indexPath.item
            let row = indexPath.row
            cell.outImageViewRandomExperience.sd_setImage(with: Foundation.URL(string: self.experienceDataClass.experienceArray[row].thumbnail!))
            
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.outCollectioViewFeatureBox{
            let row = indexPath.row
            fileAPI.row = row
        performSegue(withIdentifier: "homepageToGiftboxDetails", sender: self)
            print("Feature Box")
        }else if collectionView == self.outCollectionViewUniverseList{
            print("Universe")
            performSegue(withIdentifier: "Universe", sender: self)
        }else{
            print("Experience")
            let row = indexPath.row
            fileAPI.experienceRow = row
            performSegue(withIdentifier: "homepageToExperienceDetails", sender: self)        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        api = fileAPI.apikey
//        //        self.view.makeToast(fileAPI.apikey)
//        giftboxDataClass.giftboxArray.removeAll()
//        headers = ["Authorization": "Bearer \(api)",
//            "Accept": "application/json"]
//        displayGiftbox(url: URL)
//    }
    
    func displayExperience(url: String){
        Alamofire.request(url, method: .get, headers: headers).responseJSON {
            response in
            if response.result.isSuccess{
                print("Success! Got the exeperience")
                
                let experienceJSON : JSON = JSON(response.result.value!)
                //                                print(experienceJSON)
                let experienceArrayResult = experienceJSON["result"]
                print(experienceArrayResult)
                for i in 0 ..< experienceArrayResult.count {
                    let id = experienceArrayResult[i]["id"].int
                    let company_id = experienceArrayResult[i]["company_id"].int
                    let thumbnail = experienceArrayResult[i]["thumbnail"].stringValue
                    let name = experienceArrayResult[i]["name"].stringValue
                    let code = experienceArrayResult[i]["code"].stringValue
                    let pax = experienceArrayResult[i]["pax"].int
                    let duration = experienceArrayResult[i]["duration"].stringValue
                    let email = experienceArrayResult[i]["email"].stringValue
                    let phone = experienceArrayResult[i]["phone"].stringValue
                    let address = experienceArrayResult[i]["address"].stringValue
                    let requirements = experienceArrayResult[i]["requirement"].stringValue
                    let services = experienceArrayResult[i]["services"].stringValue
                    let information = experienceArrayResult[i]["information"].stringValue
                    let deleted_at = experienceArrayResult[i]["deleted_at"].stringValue
                    let created_at = experienceArrayResult[i]["created_at"].stringValue
                    let updated_at = experienceArrayResult[i]["updated_at"].stringValue
                    
                    
                    
                    
                    let image = "https://dev.blissbox.asia/storage/experiences/" + thumbnail
                    //
                    let retrieveData = experienceData.init(id: id!, company_id: company_id!, thumbnail: image, name: name, code: code, pax: pax!, duration: duration, email: email, phone: phone, address: address, requirements: requirements, services: services, information: information, deleted_at: deleted_at, created_at: created_at, updated_at: updated_at)
                    self.experienceDataClass.experienceArray.append(retrieveData)
                }
                
                
            }else{
                print("Error \(response.result.error)")
            }
            DispatchQueue.main.async {
                self.outCollectionViewRandomExperience.reloadData()
            }
        }
    }
    
    func displayGiftbox(url: String){
        Alamofire.request(url, method: .get, headers: headers).responseJSON {
            response in
            if response.result.isSuccess{
                //                                print("Success! Got the user")
                
                let giftboxJSON : JSON = JSON(response.result.value!)
                //                                print(giftboxJSON)
                let giftboxArrayResult = giftboxJSON["result"]
                print(giftboxArrayResult)
                for i in 0 ..< giftboxArrayResult.count {
                    let id = giftboxArrayResult[i]["id"].int
                    let universe_id = giftboxArrayResult[i]["universe_id"].int
                    let initial = giftboxArrayResult[i]["initial"].stringValue
                    let thumbnail = giftboxArrayResult[i]["thumbnail"].stringValue
                    let name = giftboxArrayResult[i]["name"].stringValue
                    let price = giftboxArrayResult[i]["price"].int
                    let description = giftboxArrayResult[i]["description"].stringValue
                    let pdf_url = giftboxArrayResult[i]["pdf_url"].stringValue
                    let review = giftboxArrayResult[i]["review"].int
                    let deleted_at = giftboxArrayResult[i]["deleted_at"].stringValue
                    let created_at = giftboxArrayResult[i]["created_at"].stringValue
                    let updated_at = giftboxArrayResult[i]["updated_at"].stringValue
                    let floatPrice = Float(price!)
                    let decimalPrice : Float = floatPrice / 100
                    let image = "https://dev.blissbox.asia/storage/giftboxes/" + thumbnail
                    
                    //                    let retrieveData = giftboxData.init(id: id!, universe_id: universe_id!, initial: initial, thumbnail: image, name: name, price: decimalPrice, description: description, pdf_url: pdf_url, review: review!, deleted_at: deleted_at!, created_at: created_at!, updated_at: updated_at)
                    let retrieveData = giftboxData.init(name: name, price: decimalPrice, thumbnail: image, description: description)
                    self.giftboxDataClass.giftboxArray.append(retrieveData)
                    
                }
                
                
            }else{
                print("Error \(response.result.error)")
            }
            DispatchQueue.main.async {
                self.outCollectioViewFeatureBox.reloadData()
                self.activityIndicatorView.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
            }
        }
    }
    
    func createSearchBar(){
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Enter your search here!"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //learning github
    
}

