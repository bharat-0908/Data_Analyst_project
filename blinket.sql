create database blinkit;
use blinkit;
select * from customers;
select * from orders;


select c.customer_name,c.total_orders,
o.order_id,o.customer_id,o.order_total
from customers c
inner join orders o
on c.customer_id = o.customer_id;

select * from orders;

-- 1 
create view total_revenue as
select sum(order_total) from orders;

select * from total_revenue;

-- 2 
create view total_order as
select count(order_id) from orders;

select * from total_order;

select * from products;

-- total category 
create view total_category as
select distinct(count(category)) from products;

select * from total_category;

select * from customer_feedback;


-- top 5 customers

create view top_5_customers as
select customer_id,customer_name,sum(total_orders) as total_orders
from customers
group by customer_id,customer_name
order by total_orders desc
limit 5;

select * from top_5_customers;


-- top 5 area wise orders

create view top_5_area as
select area, sum(total_orders) as total_order
from customers
group by area
order by total_order desc
limit 5;

select * from top_5_area;

-- average of rating
create view avg_rating as
select avg(rating) from customer_feedback;


select * from customer_feedback;

select rating, count(order_id) as total_order
from customer_feedback
group by rating;


-- rating wise feedback

create view rating_total_feedback as
select rating,count(feedback_id) as total_feedback
from customer_feedback
group by rating;



select * from marketing_performance;

-- market total cost

create view total_cost as
select sum(spend) from marketing_performance;

select * from total_cost;


-- payment method

create view method_wise_payment as
select payment_method,count(order_total) as total_order
from orders
group by payment_method;

select * from method_wise_payment;

select * from orders;

-- --------------------------------------insert customer procedure


use blinkit;
-- ------------------------------------- TRIGGERS 

select * from orders;

create table action_log (
	log_id int auto_increment primary key,
    order_id int,
    customer_id int,
    action_type varchar(50),
    order_date text,
    promis_date text,
    action_time timestamp default current_timestamp
    );
    

delimiter //
create trigger log_customer_action
after insert on orders
for each row 
begin

     insert into action_log(order_id,customer_id,order_date,promised_delivery_time,action_type)
     values(new.order_id,new.customer_id,new.order_date,new.promised_delivery_time);
     
end //
     
  delimiter ;
 
 select * from action_log;
 SET SQL_SAFE_UPDATES = 0;


select * from orders;
show columns from orders;



insert into orders(order_id,customer_id,order_date,promised_delivery_time,actual_delivery_time,delivery_status,order_total,payment_method,delivery_partner_id,store_id)
values
(1005045,50354050,"18-12-2025","21-12-2025 08:52:01","20-12-2025","on Time",1002,"UPI",1005,2001);

use blinkit;

select * from customers;
select * from orders;
show columns from orders;


create table backup_customer(
order_id int primary key,
customer_id int,
order_total int,
payment_method varchar(50),
delivery_partner_id int);





--     joins 
select * from orders;
select * from customers;

select c.customer_id,o.order_id
from customers c
join orders o
on c.customer_id = o.customer_id;












delimiter //
create trigger backup_data
after delete on orders
for each row
begin
   
   insert into backup_customer(order_id,customer_id,order_total,payment_method,delivery_partner_id)   
  values(old.order_id,old.customer_id,old.order_total,old.payment_method,old.delivery_partner_id);
  
  end //
  delimiter ;
  
  


delete from orders
where order_id = 1961864118;

SET FOREIGN_KEY_CHECKS = 0;

select * from backup_customer;

use blinkit;

select * from order_items;
select * from customers;

select area, count(total_orders)
from customers
group by area
order by area desc
limit 5;


select * from orders;
select * from customers;

select c.area,sum(o.order_total) as total_revenue
from customers c
join orders o
on c.customer_id = o.customer_id
group by c.area
order by total_revenue desc
limit 5;

select * from orders;
select * from customers;




select c.area,sum(o.order_total) 
from customers c
join orders o
on c.customer_id = o.customer_id
group by c.areass
order by sum(o.order_total) desc
limit 5;






-- self practice questions

use blinkit;
select * from customers;
select * from orders;

select delivery_status,count(order_id)
from orders 
group by delivery_status;






--                                        - ------------------------------------------------------------------------------


