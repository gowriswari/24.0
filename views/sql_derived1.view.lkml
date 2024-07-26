view: sql_derived1 {
  derived_table: {
    sql: SELECT
          order_items.id  AS `order_items.id`,
          order_items.sale_price  AS `order_items.sale_price`,
          orders.status  AS `orders.status`,
          COALESCE(SUM((0E0 + order_items.sale_price)), 0) AS `sum_of_sale_price`
      FROM demo_db.order_items  AS order_items
      LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id
      GROUP BY
          1,
          2,
          3
      ORDER BY
          4 DESC;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [detail*]
  }

  dimension: order_items_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.`order_items.id` ;;
  }

  dimension: order_items_sale_price {
    type: number
    sql: ${TABLE}.`order_items.sale_price` ;;
  }

  dimension: orders_status {
    type: string
    sql: ${TABLE}.`orders.status` ;;
  }

  dimension: sum_of_sale_price {
    type: number
    sql: ${TABLE}.sum_of_sale_price ;;
  }

  set: detail {
    fields: [
        order_items_id,
  order_items_sale_price,
  orders_status,
  sum_of_sale_price
    ]
  }
}
