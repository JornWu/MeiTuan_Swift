//
//	SC_Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct SC_Data{

	var count : Int!
	var mId : Int!
	var index : Int!
	var list : [SC_List]!
	var name : String!
	var parentID : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		count = dictionary["count"] as? Int
		mId = dictionary["id"] as? Int
		index = dictionary["index"] as? Int
		list = [SC_List]()
		if let listArray = dictionary["list"] as? [NSDictionary]{
			for dic in listArray{
				let value = SC_List(fromDictionary: dic)
				list.append(value)
			}
		}
		name = dictionary["name"] as? String
		parentID = dictionary["parentID"] as? Int
	}

}