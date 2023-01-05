# The name of this view in Looker is "Lkp Dag"
view: lkp_dag {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ntt-data-argentina-macro.logs_composer.lkp_dag`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Cutoff Time Num" in Explore.

  dimension: cutoff_time_num {
    type: number
    sql: ${TABLE}.cutoff_time_num ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_cutoff_time_num {
    type: sum
    sql: ${cutoff_time_num} ;;
  }

  measure: average_cutoff_time_num {
    type: average
    sql: ${cutoff_time_num} ;;
  }

  dimension: dag_txt {
    type: string
    sql: ${TABLE}.dag_txt ;;
  }

  dimension: functional_module_txt {
    type: string
    sql: ${TABLE}.functional_module_txt ;;
  }

  dimension: periodicity_txt {
    type: string
    sql: ${TABLE}.periodicity_txt ;;
  }

  dimension: template_txt {
    type: string
    sql: ${TABLE}.template_txt ;;
  }

  dimension: type_txt {
    type: string
    sql: ${TABLE}.type_txt ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
