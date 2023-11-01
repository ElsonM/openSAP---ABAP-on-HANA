*&---------------------------------------------------------------------*
*& Report ZR_OPENSQL_10_CASE
*&---------------------------------------------------------------------*
*& Open SQL Case
*&---------------------------------------------------------------------*
REPORT zr_opensql_10_case.

"Simple case
SELECT so_id,
       CASE delivery_status
         WHEN ' ' THEN 'Open'
         WHEN 'D' THEN 'Delivered'
         ELSE delivery_status
       END AS delivery_status_long
  FROM snwd_so
  INTO TABLE @DATA(lt_simple_case).

"Searched case
SELECT so_id,
       CASE WHEN gross_amount > 1000
         THEN 'High volume sales order'
         ELSE ' '
       END AS volumn_order
  FROM snwd_so
  INTO TABLE @DATA(lt_searched_case).

"Searched case - more advanced
DATA lv_discount TYPE p LENGTH 1 DECIMALS 1 VALUE '0.8'.
SELECT so_id,
       company_name,
       gross_amount AS orig_amount,
       CASE WHEN company_name = 'SAP'
         THEN ( gross_amount * @lv_discount )
         ELSE gross_amount
       END AS discount_amount
  FROM snwd_so AS so
  INNER JOIN snwd_bpa AS bpa
          ON so~buyer_guid = bpa~node_key
  INTO TABLE @DATA(lt_adv_example_searched_case).
