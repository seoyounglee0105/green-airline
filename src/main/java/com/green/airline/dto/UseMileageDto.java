package com.green.airline.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class UseMileageDto {

	private Date useDate;
	private Long useMileage;
	private String description;
	private int productPrice;
	private int hiddenCount;
	private String memberId;

	
}
