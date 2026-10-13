{% set flag = 2 %}

SELECT * FROM {{ref("bronze_bookings")}}
WHERE NIGHTS_booked = {{flag}}