//
//	Data.swift
//
//	Create by JornWu on 16/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Data{

	var activityImgUrl : String!
	var countdownText : String!
	var deals : [Deal]!
	var descAfter : String!
	var descBefore : String!
	var descIn : String!
	var end : Int!
	var id : Int!
	var isShowCateDesc : Int!
	var isShowTimeCountdown : Int!
	var listJumpToTouch : Int!
	var share : Share!
	var start : Int!
	var title : String!
	var touchUrlForList : String!
	var type : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		activityImgUrl = String.URLStringHttpToHttps(dictionary["activityImgUrl"] as! String)//to https
        
		countdownText = dictionary["countdownText"] as? String
		deals = [Deal]()
		if let dealsArray = dictionary["deals"] as? [NSDictionary]{
			for dic in dealsArray{
				let value = Deal(fromDictionary: dic)
				deals.append(value)
			}
		}
		descAfter = dictionary["descAfter"] as? String
		descBefore = dictionary["descBefore"] as? String
		descIn = dictionary["descIn"] as? String
		end = dictionary["end"] as? Int
		id = dictionary["id"] as? Int
		isShowCateDesc = dictionary["isShowCateDesc"] as? Int
		isShowTimeCountdown = dictionary["isShowTimeCountdown"] as? Int
		listJumpToTouch = dictionary["listJumpToTouch"] as? Int
		if let shareData = dictionary["share"] as? NSDictionary{
				share = Share(fromDictionary: shareData)
			}
		start = dictionary["start"] as? Int
		title = dictionary["title"] as? String
		touchUrlForList = dictionary["touchUrlForList"] as? String
		type = dictionary["type"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if activityImgUrl != nil{
			dictionary["activityImgUrl"] = activityImgUrl
		}
		if countdownText != nil{
			dictionary["countdownText"] = countdownText
		}
		if deals != nil{
			var dictionaryElements = [NSDictionary]()
			for dealsElement in deals {
				dictionaryElements.append(dealsElement.toDictionary())
			}
			dictionary["deals"] = dictionaryElements
		}
		if descAfter != nil{
			dictionary["descAfter"] = descAfter
		}
		if descBefore != nil{
			dictionary["descBefore"] = descBefore
		}
		if descIn != nil{
			dictionary["descIn"] = descIn
		}
		if end != nil{
			dictionary["end"] = end
		}
		if id != nil{
			dictionary["id"] = id
		}
		if isShowCateDesc != nil{
			dictionary["isShowCateDesc"] = isShowCateDesc
		}
		if isShowTimeCountdown != nil{
			dictionary["isShowTimeCountdown"] = isShowTimeCountdown
		}
		if listJumpToTouch != nil{
			dictionary["listJumpToTouch"] = listJumpToTouch
		}
		if share != nil{
			dictionary["share"] = share.toDictionary()
		}
		if start != nil{
			dictionary["start"] = start
		}
		if title != nil{
			dictionary["title"] = title
		}
		if touchUrlForList != nil{
			dictionary["touchUrlForList"] = touchUrlForList
		}
		if type != nil{
			dictionary["type"] = type
		}
		return dictionary
	}

}