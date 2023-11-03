*&---------------------------------------------------------------------*
*& Report ZR_AMDP_01_SIMPLE_CALL
*&---------------------------------------------------------------------*
*& Simple AMDP call
*&---------------------------------------------------------------------*
REPORT zr_amdp_01_simple_call.

DATA(lo_amdp) = NEW zcl_amdp_simple_00( ).

TRY.
    lo_amdp->get_customer_infos(
      IMPORTING
        et_customer_info = DATA(lt_result) ).

    cl_demo_output=>display_data( lt_result ).

  CATCH cx_amdp_execution_failed INTO DATA(lx).
    "Do some meaningful error handling
    WRITE: 'Error occurred during execution of an AMDP - do something!',
           / 'SQL Error Message:',
           / |{ lx->sql_message }|.
ENDTRY.
