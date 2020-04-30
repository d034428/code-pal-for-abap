CLASS ltd_clean_code_manager DEFINITION FOR TESTING.
  PUBLIC SECTION.
    INTERFACES: y_if_clean_code_manager.
ENDCLASS.

CLASS ltd_clean_code_manager IMPLEMENTATION.
  METHOD y_if_clean_code_manager~read_check_customizing.
    result = VALUE #( ( apply_on_testcode = abap_true apply_on_productive_code = abap_true prio = 'N' threshold = 0 ) ).
    result = VALUE #( BASE result
                    ( apply_on_testcode = abap_true apply_on_productive_code = abap_true prio = 'E' threshold = 0 ) ).
  ENDMETHOD.

  METHOD y_if_clean_code_manager~calculate_obj_creation_date.
    result = '20190101'.
  ENDMETHOD.
ENDCLASS.

CLASS ltd_ref_scan_manager DEFINITION FOR TESTING.
  PUBLIC SECTION.
    INTERFACES: y_if_scan_manager PARTIALLY IMPLEMENTED.

    METHODS:
      set_data_for_ok,
      set_data_for_error,
      set_check_pseudo_comment_ok.

  PRIVATE SECTION.
    DATA:
      levels     TYPE slevel_tab,
      structures TYPE sstruc_tab,
      statements TYPE sstmnt_tab,
      tokens     TYPE stokesx_tab.
ENDCLASS.

CLASS ltd_ref_scan_manager IMPLEMENTATION.
  METHOD y_if_scan_manager~get_structures.
    result = structures.
  ENDMETHOD.

  METHOD y_if_scan_manager~get_statements.
    result = statements.
  ENDMETHOD.

  METHOD y_if_scan_manager~get_tokens.
    result = tokens.
  ENDMETHOD.

  METHOD y_if_scan_manager~get_levels.
    result = levels.
  ENDMETHOD.

  METHOD y_if_scan_manager~set_ref_scan.
    RETURN.
  ENDMETHOD.

  METHOD y_if_scan_manager~is_scan_ok.
    result = abap_true.
  ENDMETHOD.

  METHOD set_data_for_ok.
    levels = VALUE #( ( depth = 1 level = 0 stmnt = 0 from = 1 to = 5 name = 'ZTEST' type = 'P' ) ).

    structures = VALUE #( ( stmnt_from = 1 stmnt_to = 5 type = scan_struc_type-class stmnt_type = scan_struc_stmnt_type-method ) ).

    statements = VALUE #( ( level = 1 from = '1' to = '1' type = 'K' )
                          ( level = 1 from = '2' to = '3' type = 'K' )
                          ( level = 1 from = '4' to = '6' type = 'K' )
                          ( level = 1 from = '7' to = '8' type = 'K' )
                          ( level = 1 from = '9' to = '10' type = 'K' )
                          ( level = 1 from = '11' to = '12' type = 'K' ) ).

    tokens = VALUE #( ( str = 'THROW'     type = 'I' row = 1 )
                      ( str = 'RAISE'     type = 'I' row = 2 )
                      ( str = 'EXCEPTION' type = 'I' row = 2 )
                      ( str = 'RAISE'     type = 'I' row = 3 )
                      ( str = 'RESUMABLE' type = 'I' row = 3 )
                      ( str = 'EXCEPTION' type = 'I' row = 3 )
                      ( str = 'RAISE'     type = 'I' row = 4 )
                      ( str = 'SHORTDUMP' type = 'I' row = 4 )
                      ( str = 'RAISE'     type = 'I' row = 5 )
                      ( str = 'EVENT'     type = 'I' row = 5 )
                      ( str = 'MESSAGE'   type = 'I' row = 6 )
                      ( str = 'MSG_NAME'  type = 'I' row = 6 ) ).
  ENDMETHOD.

  METHOD set_data_for_error.
    levels = VALUE #( ( depth = 1 level = 0 stmnt = 0 from = 1 to = 3 name = 'ZTEST' type = 'P' ) ).

    structures = VALUE #( ( stmnt_from = 1 stmnt_to = 3 type = scan_struc_type-class stmnt_type = scan_struc_stmnt_type-method ) ).

    statements = VALUE #( ( level = 1 from = '1' to = '2' type = 'K' )
                          ( level = 1 from = '3' to = '4' type = 'K' )
                          ( level = 1 from = '5' to = '6' type = 'K' ) ).

    tokens = VALUE #( ( str = 'RAISE'             type = 'I' row = 1 )
                      ( str = 'SYSTEM-EXCEPTIONS' type = 'I' row = 1 )
                      ( str = 'RAISE'             type = 'I' row = 2 )
                      ( str = 'EX_NAME'           type = 'I' row = 2 )
                      ( str = 'MESSAGE'           type = 'I' row = 3 )
                      ( str = 'RAISING'           type = 'I' row = 3 ) ).
  ENDMETHOD.

  METHOD set_check_pseudo_comment_ok.
    levels = VALUE #( ( depth = 1 level = 0 stmnt = 0 from = 1 to = 6 name = 'ZTEST' type = 'P' ) ).

    structures = VALUE #( ( stmnt_from = 1 stmnt_to = 6 type = scan_struc_type-class stmnt_type = scan_struc_stmnt_type-method ) ).

    statements = VALUE #( ( level = 1 from = '1' to = '2' type = 'K' )
                          ( level = 1 from = '3' to = '3' type = 'P' )
                          ( level = 1 from = '4' to = '5' type = 'K' )
                          ( level = 1 from = '6' to = '6' type = 'P' )
                          ( level = 1 from = '7' to = '8' type = 'K' )
                          ( level = 1 from = '9' to = '9' type = 'P' ) ).

    tokens = VALUE #( ( str = 'RAISE'              type = 'I' row = 1 )
                      ( str = 'SYSTEM-EXCEPTIONS'  type = 'I' row = 1 )
                      ( str = '"#EC NON_CL_EXCEPT' type = 'C' row = 1 )
                      ( str = 'RAISE'              type = 'I' row = 2 )
                      ( str = 'EX_NAME'            type = 'I' row = 2 )
                      ( str = '"#EC NON_CL_EXCEPT' type = 'C' row = 2 )
                      ( str = 'MESSAGE'            type = 'I' row = 3 )
                      ( str = 'RAISING'            type = 'I' row = 3 )
                      ( str = '"#EC NON_CL_EXCEPT' type = 'C' row = 3 ) ).
  ENDMETHOD.
