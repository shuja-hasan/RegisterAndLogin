//
//  RestApiManager.swift
//  RegisterAndLoginTask
//
//  Created by Shuja Hasan on 27/10/2016.
//  Copyright © 2016 Shuja Hasan. All rights reserved.
//

import Foundation

typealias ServiceResponse = (NSDictionary, NSError?) -> Void

class RestApiManager: NSObject {
    
    static let sharedInstance = RestApiManager();
    
    let baseURL = "https://aqueous-river-46656.herokuapp.com/api/v1/";
    
    func initializeNetworkRequest(_ params: Dictionary<String, String>, _ stringURLPath: NSString, onCompletion: @escaping (NSDictionary) -> Void) {
        let route = baseURL;
        
        let finalURL = route+(stringURLPath as String)
        
        performNetworkTask(params, path: finalURL, onCompletion: {json, error in
            onCompletion(json as NSDictionary);
        });
    }
    
    func performNetworkTask(_ params: Dictionary<String, String>, path: String, onCompletion: @escaping ServiceResponse) {
        
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL);
        request.httpMethod = "POST"
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared;
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            onCompletion(json as! NSDictionary, error as NSError?);
        });
        task.resume();
    }
    
}
