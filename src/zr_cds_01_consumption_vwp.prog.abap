*&---------------------------------------------------------------------*
*& Report ZR_CDS_00_CONSUMPTION
*&---------------------------------------------------------------------*
*& Consumption of CDS View with Input Parameters
*&---------------------------------------------------------------------*
REPORT zr_cds_01_consumption_vwp.

"Plenty of ABAP application logic

"Check if the feature is supported by the underlying database
*DATA(lv_feature_supported) =
*  cl_abap_dbfeatures=>use_features(
*    requested_features = VALUE #( ( cl_abap_dbfeatures=>views_with_parameters ) ) ).

"If the feature is supported, select from the CDS View and
"provide a value for the input parameter
*IF lv_feature_supported = abap_true.
  ##DB_FEATURE_MODE[VIEWS_WITH_PARAMETERS]
  SELECT *
   FROM zcdsv_with_input_parameters( customer_name = 'Pateu' )
   INTO TABLE @DATA(lt_result).
*ELSE.
  "Do some alternative coding here
*ENDIF.

"Even more awesome application logic

"Display of results
cl_demo_output=>display_data( lt_result ).
