view: dt_composer {
  derived_table: {
    sql: with filtro as (
      select dag as dag_filtro, max(timestamp) ejecucion
      from `ntt-data-argentina-macro.logs_composer.airflow_logging`
      where TIMESTAMP_TRUNC(timestamp, DAY) = TIMESTAMP_TRUNC("2023-01-05T00:00:00.000+00:00", day)
      group by dag)
      , log_filtrado as (
        select dag, timestamp, status
        from `ntt-data-argentina-macro.logs_composer.airflow_logging`
          join filtro
           on dag_filtro = dag
          and timestamp = ejecucion
      )



      SELECT  functional_module_txt
      , case when status is null then 'pending' else status end estado
      , case when case when status is null then 'pending' else status end = 'pending' and  timestamp_add(TIMESTAMP_TRUNC("2023-01-05T00:00:00.000+00:00", day), interval (cast(cutoff_time_num/100 as INT64)) HOUR) < CURRENT_TIMESTAMP() then 'demorado'
      else '' end estado2
      , count(dag_txt) cant



      FROM `ntt-data-argentina-macro.logs_composer.lkp_dag`
      left join  log_filtrado--  `ntt-data-argentina-macro.logs_composer.airflow_logging`
      on dag_txt = dag
      where (TIMESTAMP_TRUNC(timestamp, DAY) = TIMESTAMP_TRUNC("2023-01-05T00:00:00.000+00:00", day) or timestamp is null)
      and periodicity_txt = 'diaria'
      group by functional_module_txt, status, cutoff_time_num
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: functional_module_txt {
    type: string
    sql: ${TABLE}.functional_module_txt ;;
  }

  dimension: estado {
    type: string
    sql: ${TABLE}.estado ;;
  }

  dimension: estado2 {
    type: string
    sql: ${TABLE}.estado2 ;;
  }

  dimension: cant {
    type: number
    sql: ${TABLE}.cant ;;
  }

  set: detail {
    fields: [functional_module_txt, estado, estado2, cant]
  }
}
