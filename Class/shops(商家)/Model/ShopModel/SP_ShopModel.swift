//
//	SP_ShopModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct SP_ShopModel{

	var count : Int!
	var ctPoi : String!
	var ctPois : [SP_CtPoi]!
	var data : [SP_Data]!
	var serverInfo : SP_ServerInfo!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		count = dictionary["count"] as? Int
		ctPoi = dictionary["ct_poi"] as? String
		ctPois = [SP_CtPoi]()
		if let ctPoisArray = dictionary["ct_pois"] as? [NSDictionary]{
			for dic in ctPoisArray{
				let value = SP_CtPoi(fromDictionary: dic)
				ctPois.append(value)
			}
		}
		data = [SP_Data]()
		if let dataArray = dictionary["data"] as? [NSDictionary]{
			for dic in dataArray{
				let value = SP_Data(fromDictionary: dic)
				data.append(value)
			}
		}
		if let serverInfoData = dictionary["serverInfo"] as? NSDictionary{
				serverInfo = SP_ServerInfo(fromDictionary: serverInfoData)
			}
	}

}