//
//	AC_Data.swift
//
//	Create by JornWu on 18/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct AC_Data{

	var deputyTypefaceColor : String!
	var deputytitle : String!
	var id : Int!
	var imageurl : String!
	var maintitle : String!
	var module : Bool!
	var position : Int!
	var share : AC_Share!
	var solds : Int!
	var title : String!
	var tplurl : String!
	var type : Int!
	var typefaceColor : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		deputyTypefaceColor = dictionary["deputy_typeface_color"] as? String
		deputytitle = dictionary["deputytitle"] as? String
		id = dictionary["id"] as? Int
        
		imageurl = String.URLStringHttpToHttps(dictionary["imageurl"] as! String)
        
		maintitle = dictionary["maintitle"] as? String
		module = dictionary["module"] as? Bool
		position = dictionary["position"] as? Int
		if let shareData = dictionary["share"] as? NSDictionary{
				share = AC_Share(fromDictionary: shareData)
			}
		solds = dictionary["solds"] as? Int
		title = dictionary["title"] as? String
        
		tplurl = String.URLStringHttpToHttps(dictionary["tplurl"] as! String)
        
		type = dictionary["type"] as? Int
		typefaceColor = dictionary["typeface_color"] as? String
	}

}