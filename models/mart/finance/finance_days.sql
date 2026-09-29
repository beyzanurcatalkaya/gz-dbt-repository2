WITH orders_operational AS (

    SELECT *
    FROM {{ ref('int_orders_operational') }}

),

finance_days_aggregated AS (

    SELECT
        date_date,

        COUNT(DISTINCT orders_id) AS nb_transactions,

        SUM(revenue) AS revenue,

        SUM(operational_margin) AS operational_margin,

        SUM(purchase_cost) AS purchase_cost,

        SUM(shipping_fee) AS shipping_fee,

        SUM(logcost) AS logcost,

        SUM(quantity) AS quantity

    FROM orders_operational

    GROUP BY date_date

)

SELECT
    date_date,
    nb_transactions,
    revenue,

    revenue / NULLIF(nb_transactions, 0) AS average_basket,

    operational_margin,
    purchase_cost,
    shipping_fee,
    logcost,
    quantity

FROM finance_days_aggregated

ORDER BY date_date