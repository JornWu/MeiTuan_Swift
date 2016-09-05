//
//	SP_Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct SP_Data{

	var abstracts : SP_Abstract!
	var addr : String!
	var allowRefund : Int!
	var areaId : Int!
	var areaName : String!
	var avgPrice : Int!
	var avgScore : Int!
	var bizloginid : Int!
	var brandId : Int!
	var brandLogo : String!
	var brandName : String!
	var campaignTag : String!
	var cateId : Int!
	var cateName : String!
	var cates : String!
	var channel : String!
	var chooseSitting : Bool!
	var cityId : Int!
	var dayRoomSpan : Int!
	var discount : String!
	var extra : SP_Extra!
	var featureMenus : String!
	var floor : String!
	var frontImg : String!
	var groupInfo : Int!
	var hallTypes : [AnyObject]!
	var hasGroup : Bool!
	var historyCouponCount : Int!
	var hourRoomSpan : Int!
	var iUrl : String!
	var introduction : String!
	var isExclusive : Bool!
	var isHot : Int!
	var isImax : Bool!
	var isQueuing : Int!
	var isSnack : Bool!
	var isSuperVoucher : Int!
	var isSupportAppointment : Bool!
	var isWaimai : Int!
	var ktv : SP_Ktv!
	var ktvAppointStatus : Int!
	var ktvLowestPrice : Int!
	var lat : Float!
	var latestWeekCoupon : Int!
	var lng : Float!
	var location : String!
	var lowestPrice : Int!
	var mallId : Int!
	var markNumbers : Int!
	var name : String!
	var notice : String!
	var openInfo : String!
	var parkingInfo : String!
	var payAbstracts : [SP_PayAbstract]!
	var payInfo : SP_PayInfo!
	var phone : String!
	var poiid : String!
	var preTags : [AnyObject]!
	var preferent : Bool!
	var referencePrice : Int!
	var showType : String!
	var style : String!
	var subwayStationId : String!
	var tour : SP_Tour!
	var wifi : Bool!
	var zlSourceType : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		if let abstractsData = dictionary["abstracts"] as? NSDictionary{
				abstracts = SP_Abstract(fromDictionary: abstractsData)
			}
		addr = dictionary["addr"] as? String
		allowRefund = dictionary["allowRefund"] as? Int
		areaId = dictionary["areaId"] as? Int
		areaName = dictionary["areaName"] as? String
		avgPrice = dictionary["avgPrice"] as? Int
		avgScore = dictionary["avgScore"] as? Int
		bizloginid = dictionary["bizloginid"] as? Int
		brandId = dictionary["brandId"] as? Int
		brandLogo = dictionary["brandLogo"] as? String
		brandName = dictionary["brandName"] as? String
		campaignTag = dictionary["campaignTag"] as? String
		cateId = dictionary["cateId"] as? Int
		cateName = dictionary["cateName"] as? String
		cates = dictionary["cates"] as? String
		channel = dictionary["channel"] as? String
		chooseSitting = dictionary["chooseSitting"] as? Bool
		cityId = dictionary["cityId"] as? Int
		dayRoomSpan = dictionary["dayRoomSpan"] as? Int
		discount = dictionary["discount"] as? String
		if let extraData = dictionary["extra"] as? NSDictionary{
				extra = SP_Extra(fromDictionary: extraData)
			}
		featureMenus = dictionary["featureMenus"] as? String
		floor = dictionary["floor"] as? String
        
        if dictionary["frontImg"] != nil && dictionary["frontImg"] as! String != "" {
            frontImg = String.URLStringHttpToHttps(dictionary["frontImg"] as! String)
            frontImg = String.URLStringW_HTo200_120(frontImg)
        }else {
            frontImg = dictionary["frontImg"] as? String
        }
        
		groupInfo = dictionary["groupInfo"] as? Int
		hallTypes = dictionary["hallTypes"] as? [AnyObject]
		hasGroup = dictionary["hasGroup"] as? Bool
		historyCouponCount = dictionary["historyCouponCount"] as? Int
		hourRoomSpan = dictionary["hourRoomSpan"] as? Int
        
        iUrl = dictionary["iUrl"] as? String
        
		introduction = dictionary["introduction"] as? String
		isExclusive = dictionary["isExclusive"] as? Bool
		isHot = dictionary["isHot"] as? Int
		isImax = dictionary["isImax"] as? Bool
		isQueuing = dictionary["isQueuing"] as? Int
		isSnack = dictionary["isSnack"] as? Bool
		isSuperVoucher = dictionary["isSuperVoucher"] as? Int
		isSupportAppointment = dictionary["isSupportAppointment"] as? Bool
		isWaimai = dictionary["isWaimai"] as? Int
		if let ktvData = dictionary["ktv"] as? NSDictionary{
				ktv = SP_Ktv(fromDictionary: ktvData)
			}
		ktvAppointStatus = dictionary["ktvAppointStatus"] as? Int
		ktvLowestPrice = dictionary["ktvLowestPrice"] as? Int
		lat = dictionary["lat"] as? Float
		latestWeekCoupon = dictionary["latestWeekCoupon"] as? Int
		lng = dictionary["lng"] as? Float
		location = dictionary["location"] as? String
		lowestPrice = dictionary["lowestPrice"] as? Int
		mallId = dictionary["mallId"] as? Int
		markNumbers = dictionary["markNumbers"] as? Int
		name = dictionary["name"] as? String
		notice = dictionary["notice"] as? String
		openInfo = dictionary["openInfo"] as? String
		parkingInfo = dictionary["parkingInfo"] as? String
		payAbstracts = [SP_PayAbstract]()
		if let payAbstractsArray = dictionary["payAbstracts"] as? [NSDictionary]{
			for dic in payAbstractsArray{
				let value = SP_PayAbstract(fromDictionary: dic)
				payAbstracts.append(value)
			}
		}
		if let payInfoData = dictionary["payInfo"] as? NSDictionary{
				payInfo = SP_PayInfo(fromDictionary: payInfoData)
			}
		phone = dictionary["phone"] as? String
		poiid = dictionary["poiid"] as? String
		preTags = dictionary["preTags"] as? [AnyObject]
		preferent = dictionary["preferent"] as? Bool
		referencePrice = dictionary["referencePrice"] as? Int
		showType = dictionary["showType"] as? String
		style = dictionary["style"] as? String
		subwayStationId = dictionary["subwayStationId"] as? String
		if let tourData = dictionary["tour"] as? NSDictionary{
				tour = SP_Tour(fromDictionary: tourData)
			}
		wifi = dictionary["wifi"] as? Bool
		zlSourceType = dictionary["zlSourceType"] as? Int
	}

}