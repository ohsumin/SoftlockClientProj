package com.softlock.model;

public class TreatDTO {

      private String oTime;
      private String cTime;      
      private String treat_hp_idx;
      
      
      public TreatDTO(String oTime, String cTime, String treat_hp_idx) {
         
         this.oTime = oTime;
         this.cTime = cTime;
         this.treat_hp_idx = treat_hp_idx;
      }


      public String getoTime() {
         return oTime;
      }


      public void setoTime(String oTime) {
         this.oTime = oTime;
      }


      public String getcTime() {
         return cTime;
      }


      public void setcTime(String cTime) {
         this.cTime = cTime;
      }


      public String getTreat_hp_idx() {
         return treat_hp_idx;
      }


      public void setTreat_hp_idx(String treat_hp_idx) {
         this.treat_hp_idx = treat_hp_idx;
      }     
}