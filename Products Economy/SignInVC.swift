//
//  ViewController.swift
//  Products Economy
//
//  Created by Nobel on 7/3/17.
//  Copyright © 2017 Nobel. All rights reserved.
//

import UIKit
import Alamofire

class SignInVC: UIViewController {
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func SignInClicked(_ sender: Any) {
        if let email = emailField.text,let password = passwordField.text{
            let body: Parameters = [
                "username":email,
                "password":password
            ]
            Alamofire.request("\(BASE_URL)\(AUTHENTICATE_URL)", method: .post, parameters: body, encoding: JSONEncoding.default).validate().responseJSON{ response in
                
                if response.result.isSuccess {
                    if let dict = response.result.value as? Dictionary<String,AnyObject> {
                        if let token = dict["accessToken"] as? String {
                            var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
                            defaultHeaders["Authorization"] = "Bearer \(token)"
                            
                            let configuration = URLSessionConfiguration.default
                            configuration.httpAdditionalHeaders = defaultHeaders
                            
                            let sessionManager = Alamofire.SessionManager(configuration: configuration)
                            
                            DataService.sharedManager = sessionManager
                            self.performSegue(withIdentifier: "StoreVC", sender: nil)
                        }
                    }
                }
                else {
                    let alert = UIAlertController(title: "Authentication Error", message: "Username or Password is Incorrect", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
        }
    }
    
    @IBAction func unwindToSignIn(segue:UIStoryboardSegue) {
        self.emailField.text = ""
        self.passwordField.text = ""
    }

}

