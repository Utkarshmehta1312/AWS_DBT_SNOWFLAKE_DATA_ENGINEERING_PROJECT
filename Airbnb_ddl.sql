-- DDL for all my Tables
CREATE OR REPLACE TABLE HOSTS (
    host_id NUMBER,
    host_name STRING,
    host_since DATE,
    is_superhost BOOLEAN,
    response_rate NUMBER,
    created_at TIMESTAMP,
    PRIMARY KEY (host_id)
);

CREATE OR REPLACE TABLE LISTINGS (
    listing_id NUMBER,
    host_id NUMBER,
    property_type STRING,
    room_type STRING,
    city STRING,
    country STRING,
    accommodates NUMBER,
    bedrooms NUMBER,
    bathrooms NUMBER,
    price_per_night NUMBER,
    created_at TIMESTAMP,
    PRIMARY KEY (listing_id)
);

CREATE OR REPLACE TABLE BOOKINGS (
    booking_id STRING,
    listing_id NUMBER,
    booking_date TIMESTAMP,
    nights_booked NUMBER,
    booking_amount NUMBER,
    cleaning_fee NUMBER,
    service_fee NUMBER,
    booking_status STRING,
    created_at TIMESTAMP,
    PRIMARY KEY (booking_id)
);

--CSV FILE FORMAT DEFINITIONS

CREATE OR REPLACE FILE FORMAT  my_csv_format
  TYPE = 'CSV' 
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE;

--- COPY DATA FROM s3 TO SNOWFLAKE Tables


CREATE OR REPLACE stage s3_ext_stage
file_format = my_csv_format
url = 's3://snowflakebucket-utk/source_aws/'

SHOW STAGES

DESC STAGE s3_ext_stage


COPY INTO HOSTS
FRoM @s3_ext_stage
FILES = ('hosts.csv')
CREDENTIALS=(aws_key_id = '*****', aws_secret_key = '*****');


COPY INTO BOOKINGS
FRoM @s3_ext_stage
FILES = ('bookings.csv') 
CREDENTIALS=(aws_key_id = '*****', aws_secret_key = '*****');

COPY INTO LISTINGS
FRoM @s3_ext_stage
FILES = ('listings.csv')
CREDENTIALS=(aws_key_id = '*****', aws_secret_key = '*****');



LIST @s3_ext_stage

TRUNCATE TABLE LISTINGS






