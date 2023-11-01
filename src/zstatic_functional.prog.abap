*&---------------------------------------------------------------------*
*& Report ZSTATIC_FUNCTIONAL
*&---------------------------------------------------------------------*
*& Functional check
*&---------------------------------------------------------------------*
REPORT zstatic_functional.

TABLES sflight.

DATA wa TYPE sflight.
DATA itab TYPE TABLE OF sflight.

DATA: indnr   TYPE dd12l-dbindex VALUE '001',
      tabname TYPE dd12l-sqltab VALUE 'SFLIGHT',
      subrc   TYPE sy-subrc.

DATA: BEGIN OF jpera,
        era(4)    TYPE c,
        shera(1)  TYPE c,
        stdate(8) TYPE c,
      END OF jpera.

DATA: jpdate(11) TYPE c,
      inp        TYPE d.

SELECT * FROM sflight
  INTO TABLE itab
  WHERE carrid = 'LH' AND connid = '0400'.

READ TABLE itab INTO wa
  WITH KEY carrid = 'LH'
           connid = '0400'
           fldate = '20130101'
  BINARY SEARCH.

SELECT * FROM sflight
  INTO TABLE itab
  WHERE carrid = 'LH' AND connid = '0400'.
DELETE ADJACENT DUPLICATES FROM itab COMPARING carrid.

LOOP AT itab INTO wa.
  AT NEW carrid.
    WRITE: / wa-carrid.
  ENDAT.
ENDLOOP.

CALL FUNCTION 'DB_EXISTS_INDEX'
  EXPORTING
    dbindex         = indnr
    tabname         = tabname
  IMPORTING
    subrc           = subrc
  EXCEPTIONS
    parameter_error = 1
    OTHERS          = 2.
IF sy-subrc <> 0 OR subrc <> 0.
  WRITE ' Index missing'(001).
ENDIF.

inp = sy-datum.

EXEC SQL.
  SELECT ERA, SHERA, STDATE INTO :JPERA
    FROM LDERA
    WHERE LANG = :SY-LANGU
      AND STDATE = ( SELECT MAX(STDATE)
                       FROM LDERA
                       WHERE LANG = :SY-LANGU
                         AND STDATE <= :INP )
ENDEXEC.

SELECT era shera stdate INTO jpera
  FROM ldera UP TO 1 ROWS
  WHERE lang = sy-langu
    AND stdate = ( SELECT MAX( stdate )
                     FROM ldera
                     WHERE lang = sy-langu
                       AND stdate <= inp ).
ENDSELECT.
