*&---------------------------------------------------------------------*
*& Report ZR_ALV_IDA
*&---------------------------------------------------------------------*
*& Display ALV with IDA
*&---------------------------------------------------------------------*
REPORT zr_alv_ida.

cl_salv_gui_table_ida=>create_for_cds_view( iv_cds_view_name = 'ZCDSV_OIA_BASIC_ALV' )->fullscreen( )->display( ).
