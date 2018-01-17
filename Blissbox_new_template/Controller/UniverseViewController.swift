//
//  UniverseViewController.swift
//  Blissbox_new_template
//
//  Created by ANG RUI XIAN  on 12/1/18.
//  Copyright © 2018 ANG RUI XIAN . All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UniverseViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var outCollectionView: UICollectionView!
    
    let URL = "https://dev.blissbox.asia/api/giftbox/all"
    // data structure to store data for the DataController
    let giftboxDataClass = giftboxData.sharedInstance
    let fileAPI = apiFile.sharedInstance
    var headers: HTTPHeaders = [:]
    var api = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjRmYTY5YzJiNmUwNzRkNDk4NmZkZWZmNjRhODFmZjc0MmJlNjliNTQ0YmFmZGRlNDExYjhlNjg5OTQ0ODQ2OGFkMjdkNDZiNTUyNjNjYmQxIn0.eyJhdWQiOiI1IiwianRpIjoiNGZhNjljMmI2ZTA3NGQ0OTg2ZmRlZmY2NGE4MWZmNzQyYmU2OWI1NDRiYWZkZGU0MTFiOGU2ODk5NDQ4NDY4YWQyN2Q0NmI1NTI2M2NiZDEiLCJpYXQiOjE1MTAyMTU3MDAsIm5iZiI6MTUxMDIxNTcwMCwiZXhwIjoxNTQxNzUxNzAwLCJzdWIiOiIxMCIsInNjb3BlcyI6W119.gVwm4kgq3FROqeNr-P1AE1wNdhtCsBrmMPORHo96_J9oMTyQhaxEvzn5T6qWGO4gfxPXhKnF6YCSBhXE5JjjJgtWZqybjqXx7YO1ERNdKn_XI2qZmsQ_3BpzCB2CQfTUSCOdrWZcEZuyZ5ixV3m6Zr8jdUbZUSUdl-GjKML6aGSOuYFXcFNpL56pF_OYcYPwmVgqjincQlWgUbZP0wYMk3badIBjXzYJZ9xqZTY_3E1Chdfxp6ul2gzUzWjmariFSrhvKtI0nbAfBvQCdi8mOdhlxR_zXY79PQYM6_btD-sK1hrOkmkCU9abFp_Gwr9cXCbQCfOS3J58Om_cnlYi9KF6p_VZpabRV0tZeEQ2D6nHodmCkwAhJTDAk4xMq8wLMqfDJFfhWfMDzMhGl8KlEITXj5qkLgI5S9oklCrqawzlgPr_bVAf-gR6UP_boplaufI6SaiTKSMH7Ff7WmRjEQINheq1YuaOj4hVBfCOXOrLOQ6Gnk0WPN9x0mVNZoZtR3A4SEQgZhIT3Y5q5FuNmnjbSJyuZBADrNHmJTZzi8c4EgEkW20rcY78QmnUmDqL8gTPzXNyrzJZWcfeCJYsx2LgEF66ysicu6_xVIykJV4KlSabfABUV5M3GIOiJ40nrMXZtCwpysW6YfqR0MXA0TOMALLBjCZ6Ofsb1-JgtUE"
    var universeId = 1
    var selectedgiftbox = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        headers = ["Authorization": "Bearer \(api)","Accept": "application/json"]
        displayGiftbox(url: URL)
        
        outCollectionView?.dataSource = self
        outCollectionView?.delegate = self
        
        print("universe id: \(universeId)")
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.giftboxDataClass.giftboxArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "universeCollectionViewCell",for: indexPath) as! UniverseCollectionViewCell
        
        // get the item number
        let item = indexPath.item
        let row = indexPath.row
        cell.outLabel.text = self.giftboxDataClass.giftboxArray[row].name
        cell.outImageView.sd_setImage(with: Foundation.URL(string: self.giftboxDataClass.giftboxArray[row].thumbnail!))
        return cell
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
                    
                    //                    let retrieveData = giftboxData.init(id: id!, universe_id: universe_id!, initial: initial, thumbnail: thumbnail, name: name, price: Float(price!), description: description, pdf_url: pdf_url, review: review!, deleted_at: deleted_at, created_at: created_at, updated_at: updated_at)
                    let retrieveData = giftboxData.init(name: name, price: decimalPrice, thumbnail: image, description: description,universe_Id: 1)
                    self.giftboxDataClass.giftboxArray.append(retrieveData)
                    
                }
                
                
            }else{
                print("Error \(response.result.error)")
            }
            DispatchQueue.main.async {
                self.outCollectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        fileAPI.row = row
        performSegue(withIdentifier: "universe_giftbox_details", sender: self)
        
    }
    //    // this method is called before a segue is performed from this view controller
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        // the UIStoryboardSegue object has a property called identifier
    //        // which holds the identifier of the segue
    //        let identifier = segue.identifier
    //
    //        if (identifier == "universe_giftbox_details") {
    //            // the UIStoryboardSegue object has a property called destination
    //            // which holds the destination view controller
    //            // we need to cast the destination view controller to the actual type
    //            // in this specific example, the destination view controller is NextViewController
    //            let vc = segue.destination as! GiftboxDetailsViewController
    //
    //            // we can set properties on the destination view controller
    //            // in this specific example, NextViewController has a property called passedString
    //            vc.passedTitle = selectedgiftbox
    //        }
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
