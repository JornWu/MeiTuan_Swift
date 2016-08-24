//
//	SC_ShopCateListModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct SC_ShopCateListModel{

	var data : [SC_Data]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		data = [SC_Data]()
		if let dataArray = dictionary["data"] as? [NSDictionary]{
			for dic in dataArray{
				let value = SC_Data(fromDictionary: dic)
				data.append(value)
			}
		}
	}

}