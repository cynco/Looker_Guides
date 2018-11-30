 measure: count_last_reservation {
    type: count
    filters: {
      field: user_reservation_sequence_facts.reverse_reservation_sequence_number
      value: "1"
    }
    filters: {
      field: user_reservation_sequence_facts.reservation_sequence_number
      value: ">5"
    }
    filters: {
      field: date_created_date
      value: "before 30 days ago"
    }

    drill_fields: [reservation_details*]
