package com.oldschool.ticketer.models.datamodels;


import java.io.Serializable;

public class Ticket implements Serializable {

    private String allData;
    private String trainName;//063 ОА ФІРМ НШ - Train name
    private String departureStation;//(2204001) ХАРЬКОВ-ПАСС - Departure station
    private String arrivalStation;//(2200001) КИЕВ-ПАССАЖИРСКИЙ - Аrrival station
    private String departureDate;//22.11 22:20 - Departure date and time
    private String arrivalDate;//23.11 07:07 - Arrival date and time
    private String wagon;//01 КБ - Wagon type and number
    private String seatNumber;//027 Повний - Seat number and ticket type
    private String name;//АЛЕКСЕЙ ДЕМЕДЕЦКИЙ - Passenger full name
    private String mps;//MПC - unknown data
    private String price;//0.00 - unknown data
    private String ticketCode;//000B37D3-61738C35-0001 - ticket code
    private String unknown;//50182 - unknown data
    private String hashCode;//CBCE3F97619DA86CF45297C1D8ABB3ED75D1A0CD - unknown data

    public String getAllData() {
        return allData;
    }
    public String getTrainName() {
        return trainName;
    }
    public String getDepartureStation() {
        return departureStation;
    }
    public String getArrivalStation() {
        return arrivalStation;
    }
    public String getDepartureDate() {
        return departureDate;
    }
    public String getArrivalDate() {
        return arrivalDate;
    }
    public String getWagon() {
        return wagon;
    }
    public String getSeatNumber() {
        return seatNumber;
    }
    public String getName() {
        return name;
    }

    public void parseString(String data) {
        String[] fields = data.split("\n");

        allData = data;
        trainName = fields[1];
        departureStation = fields[2];
        arrivalStation = fields[3];
        departureDate = fields[4];
        arrivalDate = fields[5];
        wagon = fields[6];
        seatNumber = fields[7];
        name = fields[9];
    }
}
