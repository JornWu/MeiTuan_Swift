//
//	Deal.swift
//
//	Create by JornWu on 16/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Deal{

	var attrJson : [AttrJson]!
	var brandname : String!
	var campaignprice : Int!
	var campaigns : [Campaign]!
	var cate : String!
	var cateDesc : String!
	var channel : String!
	var coupontitle : String!
	var ctype : Int!
	var discountDesc : String!
	var discountShowType : Int!
	var dt : Int!
	var festcanuse : Int!
	var id : Int!
	var imgurl : String!
	var mdcLogoUrl : String!
	var mealcount : String!
	var mlls : String!
	var mtitle : String!
	var nobooking : Int!
	var price : Int!
	var range : String!
	var ratecount : Int!
	var rating : Int!
	var smstitle : String!
	var squareimgurl : String!
	var status : Int!
	var subcate : String!
	var title : String!
	var value : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		attrJson = [AttrJson]()
		if let attrJsonArray = dictionary["attrJson"] as? [NSDictionary]{
			for dic in attrJsonArray{
				let value = AttrJson(fromDictionary: dic)
				attrJson.append(value)
			}
		}
		brandname = dictionary["brandname"] as? String
		campaignprice = dictionary["campaignprice"] as? Int
		campaigns = [Campaign]()
		if let campaignsArray = dictionary["campaigns"] as? [NSDictionary]{
			for dic in campaignsArray{
				let value = Campaign(fromDictionary: dic)
				campaigns.append(value)
			}
		}
		cate = dictionary["cate"] as? String
		cateDesc = dictionary["cateDesc"] as? String
		channel = dictionary["channel"] as? String
		coupontitle = dictionary["coupontitle"] as? String
		ctype = dictionary["ctype"] as? Int
		discountDesc = dictionary["discountDesc"] as? String
		discountShowType = dictionary["discountShowType"] as? Int
		dt = dictionary["dt"] as? Int
		festcanuse = dictionary["festcanuse"] as? Int
		id = dictionary["id"] as? Int
        
        imgurl = String.URLStringHttpToHttps(dictionary["imgurl"] as! String)//改成https
//        if dictionary["imgurl"] != nil && dictionary["imgurl"] as! String != "" {
//            imgurl = String.URLStringHttpToHttps(dictionary["imgurl"] as! String)
//            imgurl = String.URLStringW_HTo200_120(imgurl)
//        }else {
//            imgurl = dictionary["imgurl"] as? String
//        }
        
        
		mdcLogoUrl = String.URLStringHttpToHttps(dictionary["mdcLogoUrl"] as! String)//改成https
        
		mealcount = dictionary["mealcount"] as? String
		mlls = dictionary["mlls"] as? String
		mtitle = dictionary["mtitle"] as? String
		nobooking = dictionary["nobooking"] as? Int
		price = dictionary["price"] as? Int
		range = dictionary["range"] as? String
		ratecount = dictionary["rate-count"] as? Int
		rating = dictionary["rating"] as? Int
		smstitle = dictionary["smstitle"] as? String
        
		squareimgurl = String.URLStringHttpToHttps(dictionary["squareimgurl"] as! String)
        
		status = dictionary["status"] as? Int
		subcate = dictionary["subcate"] as? String
		title = dictionary["title"] as? String
		value = dictionary["value"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if attrJson != nil{
			var dictionaryElements = [NSDictionary]()
			for attrJsonElement in attrJson {
				dictionaryElements.append(attrJsonElement.toDictionary())
			}
			dictionary["attrJson"] = dictionaryElements
		}
		if brandname != nil{
			dictionary["brandname"] = brandname
		}
		if campaignprice != nil{
			dictionary["campaignprice"] = campaignprice
		}
		if campaigns != nil{
			var dictionaryElements = [NSDictionary]()
			for campaignsElement in campaigns {
				dictionaryElements.append(campaignsElement.toDictionary())
			}
			dictionary["campaigns"] = dictionaryElements
		}
		if cate != nil{
			dictionary["cate"] = cate
		}
		if cateDesc != nil{
			dictionary["cateDesc"] = cateDesc
		}
		if channel != nil{
			dictionary["channel"] = channel
		}
		if coupontitle != nil{
			dictionary["coupontitle"] = coupontitle
		}
		if ctype != nil{
			dictionary["ctype"] = ctype
		}
		if discountDesc != nil{
			dictionary["discountDesc"] = discountDesc
		}
		if discountShowType != nil{
			dictionary["discountShowType"] = discountShowType
		}
		if dt != nil{
			dictionary["dt"] = dt
		}
		if festcanuse != nil{
			dictionary["festcanuse"] = festcanuse
		}
		if id != nil{
			dictionary["id"] = id
		}
		if imgurl != nil{
			dictionary["imgurl"] = imgurl
		}
		if mdcLogoUrl != nil{
			dictionary["mdcLogoUrl"] = mdcLogoUrl
		}
		if mealcount != nil{
			dictionary["mealcount"] = mealcount
		}
		if mlls != nil{
			dictionary["mlls"] = mlls
		}
		if mtitle != nil{
			dictionary["mtitle"] = mtitle
		}
		if nobooking != nil{
			dictionary["nobooking"] = nobooking
		}
		if price != nil{
			dictionary["price"] = price
		}
		if range != nil{
			dictionary["range"] = range
		}
		if ratecount != nil{
			dictionary["rate-count"] = ratecount
		}
		if rating != nil{
			dictionary["rating"] = rating
		}
		if smstitle != nil{
			dictionary["smstitle"] = smstitle
		}
		if squareimgurl != nil{
			dictionary["squareimgurl"] = squareimgurl
		}
		if status != nil{
			dictionary["status"] = status
		}
		if subcate != nil{
			dictionary["subcate"] = subcate
		}
		if title != nil{
			dictionary["title"] = title
		}
		if value != nil{
			dictionary["value"] = value
		}
		return dictionary
	}

}