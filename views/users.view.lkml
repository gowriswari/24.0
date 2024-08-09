# The name of this view in Looker is "Users"
view: users {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: demo_db.users ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Age" in Explore.

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }


  parameter: date_granularity {
    type: unquoted
    allowed_value: {
      label: "Break down by Day"
      value: "day"
    }
    allowed_value: {
      label: "Break down by Month"
      value: "month"
    }
  }

  dimension: date {
    sql:
    {% if date_granularity._parameter_value == 'day' %}
      ${created_date}
    {% elsif date_granularity._parameter_value == 'month' %}
      ${created_month}
    {% else %}
      ${created_date}
    {% endif %};;
  }
  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_age {
    type: sum
    sql: ${age} ;;  }
  measure: average_age {
    type: average
    sql: ${age} ;;  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

dimension: testtt {
  type:string
  case: {
    when: {
      sql: ${users.gender} IN ("f","m");;
      label: "In test"
    }
    # Possibly more when statements
    else: "Null"
  }
  alpha_sort:  yes
}



  dimension_group: encounter_start {
    description: "At what time did the encounter start?"
    type: time
    sql:${TABLE}.created_at;;
    #timeframes: [date, month, month_name, month_num, quarter, quarter_of_year, week, week_of_year, year, time]
  }

  dimension: is_abandoned {
    description: "Flag when call is abandoned - defined as call abandoned in queue after 30 seconds"
    type: yesno
    sql: ${users.gender}='f' AND ${age}>30 ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }

  dimension: date_test {
    type: date
    sql: ${created_date} ;;
    html:{{ value | date: "%A, %B %e, %Y" }};;

  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }




  dimension: status_of_parameter {
    # label: "{% if view_label._parameter_value == 'PENDING' %} Pening
    #             {% elsif view_label == 'complete' %}  Complete
    #             {% else %} zone
    #             {% endif %}"
    type: string
    sql: {% if alerts_parameter._parameter_value == 'JOHN' %}
          ${first_name}
          {% elsif alerts_parameter._parameter_value == 'TEXAS' %}
          ${state}
          {% elsif alerts_parameter._parameter_value == 'USA' %}
          ${country}
          {% elsif alerts_parameter._parameter_value == 'MAY' %}
          ${last_name}
          {% else %}
          ${country}
          {% endif %};;
  }

  parameter: alerts_parameter {
    type: unquoted
    default_value: "USA"

    allowed_value: {
      label: "john"
      value: "JOHN"
    }
    allowed_value: {
      label: "texas"
      value: "TEXAS"
    }
    allowed_value: {
      label: "usa"
      value: "USA"
    }

    allowed_value: {
      label: "may"
      value: "MAY"
    }
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }



  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  first_name,
  last_name,
  events.count,
  orders.count,
  saralooker.count,
  sindhu.count,
  user_data.count
  ]
  }

}
