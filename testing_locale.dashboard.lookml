
- dashboard: testing_for_bug
  title: testing for bug
  layout: newspaper
  preferred_viewer: dashboards-next
  preferred_slug: YLtbEJpaC6VZilBGDRnW2B
  elements:
  - title: testing for bug
    name: testing for bug
    model: 0_vysakh_thelook
    explore: order_items
    type: table
    fields: [order_items.id, order_items.sale_price, order_items.count, users.city,
      users.country, users.gender, users.created_date]
    filters: {}
    sorts: [order_items.count desc 0]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Country: users.country
      Gender: users.gender
      Created Date: users.created_date
    row: 0
    col: 0
    width: 24
    height: 12
  filters:
  - name: Country
    title: Country
    type: field_filter
    default_value: USA
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: 0_vysakh_thelook
    explore: order_items
    listens_to_filters: []
    field: users.country
  - name: Gender
    title: Gender
    type: field_filter
    default_value: f,male
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: 0_vysakh_thelook
    explore: order_items
    listens_to_filters: []
    field: users.gender
  - name: Created Date
    title: Created Date
    type: field_filter
    default_value: 7 years
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
    model: 0_vysakh_thelook
    explore: order_items
    listens_to_filters: []
    field: users.created_date
