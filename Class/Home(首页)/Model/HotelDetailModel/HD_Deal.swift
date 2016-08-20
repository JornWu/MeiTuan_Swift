//
//	HD_Deal.swift
//
//	Create by JornWu on 20/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct HD_Deal{

	var attrJson : [AnyObject]!
	var brandname : String!
	var cate : String!
	var channel : String!
	var ctype : Int!
	var digestion : String!
	var dt : Int!
	var festcanuse : Int!
	var mId : Int!
	var imgurl : String!
	var mealcount : String!
	var mlls : String!
	var nobooking : Int!
	var price : Int!
	var range : String!
	var slug : String!
	var solds : Int!
	var subcate : String!
	var title : String!
	var value : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		attrJson = dictionary["attrJson"] as? [AnyObject]
		brandname = dictionary["brandname"] as? String
		cate = dictionary["cate"] as? String
		channel = dictionary["channel"] as? String
		ctype = dictionary["ctype"] as? Int
		digestion = dictionary["digestion"] as? String
		dt = dictionary["dt"] as? Int
		festcanuse = dictionary["festcanuse"] as? Int
		mId = dictionary["id"] as? Int
        
		imgurl = String.URLStringHttpToHttps(dictionary["imgurl"] as! String)
        
		mealcount = dictionary["mealcount"] as? String
		mlls = dictionary["mlls"] as? String
		nobooking = dictionary["nobooking"] as? Int
		price = dictionary["price"] as? Int
		range = dictionary["range"] as? String
		slug = dictionary["slug"] as? String
		solds = dictionary["solds"] as? Int
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
            dictionary["attrJson"] = attrJson
        }
        if brandname != nil{
            dictionary["brandname"] = brandname
        }
        if cate != nil{
            dictionary["cate"] = cate
        }
        if channel != nil{
            dictionary["channel"] = channel
        }
        if ctype != nil{
            dictionary["ctype"] = ctype
        }
        if digestion != nil{
            dictionary["digestion"] = digestion
        }
        if dt != nil{
            dictionary["dt"] = dt
        }
        if festcanuse != nil{
            dictionary["festcanuse"] = festcanuse
        }
        if mId != nil{
            dictionary["id"] = mId
        }
        if imgurl != nil{
            dictionary["imgurl"] = imgurl
        }
        if mealcount != nil{
            dictionary["mealcount"] = mealcount
        }
        if mlls != nil{
            dictionary["mlls"] = mlls
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
        if slug != nil{
            dictionary["slug"] = slug
        }
        if solds != nil{
            dictionary["solds"] = solds
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