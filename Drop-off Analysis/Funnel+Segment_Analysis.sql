use otd_platform_analysis;

-- Check first few rows
select * from dropoff_data limit 10;

-- check how many records are there
select count(*) as total_records from dropoff_data;

-- count unique users
select count(distinct user_id) as total_users from dropoff_data;

-- how many events exist at each funnel stage
select event_name, count(*) as total_events from dropoff_data group by event_name order by total_events desc;

-- count unique users reaching each funnel stage 
select event_name, count(distinct user_id) as users from dropoff_data group by event_name;

-- compare funnel events across different platforms (platform analysis)
select platform,event_name, count(distinct user_id) as users from dropoff_data group by platform, event_name order by platform, users desc;

-- check user activity across subscribtion plans (plan Analysis)
select plan, event_name,count(distinct user_id) as users from dropoff_data group by plan, event_name order by plan, users desc;

-- compare payment activity by payment method (Payment method Analysis)
select payment_method, event_name, count(distinct user_id) as users from dropoff_data where event_name in ('payment_initiated', 'payment_success', 'payment_failed') group by payment_method, event_name order by payment_method;

-- Payment failure reasons(Payment Failure Analysis)
select failure_reason, count(*) as Failed_payments from dropoff_data where event_name = "Payment_failed" group by failure_reason order by failed_payments desc;

-- compare funnel activity between new and returning users (New vs return users)
select user_type, event_name, count(distinct user_id) as users from dropoff_data group by user_type,event_name order by user_type, users desc;

-- Funnel Acivity by State (Geography)
select state, event_name, count(distinct user_id) as users from dropoff_data group by state, event_name order by state, users desc;

-- Calculate successful Payments (Check payment successful)
select sum(plan_price) as successful_payment_value from dropoff_data where event_name = "Payment_success";

-- Estimate the transaction value associated with failed payments (potential payments)
select sum(plan_price) as payment_value_at_risk from dropoff_data where event_name = "payment_failed";