--  EXCUTIVE OVERVIWE 


use blinkit;
select * from orders;
select sum(order_total) as total_revenue from orders;



select * from customers;
create view total_customer as
select count(distinct(customer_id)) as total_customer from customers;

select * from total_customer;

select * from marketing_performance;
select sum(spend) as total_cost from marketing_performance;

-- Avg_revenue 
select Avg(order_total) as avg_revenue from orders;

select * from orders;
select * from products;
select * from order_items;


--                                                                           -category by orders

create view Category_by_order as
select p.category,sum(o.quantity) as total_order
from products p
join order_items o
on p.product_id = o.product_id
group by p.category
order by total_order desc;

select * from Category_by_order;



use blinkit;
--                                                     top 5 brand
select p.brand,sum(o.quantity) as total_order
from products p
join order_items o
on p.product_id = o.product_id
group by p.brand
order by total_order desc
limit 5;


--                      SALES ANALYSIS                           


select * from orders;
--                                                               delivery_status by orders
select delivery_status,count(distinct(order_id)) as total_orders 
from orders
group by delivery_status;



--                                                 payment_method by revenue
create view payment_method_by_revenue as
select payment_method,sum(order_total) as total_revenue
from orders
group by payment_method;

select * from payment_method_by_revenue;


select * from orders;
use blinkit;

--                                    month by revenue

select year(order_date) as years,
month(order_date) as month,
sum(order_total) as revenue
from orders
group by year(order_date), month(order_date)
order by years,month;


select * from products;
select * from orders;


--                                          Category by revenue
select category,sum(price) as total_revenue
from products
group by category
order by total_revenue desc;


--                        repeat customers

select * from orders;

select customer_id,count(order_id) as total_orders
from orders
group by customer_id
having count(order_id) > 1;
--                                                                                              customers

--                                                            repeat customer with name

select * from customers;

select c.customer_name,o.customer_id,count(o.order_id) as total_orders
from customers c
join orders o 
on c.customer_id = o.customer_id
group by c.customer_name,o.customer_id
having count(o.order_id) > 1;


--                              per customer revenue

select customer_id,sum(order_total) as revenue
from orders
group by customer_id;

--                                   with name
select c.customer_name,o.customer_id,sum(order_total) as revenue
from customers c
join orders o 
on c.customer_id = o.customer_id
group by c.customer_name,o.customer_id
order by revenue  desc;


--                                                    top 10 customers
select * from customers;
select * from orders;
select c.customer_name,o.customer_id,sum(o.order_total) as total_revenue 
from customers c 
join orders o 
on c.customer_id = o.customer_id 
group by c.customer_name,o.customer_id
order by total_revenue desc
limit 10;


select upper("bharat");

select left("bharat",2) as leftside_name;

select right("shyam",1) right_name;



--                                                                   products

--                                    top 10 selling products

select * from products;
select * from orders;
select * from order_items;

select p.product_name,o.product_id,sum(quantity) as total_sell
from products p 
join order_items o 
on p.product_id = o.product_id
group by p.product_name,o.product_id
order by total_sell desc
limit 10;


--                    top category by seles

select p.category,o.product_id,sum(quantity) as total_seles
from products p
join order_items o 
on p.product_id = o.product_id
group by p.category,o.product_id
order by total_seles desc
limit 10;


select p.brand,o.product_id,sum(quantity) as total_seles
from products p
join order_items o 
on p.product_id = o.product_id
group by p.brand,o.product_id
order by total_seles desc
limit 10;


--                                                                   Rating Analysis
--                                                           area by rating
select * from customers;
select * from customer_feedback;

select c.area,cf.customer_id,avg(cf.rating) as avg_rating
from customers c 
join customer_feedback cf 
on c.customer_id = cf.customer_id 
group by c.area,cf.customer_id
order by avg_rating desc;



--                                                                          marketing

--                                                        roas(Return on Ad Spend)

select * from marketing_performance;

select sum(revenue_generated)/sum(spend) as roas
from marketing_performance;

--                                                 CTR(click throu rate)

select sum(clicks)/sum(impressions) * 100 as ctr_calculation
from marketing_performance;



--                        deliver performance

select avg(actual_delivery_time) as avg_delivery_time from  orders;











