with source as (

    select *
    from {{ source('raw', 'ship') }}

),

renamed as (

    select
        * except(shipping_fee_1, ship_cost),
        cast(ship_cost as int64) as ship_cost

    from source

)

select *
from renamed