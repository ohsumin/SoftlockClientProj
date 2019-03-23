package com.softlock.model;

import java.util.ArrayList;

public interface ResvImpl {
	
	public TreattimeDTO getTime(String hp_idx, String dy);
	
	public ArrayList<ReservationDTO> getResv(String hp_idx, String date);
	
	public void resvInsert(String hp_idx, int mem_idx, String resv_symp, String resv_req, String resv_date, String resv_time);

}
