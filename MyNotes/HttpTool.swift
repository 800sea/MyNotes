//
//  HttpTool.swift
//  MyNotes
//
//  Created by sea on 16/9/26.
//  Copyright © 2016年 sea. All rights reserved.
//  网络请求

import Foundation
import Alamofire

class HttpTool:NSObject{
    //数据请求方式
    enum requestType:String {
        case POST
        case GET
    }
    let consumer_key = "hlBiOx8o8Iydm2IP759dr76i3LfXSyz31TjJKpVQ"
    //请求
    func requestWithUrl(type:Alamofire.HTTPMethod,url:String, parameters:[String:AnyObject]? = nil,success:((_ data:AnyObject) -> Void)? = nil,fail:((_ e:Error) -> Void)? = nil) {
        
        //var parameters = parameters
        var par = parameters
        //在参数中添加 密匙
        par?["consumer_key"] = consumer_key as AnyObject?
        Alamofire.request(url, method: .get, parameters: par).responseJSON {
            response in
            guard let JSON = response.result.value else { return }
            print("JSON: \(JSON)")
        }
        
        
    }
    
    
}
