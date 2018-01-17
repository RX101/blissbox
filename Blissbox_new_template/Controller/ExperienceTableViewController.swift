//
//  ExperienceTableViewController.swift
//  Blissbox_new_template
//
//  Created by ANG RUI XIAN  on 9/1/18.
//  Copyright © 2018 ANG RUI XIAN . All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class ExperienceTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var outTableViewExperience: UITableView!
    let experienceDataClass = experienceData.sharedInstance
    let fileAPI = apiFile.sharedInstance
    let URL = "https://dev.blissbox.asia/api/experience/all"
    var headers: HTTPHeaders = [:]
    var api = apiFile.sharedInstance.apikey
    override func viewDidLoad() {
        super.viewDidLoad()
        self.outTableViewExperience.delegate = self
        self.outTableViewExperience.dataSource = self
        headers = ["Authorization": "Bearer \(api)",
            "Accept": "application/json"]
        displayExperience(url: URL)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.outTableViewExperience.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return experienceDataClass.experienceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellExperience", for: indexPath) as! ExperienceTableViewCelll
        
        let row = indexPath.row
        
        if let experienceImage = cell.outImageViewExperience {
            experienceImage.sd_setImage(with: Foundation.URL(string: self.experienceDataClass.experienceArray[row].thumbnail!))
        }
        
        if let experienceName = cell.outLabelExperienceName{
            experienceName.text = self.experienceDataClass.experienceArray[row].name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        fileAPI.experienceRow = row
        performSegue(withIdentifier: "experienceToExperienceDetails", sender: self)
    }
    
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
                self.outTableViewExperience.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
