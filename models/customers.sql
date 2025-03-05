with customers as (
    select 
        1 as customer_id, 
        'John' as first_name, 
        'Doe' as last_name
),
orders as (
    select 
        4 as order_id, 
        1 as customer_id, 
        '2025-02-21' as order_date, 
        'placed' as status
),
customer_orders as (
    select 
        1 as customer_id, 
        min(order_date) as first_order_date, 
        max(order_date) as most_recent_order_date, 
        count(order_id) as number_of_orders
    from orders
),
final as (
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders
    from customers
    left join customer_orders using (customer_id)
)
select * from final