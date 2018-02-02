//
//  LoginViewController.swift
//  Blissbox_new_template
//
//  Created by ANG RUI XIAN  on 2/1/18.
//  Copyright © 2018 ANG RUI XIAN . All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import FBSDKLoginKit
import GoogleSignIn
import Google

class LoginViewController: UIViewController,UITextFieldDelegate, FBSDKLoginButtonDelegate,GIDSignInUIDelegate,GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil{
            print(error)
            return
        }
        print(user.profile.email)
        print(user.profile.name)
        print(user.profile.description)
        print(user.profile.imageURL(withDimension: 400))
    }
    
    
    let URL = "https://dev.blissbox.asia/api/login"
    var token = ""
    let fileAPI = apiFile.sharedInstance
    
    @IBOutlet weak var outTextFieldLoginEmail: UITextField!
    @IBOutlet weak var outTextFieldLoginPassword: UITextField!
    @IBOutlet weak var outButtonLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate()
        outTextFieldLoginEmail.text = "ruixian@blissbox.asia"
        outTextFieldLoginPassword.text = "password"
        //method to check for empty textField
        setupAddTargetIsNotEmptyTextFields()
//        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        let loginButton = FBSDKLoginButton()
        loginButton.frame = CGRect(x: 16, y: 500, width: view.frame.width - 32, height: 50)
        view.addSubview(loginButton)
        
        loginButton.delegate = self
        loginButton.readPermissions = ["email","public_profile","user_friends"]
        
        var error : NSError?
        GGLContext.sharedInstance().configureWithError(&error)
        if error != nil{
            print(error)
            return
        }
        
        DispatchQueue.main.async {
            GIDSignIn.sharedInstance().uiDelegate = self
            GIDSignIn.sharedInstance().delegate = self
        }
        let signInButton = GIDSignInButton(frame:CGRect(x: 16, y: 570, width: view.frame.width - 32, height: 50))
        view.addSubview(signInButton)
        //dismiss keyboard while scrolling
        //        scrollView.keyboardDismissMode = .onDrag
//        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
    }
    
    @IBAction func actButtonForgetPassword(_ sender: UIButton) {
        alertForgetPassword()
    }
    
    @IBAction func actButtonRegister(_ sender: UIButton) {
        performSegue(withIdentifier: "loginToRegister", sender: self)
    }
    
    @IBAction func actButtonLogin(_ sender: UIButton) {
        let email = self.outTextFieldLoginEmail.text!
        let password = self.outTextFieldLoginPassword.text!
        let params : [String:String] = ["email" : email, "password" : password]
        getToken(url: URL, parameters: params)
    }
    
    //MARK: - GetToken Button
    /***************************************************************/
    //Write the getToken method here:
    func getToken(url: String, parameters: [String:String]){
        Alamofire.request(url, method: .post,parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess{
                print("Success! Got the token")
                
                let tokenJSON : JSON = JSON(response.result.value!)
                print(tokenJSON)
                let tokenResult = tokenJSON["message"]["token"]
                let statusResult = tokenJSON["status"].int!
                self.token = tokenResult.stringValue
                if (statusResult == 401){
                    self.alertErrorMessage(message: "Email or Password is wrong.")
                }else if (statusResult == 200){
                    self.fileAPI.apikey = self.token
                    //                    print(self.fileAPI.apikey)
                    self.performSegue(withIdentifier: "loginSuccessful", sender: self)
                }
            }else{
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    //MARK: - Forget PasswordButton
    /***************************************************************/
    //Write the getToken method here:
//    func forgetPassword(url: String, parameters: [String:String]){
//        Alamofire.request(url, method: .post,parameters: parameters).responseJSON {
//            response in
//            if response.result.isSuccess{
//                print("Success! Change the password")
//
//                let tokenJSON : JSON = JSON(response.result.value!)
//                print(tokenJSON)
//                let tokenResult = tokenJSON["message"]["token"]
//                let statusResult = tokenJSON["status"].int!
//                self.token = tokenResult.stringValue
//                if (statusResult == 401){
//                    self.alertErrorMessage(message: "Email or Password is wrong.")
//                }else if (statusResult == 200){
//                    self.fileAPI.apikey = self.token
//                    //                    print(self.fileAPI.apikey)
//                    self.performSegue(withIdentifier: "loginSuccessful", sender: self)
//                }
//            }else{
//                print("Error \(String(describing: response.result.error))")
//            }
//        }
//    }
    
    func setupAddTargetIsNotEmptyTextFields() {
        outButtonLogin.isEnabled = false //unenable login button
        outTextFieldLoginEmail.addTarget(self, action: #selector(textFieldsIsNotEmpty),for: .editingChanged)
        outTextFieldLoginPassword.addTarget(self, action: #selector(textFieldsIsNotEmpty),for: .editingChanged)
        
    }
    
    func delegate(){
        outTextFieldLoginEmail.delegate = self
        outTextFieldLoginPassword.delegate = self
    }
    
    //method to disable button when textField is empty
    @objc func textFieldsIsNotEmpty(sender: UITextField) {
        
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        
        guard
            let email = outTextFieldLoginEmail.text, !email.isEmpty, let password = outTextFieldLoginPassword.text, !password.isEmpty else{
                self.outButtonLogin.isEnabled = false
                return
        }
        // enable okButton if all conditions are met
        self.outButtonLogin.isEnabled = true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if (textField == self.outTextFieldLoginEmail) {
            self.outTextFieldLoginPassword.becomeFirstResponder()
        }else if (textField == self.outTextFieldLoginPassword) {
            self.outTextFieldLoginPassword.resignFirstResponder()
        }
        
        return true
    }
    
    func alertForgetPassword() {
        // create a UIAlertController object
        let alert = UIAlertController(title: "Forget Password",
                                      message: "",
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField{ (outTextFieldPinCode) in
            outTextFieldPinCode.placeholder = "Email Address"
            outTextFieldPinCode.keyboardType = UIKeyboardType.emailAddress;
            
            // add the UIAlertAction object to the UIAlertController object
            alert.addAction(UIAlertAction(title: "Reset My Password", style: .default) { (action) in
                guard !alert.textFields![0].text!.isEmpty else {
                    return
                }
                if(!alert.textFields![0].text!.isEmpty){
                    let email : String = alert.textFields![0].text!
                    
                    if(!email.isEmpty){
//                        self.view.makeToast(email)
                    }else{
//                        self.view.makeToast("Please Enter Benefieiary email.")
                    }
                }
                
            })
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            
            
            
        }
        // display the UIAlertController object
        self.present(alert, animated: true, completion: nil)
        
    }
    func alertErrorMessage( message : String) {
        // create a UIAlertController object
        let alert = UIAlertController(title: "Login Failed",
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        // display the UIAlertController object
        self.present(alert, animated: true, completion: nil)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }
    
    func showEmailAddress() {
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            
            if err != nil {
                print("Failed to start graph request:", err)
                return
            }
            print(result!)
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil{
            print(error)
            return
        }
        
        print("Successfully logged in with facebook...")
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"email, name, id"]).start { (connection, result, err) in
            if err != nil {
                print("Failed to start graph request:",err)
                return
            }
            print(result!)
        }
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
