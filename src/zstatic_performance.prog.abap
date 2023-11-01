*&---------------------------------------------------------------------*
*& Report ZSTATIC_PERFORMANCE
*&---------------------------------------------------------------------*
*& Performance check
*&---------------------------------------------------------------------*
REPORT zstatic_performance.

DATA: it_user  TYPE TABLE OF usr01,
      wa_user  TYPE usr01,
      rc TYPE sy-subrc,
      wa_user2 TYPE usr02,
      it_sett  TYPE TABLE OF rseumod.

SELECT-OPTIONS s_users FOR wa_user-bname.

SELECT * FROM usr01 INTO TABLE it_user WHERE bname IN s_users.

LOOP AT it_user INTO wa_user.
  SELECT SINGLE * FROM usr02 INTO wa_user2 WHERE bname = wa_user-bname.
  IF sy-subrc = 0.
    "...
    PERFORM wb_settings_check USING wa_user2-bname CHANGING rc.
    "....
  ENDIF.
ENDLOOP.

FORM wb_settings_check USING i_name TYPE rseumod-uname CHANGING rc.
  DATA l_rseumod TYPE rseumod.
  SELECT SINGLE * FROM rseumod
    INTO l_rseumod
    WHERE uname = i_name.
  rc = sy-subrc.
ENDFORM.
