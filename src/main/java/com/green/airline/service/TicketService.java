package com.green.airline.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.green.airline.dto.response.TicketAllInfoDto;
import com.green.airline.dto.response.TicketDto;
import com.green.airline.repository.interfaces.PassengerRepository;
import com.green.airline.repository.interfaces.ReservedSeatRepository;
import com.green.airline.repository.interfaces.TicketPaymentRepository;
import com.green.airline.repository.interfaces.TicketRepository;
import com.green.airline.repository.model.Passenger;
import com.green.airline.repository.model.ReservedSeat;
import com.green.airline.repository.model.Ticket;
import com.green.airline.repository.model.TicketPayment;

/**
 * @author 서영
 *
 */
@Service
public class TicketService {
	
	@Autowired
	private TicketRepository ticketRepository;
	
	@Autowired
	private ReservedSeatRepository reservedSeatRepository;
	
	@Autowired
	private PassengerRepository passengerRepository;
	
	@Autowired
	private TicketPaymentRepository ticketPaymentRepository;

	/**
	 * 결제 요청 시 예약 내역 + 결제 내역을 추가하는 로직
	 */
	@Transactional
	public void createTicketAndPayment(TicketDto ticketDto, String memberId) {
		
		// 예약 id 난수로 생성
		String ticketId = (int) Math.floor(Math.random() * 89000000 + 10000000) + "";		
		
		// 해당 id가 이미 존재하는지 확인 (존재한다면 다시)
		Ticket searchTicket = ticketRepository.selectById(ticketId + "A");
		// 이미 존재한다면 반복문으로 들어감
		while (searchTicket != null) {
			ticketId = (int) Math.floor(Math.random() * 89000000 + 10000000) + "";
			searchTicket = ticketRepository.selectById(ticketId + "A");
		}
		
		String ticketId1 = ticketId;
		// 왕복일 때에는 A를 붙임
		if (ticketDto.getScheduleId2() != null) {
			ticketId1 = ticketId + "A";
		}
		
		// 예약 내역 생성 (1번 스케줄)
		Ticket ticket1 = Ticket.builder()
						.id(ticketId1)
						.adultCount(ticketDto.getAdultCount())
						.childCount(ticketDto.getChildCount())
						.infantCount(ticketDto.getInfantCount())
						.seatGrade(ticketDto.getSeatGrade())
						.memberId(memberId)
						.scheduleId(ticketDto.getScheduleId())
						.build();
		ticketRepository.insert(ticket1);
		
		// 예약 좌석 생성
		for (String seat : ticketDto.getSeatNames()) {
			ReservedSeat reservedSeat = new ReservedSeat(ticketDto.getScheduleId(), seat, ticketId1);
			reservedSeatRepository.insert(reservedSeat);
		}
		
		// 탑승객 생성
		for (String p : ticketDto.getPassengerInfos()) {
			String gender = p.split("_")[1];
			String name = p.split("_")[2];
			String birthDate = p.split("_")[3];
			Passenger passenger = new Passenger(name, gender, birthDate, ticketId1);
			passengerRepository.insert(passenger);
		}
		
		String ticketId2 = null;
		Integer status2 = null;
		
		// 왕복이면
		if (ticketDto.getScheduleId2() != null) {
			
			ticketId2 = ticketId + "B";
			status2 = 0;
			
			// 예약 내역 생성 (2번 스케줄)
			Ticket ticket2 = Ticket.builder()
							.id(ticketId2)
							.adultCount(ticketDto.getAdultCount())
							.childCount(ticketDto.getChildCount())
							.infantCount(ticketDto.getInfantCount())
							.seatGrade(ticketDto.getSeatGrade2())
							.memberId(memberId)
							.scheduleId(ticketDto.getScheduleId2())
							.build();
			ticketRepository.insert(ticket2);
			
			// 예약 좌석 생성
			for (String seat : ticketDto.getSeatNames2()) {
				ReservedSeat reservedSeat = new ReservedSeat(ticketDto.getScheduleId2(), seat, ticketId2);
				reservedSeatRepository.insert(reservedSeat);
			}
			
			// 탑승객 생성
			for (String p : ticketDto.getPassengerInfos()) {
				String gender = p.split("_")[1];
				String name = p.split("_")[2];
				String birthDate = p.split("_")[3];
				Passenger passenger = new Passenger(name, gender, birthDate, ticketId2);
				passengerRepository.insert(passenger);
			}
		}
		
		// 결제 내역
		TicketPayment ticketPayment = TicketPayment.builder()
										.tid(ticketDto.getTid())
										.ticketId1(ticketId1)
										.ticketId2(ticketId2)
										.amount1(ticketDto.getPrice())
										.amount2(ticketDto.getPrice2())
										.status1(0)
										.status2(status2)
										.build();
		ticketPaymentRepository.insert(ticketPayment);
		
	}
	
