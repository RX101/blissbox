//
//  MyAccountViewController.swift
//  Blissbox_new_template
//
//  Created by ANG RUI XIAN  on 28/12/17.
//  Copyright © 2017 ANG RUI XIAN . All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var arrayMyAccount : [String] = ["Login","My Giftbox","Activate Voucher","My Orders","Change Password","Add Payment Method"]

    @IBOutlet weak var outTableViewMyAccount: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        outTableViewMyAccount.delegate = self
        outTableViewMyAccount.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMyAccount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMyAccount", for: indexPath)
        cell.textLabel?.text = arrayMyAccount[indexPath.row]
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let selectedRow = arrayMyAccount[row]
        if(selectedRow == "Login"){
//           presentDetail(LoginViewController())
            performSegue(withIdentifier: "myAccountToLogin", sender: self)
//            arrayMyAccount.append("Logout")
//            arrayMyAccount.removeFirst()
//            tableView.reloadData()
        }else if (selectedRow == "Logout"){
            arrayMyAccount.insert("Login", at: 0)
            arrayMyAccount.removeLast()
            tableView.reloadData()
        }
    }
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        outTableViewMyAccount.reloadData()
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
