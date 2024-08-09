view: sql_runner_query {
    derived_table: {
      sql: SELECT
          products.department  AS `products.department`,
          products.category  AS `products.category`,
          orders.status  AS `orders.status1`,
          COUNT(DISTINCT products.id ) AS `products.count`
      FROM demo_db.order_items  AS order_items
      LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id
      LEFT JOIN demo_db.inventory_items  AS inventory_items ON order_items.inventory_item_id = inventory_items.id
      LEFT JOIN demo_db.products  AS products ON inventory_items.product_id = products.id
      GROUP BY
          1,
          2,
          3
      ORDER BY
          4 DESC
      LIMIT 500 ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: products_department {
      type: string
      sql: ${TABLE}.`products.department` ;;
    }

    dimension: products_category {
      type: string
      sql: ${TABLE}.`products.category` ;;
    }

    dimension: orders_status1 {
      type: string
      sql: ${TABLE}.`orders.status1` ;;
    }

    dimension: products_count {
      type: number
      sql: ${TABLE}.`products.count` ;;
    }

    set: detail {
      fields: [
        products_department,
        products_category,
        orders_status1,
        products_count
      ]
    }
  }
