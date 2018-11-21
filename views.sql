// A view is an enhanced version of the original tables from Snowflake.
// Views are used to build dashboards and they can be sliced and filtered in explores.
// Views are composed of 
//    - Dimensions
//    - Measures
//    - Field Sets

// Views are created in view.lkml files
// These files can be found in the Looker -> Develop -> ProjectName page. ("Views" list on left hand side)
// Direct URL Example:  https://resyanalytics.looker.com/projects/resysnowflake/files/reservations.view.lkml

// Simplest possible view
-- it only involves one original table
-- it doesn't have any custom measures
-- it only includes one dimension to declare a primary key

view: reservations {
  sql_table_name: AURORA_CORE.RESERVATION_BOOKRESERVATION ;;
  
    dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}."ID" ;;
  }
  ## this is a commented out line
  ## can be used to annotate code to make it easier to understand
}
  
  
// A view with one simple measure and simple dimension
-- a dimension is a transformed field (one new quantity per row)
-- a measure is an aggregate quantity (count, average, max, etc) or other function evaluated using one or more rows of this view.
-- https://docs.snowflake.net/manuals/sql-reference/sql/create-view.html

view: reservations {
  sql_table_name: AURORA_CORE.RESERVATION_BOOKRESERVATION ;;

  ## custom dimensions / measures
  
    dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}."ID" ;;
  }

    measure: count_cancellations {
    type: count
    filters: {
      field: is_cancelled
      value: "1"
    }
  }
  
  
  // View involving multiple joined tables
  
view: user_facts {
  derived_table: {
    sql: select
        r1.user_id
        ,count(distinct venue_id) as unique_venues
        ,count(*) as lifetime_bookings

      from aurora_core.reservation_bookreservation r1
      inner join aurora_core.user_user u on r1.user_id = u.id
       ;;
   dimension: user_id {
    type: number
    primary_key: yes
    sql: ${TABLE}."USER_ID" ;;
  }     
       
}
  

