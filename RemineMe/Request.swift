//
//  Request.swift
//  RemineMe
//
//  Created by Odselmaa Dorjsuren on 12/6/17.
//  Copyright © 2017 Odselmaa Dorjsuren. All rights reserved.
//

import Foundation
import SwiftHTTP

protocol RequestProtocol {
    func didReceiveResponse(result: Any?)
}

class Request{
    static let instance = Request()
    private init(){}
    var dataDelegate:RequestProtocol?
    
    public func send_post_request(params:  Dictionary<String,Any>, url: String){
        HTTP.POST(url, parameters:params, requestSerializer: JSONParameterSerializer())
        { response in
            self.dataDelegate?.didReceiveResponse(result: response.data)
        }
    }
    public func send_get_request(params:  Dictionary<String,Any>, url: String){
        let opt = HTTP.GET(url, parameters:params, requestSerializer: JSONParameterSerializer())
        opt?.onFinish = { response in
            self.dataDelegate?.didReceiveResponse(result: response.data)
        }
    }
}
