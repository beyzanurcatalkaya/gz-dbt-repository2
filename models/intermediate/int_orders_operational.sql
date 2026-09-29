SELECT
    orders.orders_id,
    orders.date_date,
    orders.revenue,
    orders.quantity,
    orders.purchase_cost,
    orders.margin,
    ship.shipping_fee,
    ship.logcost,
    ship.ship_cost,

    orders.margin
        + ship.shipping_fee
        - ship.logcost
        - ship.ship_cost AS operational_margin

FROM {{ ref('int_orders_margin') }} AS orders

LEFT JOIN {{ ref('stg_raw__ship') }} AS ship
    ON orders.orders_id = ship.orders_id