//
//	SC_List.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct SC_List{

	var count : Int!
	var mId : Int!
	var index : Int!
	var name : String!
	var onRed : Bool!
	var parentID : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		count = dictionary["count"] as? Int
		mId = dictionary["id"] as? Int
		index = dictionary["index"] as? Int
		name = dictionary["name"] as? String
		onRed = dictionary["onRed"] as? Bool
		parentID = dictionary["parentID"] as? Int
	}

}