ENDCLASS.

CLASS ltd_clean_code_exemption_no DEFINITION FOR TESTING
  INHERITING FROM y_exemption_handler.

  PUBLIC SECTION.
    METHODS: is_object_exempted REDEFINITION.
ENDCLASS.

CLASS ltd_clean_code_exemption_no IMPLEMENTATION.
  METHOD is_object_exempted.
    RETURN.
  ENDMETHOD.
ENDCLASS.

CLASS local_test_class DEFINITION FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PRIVATE SECTION.
    DATA: cut                     TYPE REF TO y_check_non_class_exception,
          ref_scan_manager_double TYPE REF TO ltd_ref_scan_manager.

    METHODS:
      setup,
      assert_errors IMPORTING err_cnt TYPE i,
      assert_pseudo_comments IMPORTING pc_cnt TYPE i,
      is_bound FOR TESTING,
      check_ok FOR TESTING,
      check_error FOR TESTING,
      check_pseudo_comment_ok FOR TESTING.
ENDCLASS.

CLASS y_check_non_class_exception DEFINITION LOCAL FRIENDS local_test_class.

CLASS local_test_class IMPLEMENTATION.
  METHOD setup.
    cut = NEW y_check_non_class_exception( ).
    ref_scan_manager_double = NEW ltd_ref_scan_manager( ).
    cut->ref_scan_manager ?= ref_scan_manager_double.
    cut->clean_code_manager = NEW ltd_clean_code_manager( ).
    cut->clean_code_exemption_handler = NEW ltd_clean_code_exemption_no( ).
    cut->attributes_maintained = abap_true.
  ENDMETHOD.

  METHOD is_bound.
    cl_abap_unit_assert=>assert_bound(
      EXPORTING
        act = cut ).
  ENDMETHOD.

  METHOD check_ok.
    ref_scan_manager_double->set_data_for_ok( ).
    cut->run( ).
    assert_errors( 0 ).
    assert_pseudo_comments( 0 ).
  ENDMETHOD.

  METHOD check_error.
    ref_scan_manager_double->set_data_for_error( ).
    cut->run( ).
    assert_errors( 3 ).
    assert_pseudo_comments( 0 ).
  ENDMETHOD.

  METHOD check_pseudo_comment_ok.
    ref_scan_manager_double->set_check_pseudo_comment_ok( ).
    cut->run( ).
    assert_errors( 0 ).
    assert_pseudo_comments( 3 ).
  ENDMETHOD.

  METHOD assert_errors.
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = cut->statistics->get_number_errors( )
        exp = err_cnt ).
  ENDMETHOD.

  METHOD assert_pseudo_comments.
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = cut->statistics->get_number_pseudo_comments( )
        exp = pc_cnt ).
  ENDMETHOD.
ENDCLASS.
