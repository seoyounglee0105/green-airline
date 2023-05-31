package com.green.airline.repository.model;

import com.green.airline.utils.DecimalPoint;

import lombok.Data;

// 공항
@Data
public class Airport {

	private Integer id;
	private String region;
	private String name;
	private float latitude;
	//String formattedLatitude = DecimalPoint.formatDouble(latitude);
	private float longitude;
	//String formattedLongitude = DecimalPoint.formatDouble(longitude);
	
}