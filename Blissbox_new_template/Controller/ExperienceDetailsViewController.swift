//
//  ExperienceDetailsViewController.swift
//  Blissbox_new_template
//
//  Created by ANG RUI XIAN  on 10/1/18.
//  Copyright © 2018 ANG RUI XIAN . All rights reserved.
//

import UIKit

class ExperienceDetailsViewController: UIViewController {
    
    @IBOutlet weak var outImageViewExperience: UIImageView!
    @IBOutlet weak var outLabelExperienceName: UILabel!
    @IBOutlet weak var outLabelExperienceInformation: UITextView!
    @IBOutlet weak var outLabelPax: UILabel!
    @IBOutlet weak var outLabelDuration: UILabel!
    @IBOutlet weak var outLabelAddress: UILabel!

    let index = apiFile.sharedInstance.experienceRow
    let experienceDataClass = experienceData.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let selectedExperience = experienceDataClass.get(index: index)
        outImageViewExperience.sd_setImage(with: Foundation.URL(string: selectedExperience.thumbnail!))
        outLabelExperienceName.text = "Experience: \(selectedExperience.name!)"
        outLabelExperienceInformation.text = "\(selectedExperience.information!)"
        outLabelPax.text = "Number of Pax: \(selectedExperience.pax!)"
        outLabelDuration.text = "Duration: \(selectedExperience.duration!)"
        outLabelAddress.text = "Address: \(selectedExperience.address!)"
        
    }
    
    @IBAction func actButtonAddToCart(_ sender: UIButton) {
    }
    
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
