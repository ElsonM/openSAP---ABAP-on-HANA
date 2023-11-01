*&---------------------------------------------------------------------*
*& Report ZR_CDS_00_CONSUMPTION
*&---------------------------------------------------------------------*
*& Consumption of CDS View
*&---------------------------------------------------------------------*
REPORT zr_cds_00_consumption.

"Data definition using a CDS view as type
DATA lt_cds TYPE STANDARD TABLE OF zcdsv_simple.

"Consumption of a CDS view
SELECT * FROM zcdsv_simple INTO TABLE @lt_cds.