	/**
	 * 결제 취소 시 결제내역, 티켓 삭제
	 */
	public void deleteTicketByPaymentCancel(String memberId) {
		
		List<Ticket> ticketList = ticketRepository.selectByUserIdOrderByDate(memberId);
		// 해당 유저가 가장 최근에 예매한 티켓 id 가져오기
		String ticketId1 = ticketList.get(0).getId();
		String ticketId2 = null;
		
		// 왕복이라면 ID 길이 9
		if (ticketId1.length() == 9) {
			ticketId2 = ticketList.get(1).getId();
			// 티켓 삭제 (삭제 시 예약 좌석, 탑승객 데이터, 결제 내역도 함께 삭제됨)
			ticketRepository.deleteById(ticketId2);
		}
		
		// 티켓 삭제 (삭제 시 예약 좌석, 탑승객 데이터, 결제 내역도 함께 삭제됨)
		ticketRepository.deleteById(ticketId1);
		
	}
	
	/**
	 * 결제 완료 처리
	 */
	public List<TicketAllInfoDto> updatePaymentStatusIsSuccess(String memberId) {
		
		List<Ticket> ticketList = ticketRepository.selectByUserIdOrderByDate(memberId);
		// 해당 유저가 가장 최근에 예매한 티켓 id 가져오기
		String ticketId = ticketList.get(0).getId();
		
		List<TicketAllInfoDto> dtoList = new ArrayList<>();
		TicketAllInfoDto ticket1 = null;
		TicketAllInfoDto ticket2 = null;
		
		// 왕복이라면 ID 길이 9
		if (ticketId.length() == 9) {
			ticketPaymentRepository.updateStatus(ticketId, 1, 1);
			
			String ticketIdSubStr = ticketId.substring(0, 8);
			
			ticketRepository.updateReservedDate(ticketIdSubStr + "A");
			ticketRepository.updateReservedDate(ticketIdSubStr + "B");
			
			ticket1 = ticketRepository.selectAllInfoById(ticketIdSubStr + "A", 1);
			ticket2 = ticketRepository.selectAllInfoById(ticketIdSubStr + "B", 2);
			dtoList.add(ticket1);
			dtoList.add(ticket2);
			
		} else {
			ticketPaymentRepository.updateStatus(ticketId, 1, null);
			ticketRepository.updateReservedDate(ticketId);
			
			ticket1 = ticketRepository.selectAllInfoById(ticketId, 1);
			dtoList.add(ticket1);
			
		}
		
		// 티켓/결제 정보를 보여주기 위해 반환
		return dtoList;
	}
	
	/**
	 * 특정 티켓의 모든 정보 가져오기 (결제 정보 포함)
	 */
	public TicketAllInfoDto readTicketAllInfoByTicketId(String ticketId) {
		
		TicketAllInfoDto infoDto = null;
		
		// 왕복 - 두 번째 일정이라면
		if (ticketId.length() == 9 && ticketId.substring(8).equals("B")) {
			infoDto = ticketRepository.selectAllInfoById(ticketId, 2);
		// 편도 or 왕복 - 첫 번째 일정이라면
		} else {
			infoDto = ticketRepository.selectAllInfoById(ticketId, 1);
		}
		
		return infoDto;
	}
	
	/**
	 * @author 서영
	 * 해당 유저가 구매한 모든 티켓 리스트 가져오기
	 */
	public List<TicketAllInfoDto> readTicketListByMemberId(String memberId) {
		List<TicketAllInfoDto> dtoList = ticketRepository.selectTicketListByMemberId(memberId);
		
		return dtoList;
	}
	
	/**
	 * @author 서영
	 * 환불 처리
	 * 결제 내역의 status 변경
	 * 예약 좌석, 탑승객 정보 삭제
	 */
	public void updateStatusRefund(String tid, String ticketId,Integer type) {
		// status 변경
		ticketPaymentRepository.updateStatusByTid(tid, type, 2);
		
		// 예약 좌석 삭제
		reservedSeatRepository.deleteByTicketId(ticketId);
		
		// 탑승객 정보 삭제
		passengerRepository.deleteByTicketId(ticketId);	
	}
	
	
	
}
