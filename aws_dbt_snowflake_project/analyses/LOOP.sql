{% set cols = ['NIGHTS_BOOKED', 'BOOKING_ID','BOOKING_AMOUNT'] %}

SELECT 
{% for column in cols %}
{{column}}
{%if not loop.last %} , {% endif %}
{% endfor %}
FROM 
{{ref('bronze_bookings')}}