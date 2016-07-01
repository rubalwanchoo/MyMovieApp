//
//  LoginViewController.swift
//  MyMovieApp
//
//  Created by Rubal Wanchoo on 6/29/16.
//  Copyright © 2016 wanchoo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    //MARK:Varibale Declarations
    let userName:String = "rubalwanchoo"
    let password:String = "tanyawanchoo1"
    
    var appDelegate:AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate=UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        authenticate()
        
    }
    
    
    func authenticate()->Void{
        
        
        /*
         Steps for Authentication...
         https://www.themoviedb.org/documentation/api/sessions
         
         Step 1: Create a request token
         Step 2: Ask the user for permission via the API ("login")
         Step 3: Create a session ID
         
         Extra Steps...
         Step 4: Get the user id ;)
         Step 5: Go to the next view!
         */
        
        
        getRequestToken()
        
    }

    
    func getRequestToken()->Void{
        
        //This is a temporary token that is required to ask the user for permission to access their account. This token will auto expire after 60 minutes if it's not used
        //http://api.themoviedb.org/3/authentication/token/new?api_key=286a627b92ed9226a1229a4bc096db2e
        
        
        
        let myURL = appDelegate.getTMDBURLWithExtension(Constants.TMDB.ApiPathTokenNew,additionalParams: [:])
        
        print("URL -" + myURL.description)
        
        let myRequest = NSURLRequest(URL: myURL)
        
        
        let myTask = appDelegate.mySession.dataTaskWithRequest(myRequest) { (data, response, error) in
            
            //Check if error is nil
            guard (error==nil) else{
                print("Error with request- " + error!.description)
                return
            }
            
            //Check if response headers returned non 200 status code
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode>=200 && statusCode<=299 else{
                print("Service replied with Message-" + ((response as? NSHTTPURLResponse)!.allHeaderFields[Constants.TMDBResponseKeys.Status] as! String))
                return
            }
            
            //Checlk if data is present in the response
            guard let data=data else{
                print("No data in response")
                return
            }
            
            print("Response Data -" + data.description)
            
            //Parse the JSON out of the data
            let parsedResult:AnyObject!
            do{
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                
                print("Parsed JSON - " + parsedResult!.description)
                
            }catch{
                print("Error parsing response data")
                return
            }
            
            
            //Check if parsed JSON has an error in its Status code. In this case, if status code is present in the parsed JSON, that will always be an error
            if let _=parsedResult[Constants.TMDBResponseKeys.StatusCode] as? Int{
                print("The MOVIEDB returned an error- " + parsedResult.description)
                return
            }
            
            
            //Check if requestToke is present
            guard let requestToken = parsedResult[Constants.TMDBResponseKeys.RequestToken] as? String else{
                
                print("Request Token cannot be found in the parsed JSON response - " + parsedResult.description)
                return
            }
        
            
            self.appDelegate.requestToken=requestToken
            print("Request Token -" + requestToken)
            
            
            //Call the nexr step to validate login credentials
            self.validateLoginCredentials(self.appDelegate.requestToken!)

            
        } // End myTask
        
        myTask.resume()

        
    }//end getRequestToken
    
    
    
    
    func validateLoginCredentials(requestToken:String){
        //https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=286a627b92ed9226a1229a4bc096db2e&request_token=b89961de79b2f1be07caaf6ff57b1c340d41fd18&username=rubalwanchoo&password=tanyawanchoo
        
        let myURL = appDelegate.getTMDBURLWithExtension(Constants.TMDB.ApiPathValidateWithToken,additionalParams: [Constants.TMDBParameterKeys.RequestToken:requestToken,Constants.TMDBParameterKeys.Username:self.userName,Constants.TMDBParameterKeys.Password:self.password])
        
        
        print("URL -" + myURL.description)
        
        let myRequest = NSURLRequest(URL: myURL)
        
        let myTask = appDelegate.mySession.dataTaskWithRequest(myRequest) { (data, response, error) in
            
            
            //Check if error is nil
            guard (error==nil) else{
                print("Error with request- " + error!.description)
                return
            }
            
            //Check if response headers returned non 200 status code
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode>=200 && statusCode<=299 else{
                print("Service replied with Message-" + ((response as? NSHTTPURLResponse)!.allHeaderFields[Constants.TMDBResponseKeys.Status] as! String))
                return
            }
            
            //Checlk if data is present in the response
            guard let data=data else{
                print("No data in response")
                return
            }
            
            print("Response Data -" + data.description)
            
            //Parse the JSON out of the data
            let parsedResult:AnyObject!
            do{
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                
                print("Parsed JSON - " + parsedResult!.description)
                
            }catch{
                print("Error parsing response data")
                return
            }
            
            
            //Check if parsed JSON has an error in its Status code. In this case, if status code is present in the parsed JSON, that will always be an error
            if let _=parsedResult[Constants.TMDBResponseKeys.StatusCode] as? Int{
                print("The MOVIEDB returned an error- " + parsedResult.description)
                return
            }
            
            
            guard let success=parsedResult[Constants.TMDBResponseKeys.Success] as? Bool where success == true else{
                print("API response failed - "+parsedResult.description)
                return
            }
            
            self.getSessionId(self.appDelegate.requestToken!)

        }// End MyTask
        
        
        myTask.resume()
        
    }// end validateLoginCredentials


    
    func getSessionId(requestToken:String){
        
        //The results of this query will return a session_id value. You should treat this value like a password. Store it securely. This is the value required in all of our write methods.
        
        //http://api.themoviedb.org/3/authentication/session/new?api_key=286a627b92ed9226a1229a4bc096db2e&request_token=7b89eecd3dd321f7c23fd25fe3ca633626b2ee92
        
        
        let myURL = appDelegate.getTMDBURLWithExtension(Constants.TMDB.ApiAuthenticateSessionNew,additionalParams: [Constants.TMDBParameterKeys.RequestToken:requestToken])
        
        
        print("URL -" + myURL.description)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }//end getSessionId

}

