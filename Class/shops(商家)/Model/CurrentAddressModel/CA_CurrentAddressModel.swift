//
//	CA_CurrentAddressModel.swift
//
//	Create by JornWu on 27/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct CA_CurrentAddressModel{

	public var data : CA_Data!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		if let dataData = dictionary["data"] as? NSDictionary{
				data = CA_Data(fromDictionary: dataData)
			}
	}

}
