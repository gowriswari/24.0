# If necessary, uncomment the line below to include explore_source.
# include: "gowri_1_test.model.lkml"

view: native_derived1 {
  derived_table: {
    explore_source: inventory_items {
      column: id {}
      column: cost {}
      column: department { field: products.department }
    }
  }
  dimension: id {
    description: ""
    type: number
  }
  dimension: cost {
    description: ""
    type: number
  }
  dimension: department {
    description: ""
  }

}
