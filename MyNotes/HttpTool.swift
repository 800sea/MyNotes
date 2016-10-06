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
        
        var par = parameters
        //在参数中添加 密匙
        par = ["consumer_key":(consumer_key as AnyObject?)!]
        Alamofire.request("https://my.oschina.net/u/2340880/blog/469916", method: .get, parameters: par).responseData {
            response in
            guard let data = response.data else { return }
            let a:String = String.init(data: data, encoding: String.Encoding.utf8)!
                //print("JSON--: \(a) ----")
            success!(a as AnyObject)
        }
    }
}
