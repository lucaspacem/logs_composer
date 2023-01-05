# Define the database connection to be used for this model.
connection: "ntt_data_argentina_macro"
include: "/views/**/*.view"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: logs_composer_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: logs_composer_default_datagroup

explore: airflow_logging {
  join: lkp_dag {
    sql_on: ${airflow_logging.dag} = ${lkp_dag.dag_txt} ;;
    relationship: many_to_one
    type: left_outer
  }
}

explore: dt_composer {}
