CREATE TABLE voucher.trans_summary_daily (
    report_date DATE NOT NULL,
    user_id VARCHAR (255) NOT NULL,
    voucher_code VARCHAR (255) NOT NULL,
    merchant_code VARCHAR (255) NOT NULL,
    category NVARCHAR (255) NOT NULL,
    sub_category NVARCHAR (255) NOT NULL,
    gender VARCHAR (25) NOT NULL,
    province_name NVARCHAR (255) NOT NULL,
    age_group VARCHAR(25),
    display_date_from DATE NOT NULL,
    display_date_to DATE NOT NULL,
    discount_type VARCHAR (255),
    discount_amount_per_voucher_code DECIMAL (10, 2),
    discount_percent_per_voucher_code DECIMAL (10, 2),
    total_claimed INT NOT NULL,
    total_redeemed INT NOT NULL,
    total_stock INT NOT NULL,
    PRIMARY KEY (report_date, user_id, voucher_code, merchant_code, category, sub_category)
);

INSERT INTO voucher.trans_summary_daily (
    report_date,
    user_id,
    voucher_code,
    merchant_code,
    category,
    sub_category,
    gender,
    province_name,
    age_group,
    display_date_from,
    display_date_to,
    discount_type,
    discount_amount_per_voucher_code,
    discount_percent_per_voucher_code,
    total_claimed,
    total_redeemed,
    total_stock
)

Select
	f.report_date
    , f.user_id
	, f.voucher_code
	, f.merchant_code
    , m.category
    , m.sub_category
    , u.gender
    , u.province_name
    , u.age_group
	, v.display_date_from
	, v.display_date_to
	, s.discount_type
	, s.discount_amount as discount_amount_per_voucher_code
	, s.discount_percent as discount_percent_per_voucher_code
    , f.total_claimed   
	, f.total_redeemed
    , v.total_stock
from 
(
Select calendar_dim_id as report_date
    , user_id
	, voucher_code
	, merchant_code
	, SUM(CASE WHEN action = 'Claimed' THEN 1 ELSE 0 END) AS total_claimed
	, SUM(CASE WHEN action = 'Redeemed' THEN 1 ELSE 0 END) AS total_redeemed
from voucher.fact
group by calendar_dim_id, user_id, voucher_code, merchant_code ) f
left join voucher.d_voucher v on f.voucher_code=v.voucher_code
left join voucher.d_scheme s on f.voucher_code=s.voucher_code
left join voucher.d_merchant m on f.merchant_code=m.merchant_code
left join voucher.d_user u on f.user_id=u.user_id