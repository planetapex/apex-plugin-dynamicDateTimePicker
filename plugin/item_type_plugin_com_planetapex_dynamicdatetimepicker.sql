set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050000 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2013.01.01'
,p_release=>'5.0.3.00.03'
,p_default_workspace_id=>1301105260114689
,p_default_application_id=>104
,p_default_owner=>'SCOTT'
);
end;
/
prompt --application/ui_types
begin
null;
end;
/
prompt --application/shared_components/plugins/item_type/com_planetapex_dynamicdatetimepicker
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(6933619177812799)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'COM.PLANETAPEX.DYNAMICDATETIMEPICKER'
,p_display_name=>'Dynamic Date Time Picker'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_javascript_file_urls=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#PLUGIN_FILES#js/datepicker.min.js',
'#PLUGIN_FILES#js/dynamicDateTimePicker.min.js',
''))
,p_css_file_urls=>'#PLUGIN_FILES#css/datepicker.min.css'
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'g_mnmx_frmt VARCHAR2(10) := ''MM/DD/YYYY''; ',
'FUNCTION formatExceptions(pi_format IN VARCHAR2, pi_mode IN VARCHAR2 DEFAULT ''decode'') RETURN VARCHAR2 IS v_temp_format VARCHAR2(200); BEGIN v_temp_format := pi_format; IF pi_mode = ''encode'' THEN v_temp_format := REPLACE(v_temp_format, ''fmMonth'', ''fm'
||'M0nth''); v_temp_format := REPLACE(v_temp_format, ''fmDD'', ''fm0AY''); v_temp_format := REPLACE(v_temp_format, ''fmDay'', ''fm0ay''); v_temp_format := REPLACE(v_temp_format, ''DD'', ''0AY''); v_temp_format := REPLACE(v_temp_format, ''MONTH'', ''M@ONTH''); v_temp_for'
||'mat := REPLACE(v_temp_format, ''HH24'', ''H@H24''); ELSE v_temp_format := REPLACE(v_temp_format, ''fmM0nth'', ''fmMonth''); v_temp_format := REPLACE(v_temp_format, ''fm0ay'', ''fmDay''); v_temp_format := REPLACE(v_temp_format, ''fm0AY'', ''fmDD''); v_temp_format := '
||'REPLACE(v_temp_format, ''0AY'', ''DUD''); v_temp_format := REPLACE(v_temp_format, ''M@ONTH'', ''MONTH''); v_temp_format := REPLACE(v_temp_format, ''H@H24'', ''HH24''); END IF; RETURN v_temp_format; END; ',
'FUNCTION translateOracleJs(pi_format IN VARCHAR2) RETURN VARCHAR2 IS v_temp_format VARCHAR2(200); BEGIN v_temp_format := formatExceptions(pi_format, ''encode''); v_temp_format := REPLACE(v_temp_format, ''DAY'', ''D''); v_temp_format := REPLACE(v_temp_forma'
||'t, ''Day'', ''D''); v_temp_format := REPLACE(v_temp_format, ''HH24'', ''hh''); v_temp_format := REPLACE(v_temp_format, ''HH12'', ''hh''); v_temp_format := REPLACE(v_temp_format, ''HH'', ''hh''); v_temp_format := REPLACE(v_temp_format, ''MI'', ''ii''); v_temp_format := R'
||'EPLACE(v_temp_format, ''SS'', ''''); v_temp_format := REPLACE(v_temp_format, ''fmMM'', ''M''); v_temp_format := REPLACE(v_temp_format, ''MM'', ''mm''); v_temp_format := REPLACE(v_temp_format, ''WW'', ''w''); v_temp_format := REPLACE(v_temp_format, ''IW'', ''w''); v_temp'
||'_format := REPLACE(v_temp_format, ''DAY'', ''dd''); v_temp_format := REPLACE(v_temp_format, ''D'', ''E''); v_temp_format := REPLACE(v_temp_format, ''AM'', '' aa''); v_temp_format := REPLACE(v_temp_format, ''PM'', '' aa''); v_temp_format := REPLACE(v_temp_format, ''RR'
||''', ''yy''); v_temp_format := REPLACE(v_temp_format, ''YY'', ''yy''); v_temp_format := formatExceptions(v_temp_format, ''decode''); v_temp_format := REPLACE(v_temp_format, ''MONTH'', ''MM''); v_temp_format := REPLACE(v_temp_format, ''fmMonth'', ''MM''); v_temp_format'
||' := REPLACE(v_temp_format, ''Month'', ''MM''); v_temp_format := REPLACE(v_temp_format, ''MON'', ''M''); v_temp_format := REPLACE(v_temp_format, ''Mon'', ''M''); v_temp_format := REPLACE(v_temp_format, ''HH24'', ''hh''); v_temp_format := REPLACE(v_temp_format, ''DUD'','
||' ''dd''); v_temp_format := REPLACE(v_temp_format, ''fmDay'', ''DD''); v_temp_format := REPLACE(v_temp_format, ''fmDD'', ''dd''); RETURN v_temp_format; END; ',
'FUNCTION F_RENDER_DATEPICKER(P_ITEM IN APEX_PLUGIN.T_PAGE_ITEM, P_PLUGIN IN APEX_PLUGIN.T_PLUGIN, P_VALUE IN VARCHAR2, P_IS_READONLY IN BOOLEAN, P_IS_PRINTER_FRIENDLY IN BOOLEAN) RETURN APEX_PLUGIN.T_PAGE_ITEM_RENDER_RESULT AS V_RESULT APEX_PLUGIN.T_'
||'PAGE_ITEM_RENDER_RESULT; V_APP_ID APEX_APPLICATIONS.APPLICATION_ID%TYPE := apex_application.g_flow_id; V_PAGE_ITEM_NAME VARCHAR2(200); v_jquery_base_item VARCHAR2(200) := APEX_PLUGIN_UTIL.PAGE_ITEM_NAMES_TO_JQUERY(p_item.name); v_date_picker_type ape'
||'x_appl_plugins.attribute_01%TYPE := p_item.attribute_01; v_To_date_item_Name apex_appl_plugins.attribute_02%TYPE := Upper(p_item.attribute_02); v_firstDay apex_appl_plugins.attribute_03%TYPE := p_item.attribute_03; v_weekends apex_appl_plugins.attrib'
||'ute_04%TYPE := p_item.attribute_04; v_minDate apex_appl_plugins.attribute_05%TYPE := p_item.attribute_05; v_maxDate apex_appl_plugins.attribute_06%TYPE := p_item.attribute_06; v_minmaxHoursMins apex_appl_plugins.attribute_07%TYPE := p_item.attribute_'
||'07; v_showMethod apex_appl_plugins.attribute_08%TYPE := p_item.attribute_08; v_multipleDatesSeparator apex_appl_plugins.attribute_09%TYPE := p_item.attribute_09; v_dateTimeSeparator apex_appl_plugins.attribute_10%TYPE := p_item.attribute_10; v_timepi'
||'cker apex_appl_plugins.attribute_11%TYPE := p_item.attribute_11; v_position apex_appl_plugins.attribute_12%TYPE := lower(p_item.attribute_12); v_navTitles apex_appl_plugins.attribute_13%TYPE := p_item.attribute_13; v_options apex_appl_plugins.attribu'
||'te_14%TYPE := p_item.attribute_14; v_language p_plugin.attribute_03%TYPE := p_plugin.attribute_03; v_Navigation p_plugin.attribute_04%TYPE := p_plugin.attribute_04; v_Navigation_Size p_plugin.attribute_05%TYPE := p_plugin.attribute_05; att_orcl_date_'
||'format_mask p_item.format_mask%TYPE := nvl(p_item.format_mask, sys_context(''userenv'', ''nls_date_format'')); att_time_format BOOLEAN := CASE WHEN instr(Upper(att_orcl_date_format_mask), ''HH'') > 0 THEN TRUE ELSE FALSE END; att_time_formatSS BOOLEAN := C'
||'ASE WHEN instr(Upper(att_orcl_date_format_mask), ''SS'') > 0 THEN TRUE ELSE FALSE END; V_HTML VARCHAR2(32767); V_STMNT VARCHAR2(32767); v_minHour INTEGER; v_maxHour INTEGER; v_tk APEX_APPLICATION_GLOBAL.VC_ARR2; v_reg_chk INTEGER; v_minmax APEX_APPLICA'
||'TION_GLOBAL.VC_ARR2; v_mins APEX_APPLICATION_GLOBAL.VC_ARR2; v_maxs APEX_APPLICATION_GLOBAL.VC_ARR2; v_minHour INTEGER; v_maxHour INTEGER; TYPE ass_tab IS TABLE OF VARCHAR2(100); aar_opts ass_tab; aar_sels ass_tab := ass_tab(); aar_unsels ass_tab := '
||'ass_tab(); l_idx INTEGER; V_DATE_STR VARCHAR2(200); v_date_frmt VARCHAR2(200); v_time_frmt VARCHAR2(200); l_err_msg VARCHAR2(255); v_ui_chk CHAR(1); v_ver_chk CHAR(1); l_err_conf VARCHAR2(100) := ''--Plugin Configuration Error-- ''; BEGIN IF APEX_APPLI'
||'CATION.G_DEBUG THEN APEX_PLUGIN_UTIL.DEBUG_PAGE_ITEM(P_PLUGIN => P_PLUGIN, P_PAGE_ITEM => P_ITEM, P_VALUE => P_VALUE, P_IS_READONLY => P_IS_READONLY, P_IS_PRINTER_FRIENDLY => P_IS_PRINTER_FRIENDLY); END IF; SELECT CASE WHEN t.version_no LIKE ''5.0%'' T'
||'HEN ''Y'' WHEN t.version_no LIKE ''4%'' THEN ''Y'' ELSE ''N'' END Ver INTO v_ver_chk FROM APEX_RELEASE t; IF(v_date_picker_type IN (2, 5, 8, 11)) THEN SELECT CASE WHEN pi_org.item_name = pi_other.item_name THEN ''%ERROR_PREFIX% "'' || pa_ci.prompt || ''" must b'
||'e a different page item (can''''t be the same as self).'' WHEN pi_org.attribute_01 = 2 AND pi_other.item_name IS NULL THEN ''%ERROR_PREFIX% "'' || pa_ci.prompt || ''" item (%OTHER_ITEM_NAME%) does not exist'' ELSE NULL END err_msg INTO l_err_msg FROM apex_a'
||'pplication_page_items pi_org, apex_application_page_items pi_other, apex_appl_plugin_attributes pa_ci WHERE 1 = 1 AND pi_org.application_id = apex_application.g_flow_id AND pi_org.item_name = p_item.name AND pi_org.application_id = pi_other.applicati'
||'on_id(+) AND Upper(pi_org.attribute_02) = pi_other.item_name(+) AND pa_ci.application_id = pi_org.application_id AND upper(pi_org.display_as_code) = upper(''PLUGIN_'' || pa_ci.plugin_name) AND pa_ci.attribute_sequence = 2 AND pa_ci.attribute_scope = ''C'
||'omponent''; IF l_err_msg IS NOT NULL THEN l_err_msg := REPLACE(l_err_msg, ''%ERROR_PREFIX%'', ''%ITEM_NAME%:''); l_err_msg := REPLACE(l_err_msg, ''%ITEM_NAME%'', p_item.name); l_err_msg := REPLACE(l_err_msg, ''%OTHER_ITEM_NAME%'', v_To_date_item_Name); wwv_fl'
||'ow.show_error_message(p_message => l_err_conf, p_footer => l_err_msg); End if; END if; IF att_time_formatSS THEN att_orcl_date_format_mask := TRIM(trailing '':'' from Replace(Upper(att_orcl_date_format_mask), ''SS'', '''')); END IF; If ((v_timepicker = ''Y'''
||' OR v_date_picker_type in (10, 11)) AND Not att_time_format) THEN att_orcl_date_format_mask := att_orcl_date_format_mask || '' HH:MIPM''; att_time_format := true; end if; BEGIN V_STMNT := q''[begin :val :=TO_CHAR(SYSDATE,'']'' || att_orcl_date_format_mask'
||' || ''''''); end;''; EXECUTE IMMEDIATE V_STMNT USING OUT v_date_str; EXCEPTION WHEN OTHERS THEN wwv_flow.show_error_message(p_message => l_err_conf || '' Format Mask '', p_footer => att_orcl_date_format_mask || '' Format Mask is invalid. Provide a valid dat'
||'e/time format''); END; if v_minDate is NOT NULL AND NOT wwv_flow_utilities.is_date(p_date => v_minDate, p_format => g_mnmx_frmt) THEN wwv_flow.show_error_message(p_message => l_err_conf, p_footer => ''Minimum Date must be in "MM/DD/YYYY" Fomat Mask''); '
||'Elsif v_maxDate is NOT NULL AND NOT wwv_flow_utilities.is_date(p_date => v_maxDate, p_format => g_mnmx_frmt) THEN wwv_flow.show_error_message(p_message => l_err_conf, p_footer => ''Maximum Date must be in "MM/DD/YYYY" Fomat Mask''); END IF; IF P_IS_REA'
||'DONLY OR P_IS_PRINTER_FRIENDLY THEN APEX_PLUGIN_UTIL.PRINT_HIDDEN_IF_READONLY(P_ITEM_NAME => P_ITEM.NAME, P_VALUE => P_VALUE, P_IS_READONLY => P_IS_READONLY, P_IS_PRINTER_FRIENDLY => P_IS_PRINTER_FRIENDLY); APEX_PLUGIN_UTIL.PRINT_DISPLAY_ONLY(P_ITEM_'
||'NAME => P_ITEM.NAME, P_DISPLAY_VALUE => P_VALUE, P_SHOW_LINE_BREAKS => FALSE, P_ESCAPE => TRUE, P_ATTRIBUTES => P_ITEM.ELEMENT_ATTRIBUTES); ELSE V_PAGE_ITEM_NAME := APEX_PLUGIN.GET_INPUT_NAME_FOR_PAGE_ITEM(FALSE); V_HTML := ''<input type="text" id="%I'
||'D%" name="%NAME%" value="%VALUE%" autocomplete="off" size="%WIDTH%" '' || ''maxlength="%MAX_LEN%" placeholder="%PLACEHOLDER%" ''; IF InStr( '':'' || v_options || '':'', '':13:'') > 0 then V_HTML := V_HTML || ''readonly="readonly" ''; END IF; IF v_date_picker_ty'
||'pe = 2 THEN V_HTML := V_HTML || ''data-otheritem="%OTHERITEM%" ''; END IF; V_HTML := V_HTML || COALESCE(P_ITEM.ELEMENT_ATTRIBUTES, ''class="x-form-text" '') || ''/>''; SELECT CASE t.ui_type_id WHEN 1 THEN ''Y'' ELSE ''N'' END isDesktop INTO v_ui_chk FROM APEX_'
||'APPL_USER_INTERFACES t WHERE Upper(t.is_default) = ''YES'' AND t.application_id = v_app_id; IF v_showMethod != ''inline'' AND v_ui_chk = ''Y'' THEN V_HTML := V_HTML || ''<button type="button" class="dyndatepicker-trigger a-Button a-Button--calendar">'' || ''<'
||'span class="a-Icon icon-calendar"></span></button>''; END IF; V_HTML := REPLACE(V_HTML, ''%ID%'', P_ITEM.NAME); V_HTML := REPLACE(V_HTML, ''%NAME%'', V_PAGE_ITEM_NAME); V_HTML := REPLACE(V_HTML, ''%VALUE%'', SYS.HTF.ESCAPE_SC(P_VALUE)); V_HTML := REPLACE(V_'
||'HTML, ''%WIDTH%'', P_ITEM.element_width); V_HTML := REPLACE(V_HTML, ''%MAX_LEN%'', P_ITEM.ELEMENT_MAX_LENGTH); V_HTML := REPLACE(V_HTML, ''%PLACEHOLDER%'', P_ITEM.placeholder); V_HTML := REPLACE(V_HTML, ''%OTHERITEM%'', v_To_date_item_Name); SYS.HTP.P(V_HTML'
||'); V_HTML := ''''; CASE v_date_picker_type WHEN 1 THEN V_HTML := V_HTML || apex_javascript.add_attribute(''autoClose'', TRUE); WHEN 2 THEN V_HTML := V_HTML || apex_javascript.add_attribute(''range'', TRUE); V_HTML := V_HTML || apex_javascript.add_attribute'
||'(''dateToItem'', v_To_date_item_Name); WHEN 3 THEN V_HTML := V_HTML || apex_javascript.add_attribute(''multipleDates'', 100); IF v_multipleDatesSeparator IS NOT NULL THEN V_HTML := V_HTML || apex_javascript.add_attribute(''multipleDatesSeparator'', v_multi'
||'pleDatesSeparator); END IF; WHEN 4 THEN V_HTML := V_HTML || apex_javascript.add_attribute(''view'', ''months''); V_HTML := V_HTML || apex_javascript.add_attribute(''minView'', ''months''); V_HTML := V_HTML || apex_javascript.add_attribute(''autoClose'', TRUE);'
||' WHEN 5 THEN V_HTML := V_HTML || apex_javascript.add_attribute(''view'', ''months''); V_HTML := V_HTML || apex_javascript.add_attribute(''minView'', ''months''); V_HTML := V_HTML || apex_javascript.add_attribute(''range'', TRUE); V_HTML := V_HTML || apex_javas'
||'cript.add_attribute(''dateToItem'', v_To_date_item_Name); WHEN 6 THEN V_HTML := V_HTML || apex_javascript.add_attribute(''view'', ''months''); V_HTML := V_HTML || apex_javascript.add_attribute(''minView'', ''months''); V_HTML := V_HTML || apex_javascript.add_a'
||'ttribute(''multipleDates'', 100); WHEN 7 THEN V_HTML := V_HTML || apex_javascript.add_attribute(''view'', ''years''); V_HTML := V_HTML || apex_javascript.add_attribute(''minView'', ''years''); V_HTML := V_HTML || apex_javascript.add_attribute(''autoClose'', TRUE'
||'); WHEN 8 THEN V_HTML := V_HTML || apex_javascript.add_attribute(''view'', ''years''); V_HTML := V_HTML || apex_javascript.add_attribute(''minView'', ''years''); V_HTML := V_HTML || apex_javascript.add_attribute(''range'', TRUE); V_HTML := V_HTML || apex_javas'
||'cript.add_attribute(''dateToItem'', v_To_date_item_Name); WHEN 9 THEN V_HTML := V_HTML || apex_javascript.add_attribute(''view'', ''years''); V_HTML := V_HTML || apex_javascript.add_attribute(''minView'', ''years''); V_HTML := V_HTML || apex_javascript.add_att'
||'ribute(''multipleDates'', 100); WHEN 10 THEN V_HTML := V_HTML || apex_javascript.add_attribute(''timepicker'', TRUE); V_HTML := V_HTML || apex_javascript.add_attribute(''onlyTimepicker'', TRUE); V_HTML := V_HTML || apex_javascript.add_attribute(''todayBtnTe'
||'xt'', ''Now''); WHEN 11 THEN V_HTML := V_HTML || apex_javascript.add_attribute(''autoClose'', TRUE); V_HTML := V_HTML || apex_javascript.add_attribute(''dateToItem'', v_To_date_item_Name); V_HTML := V_HTML || apex_javascript.add_attribute(''timepicker'', TRUE'
||'); V_HTML := V_HTML || apex_javascript.add_attribute(''dateTimeSplit'', TRUE); END CASE; IF v_multipleDatesSeparator IS NOT NULL THEN V_HTML := V_HTML || apex_javascript.add_attribute(''multipleDatesSeparator'', v_multipleDatesSeparator); END IF; IF v_da'
||'teTimeSeparator IS NOT NULL OR v_date_picker_type = 11 THEN V_HTML := V_HTML || apex_javascript.add_attribute(''dateTimeSeparator'', v_dateTimeSeparator); END IF; IF v_timepicker = ''Y'' THEN V_HTML := V_HTML || apex_javascript.add_attribute(''timepicker'''
||', TRUE); IF v_minmaxHoursMins IS NOT NULL THEN SELECT COUNT(*) INTO v_reg_chk FROM dual WHERE regexp_like(v_minmaxHoursMins, ''^[0-9]{2}:[0-9]{2},[0-9]{2}:[0-9]{2}''); IF v_reg_chk = 1 THEN v_minmax := APEX_UTIL.STRING_TO_TABLE(v_minmaxHoursMins, '','');'
||' v_mins := APEX_UTIL.STRING_TO_TABLE(v_minmax(1), '':''); v_maxs := APEX_UTIL.STRING_TO_TABLE(v_minmax(2), '':''); V_HTML := V_HTML || apex_javascript.add_attribute(''minHours'', TO_NUMBER(v_mins(1))); V_HTML := V_HTML || apex_javascript.add_attribute(''max'
||'Hours'', TO_NUMBER(v_maxs(1))); V_HTML := V_HTML || apex_javascript.add_attribute(''minMinutes'', TO_NUMBER(v_mins(2))); V_HTML := V_HTML || apex_javascript.add_attribute(''maxMinutes'', TO_NUMBER(v_maxs(2))); ELSE wwv_flow.show_error_message(p_message =>'
||' l_err_conf || '' in Hours:Minutes Minimum,Maximum value-- '', p_footer => v_minmaxHoursMins || '' is not a valid value. Provide a value in as "00:00,23:59" .Refer to the Property Help.''); END IF; END IF; END IF; v_date_frmt := translateOracleJs(TRIM(su'
||'bstr(att_orcl_date_format_mask, 0, CASE WHEN att_time_format = FALSE THEN length(att_orcl_date_format_mask) ELSE Instr(UPPER(att_orcl_date_format_mask), ''HH'') - 1 END))); V_HTML := V_HTML || apex_javascript.add_attribute(''dateFormat'', v_date_frmt); v'
||'_time_frmt := translateOracleJs(TRIM(substr(att_orcl_date_format_mask, CASE att_time_format WHEN FALSE THEN length(att_orcl_date_format_mask) + 1 ELSE Instr(UPPER(att_orcl_date_format_mask), ''HH'') END, length(att_orcl_date_format_mask)))); V_HTML := '
||'V_HTML || apex_javascript.add_attribute(''timeFormat'', v_time_frmt); V_HTML := V_HTML || apex_javascript.add_attribute(''firstDay'', to_number(v_firstDay)); IF v_weekends IS NOT NULL THEN V_HTML := V_HTML || apex_javascript.add_attribute(''weekends'', ''['''
||' || REPLACE(v_weekends, '':'', '','') || '']''); END IF; IF v_minDate IS NOT NULL THEN V_HTML := V_HTML || ''"minDate": new Date('''''' || v_minDate || ''''''),''; END IF; IF v_maxDate IS NOT NULL THEN V_HTML := V_HTML || ''"maxDate": new Date('''''' || v_maxDate || '''
||'''''),''; END IF; IF v_showMethod = ''inline'' THEN V_HTML := V_HTML || apex_javascript.add_attribute(''inline'', TRUE); ELSE V_HTML := V_HTML || apex_javascript.add_attribute(''showMethod'', v_showMethod); END IF; V_HTML := V_HTML || apex_javascript.add_attr'
||'ibute(''position'', v_position); IF v_navTitles IS NOT NULL THEN V_HTML := V_HTML || ''"navTitles": {'' || v_navTitles || ''},''; END IF; IF p_item.element_css_classes IS NOT NULL THEN V_HTML := V_HTML || apex_javascript.add_attribute(''classes'', p_item.ele'
||'ment_css_classes); END IF; v_tk := APEX_UTIL.STRING_TO_TABLE(v_options); aar_opts := ass_tab(''toggleSelected'', ''autoClose'', ''keyboardNav'', ''todayButton'', ''clearButton'', ''showOtherMonths'', ''selectOtherMonths'', ''moveToOtherMonthsOnSelect'', ''showOtherYe'
||'ars'', ''selectOtherYears'', ''moveToOtherYearsOnSelect'', ''disableNavWhenOutOfRange'', ''readOnly''); FOR i IN 1 .. v_tk.count LOOP aar_sels.extend; aar_sels(i) := aar_opts(to_NUMBER(v_tk(i))); END LOOP; aar_unsels := aar_opts MULTISET except aar_sels; l_id'
||'x := aar_sels.first; WHILE (l_idx IS NOT NULL) LOOP IF aar_opts(l_idx) = ''todayButton'' THEN V_HTML := V_HTML || ''"todayButton": new Date(),''; ELSE V_HTML := V_HTML || apex_javascript.add_attribute(aar_sels(l_idx), TRUE); END IF; l_idx := aar_sels.nex'
||'t(l_idx); END LOOP; l_idx := aar_unsels.first; WHILE (l_idx IS NOT NULL) LOOP V_HTML := V_HTML || apex_javascript.add_attribute(aar_unsels(l_idx), FALSE); l_idx := aar_unsels.next(l_idx); END LOOP; IF v_language != ''en'' THEN APEX_JAVASCRIPT.ADD_LIBRA'
||'RY(P_NAME => ''datepicker.'' || v_language, p_skip_extension => FALSE, P_DIRECTORY => p_plugin.file_prefix || ''js/i18n/'', P_VERSION => NULL); END IF; V_HTML := V_HTML || apex_javascript.add_attribute(''language'', v_language); IF v_Navigation = ''dent'' TH'
||'EN V_HTML := V_HTML || ''"prevHtml":"<span class=''''fa fa-dedent '' || v_Navigation_Size || ''''''></span>",''; V_HTML := V_HTML || ''"nextHtml":"=<span class=''''fa fa-indent '' || v_Navigation_Size || ''''''></span>",''; ELSIF v_Navigation != ''def'' THEN V_HTML :='
||' V_HTML || ''"prevHtml":"<span class=''''fa '' || v_Navigation || ''-left '' || v_Navigation_Size || ''''''></span>",''; V_HTML := V_HTML || ''"nextHtml":"<span class=''''fa '' || v_Navigation || ''-right '' || v_Navigation_Size || ''''''></span>",''; END IF; V_HTML := '
||'V_HTML || apex_javascript.add_attribute(''desktopUI'', CASE WHEN v_ui_chk = ''Y'' THEN TRUE ELSE FALSE END); V_HTML := V_HTML || apex_javascript.add_attribute(''dateItemID'', P_ITEM.NAME, p_omit_null => FALSE, p_add_comma => FALSE); IF v_showMethod = ''inli'
||'ne'' AND v_ui_chk != ''Y'' THEN V_HTML := ''apex.jQuery("'' || v_jquery_base_item || ''_CONTAINER").dynamicDateTimePicker({'' || V_HTML || ''}); ''; ELSIF v_showMethod = ''inline'' AND v_ui_chk = ''Y'' AND v_ver_chk = ''N'' THEN V_HTML := ''apex.jQuery("'' || v_jquer'
||'y_base_item || ''").parent("div").parent("div").dynamicDateTimePicker({'' || V_HTML || ''}); ''; ELSE V_HTML := ''apex.jQuery("'' || v_jquery_base_item || ''").dynamicDateTimePicker({'' || V_HTML || ''}); ''; END IF; APEX_JAVASCRIPT.ADD_ONLOAD_CODE(P_CODE => V'
||'_HTML, p_key => ''dynamicDateTimePicker_'' || p_item.name); V_RESULT.IS_NAVIGABLE := TRUE; END IF; RETURN V_RESULT; END F_RENDER_DATEPICKER;',
'FUNCTION F_VALIDATE_DATEPICKER(p_item IN apex_plugin.t_page_item, p_plugin IN apex_plugin.t_plugin, p_value IN VARCHAR2) RETURN apex_plugin.t_page_item_validation_result AS v_result apex_plugin.t_page_item_validation_result; V_APP_ID APEX_APPLICATION'
||'S.APPLICATION_ID%TYPE := apex_application.g_flow_id; V_PAGE_ID APEX_APPLICATION_PAGES.PAGE_ID%TYPE := apex_application.g_flow_step_id; attr_app_valdtn_chk p_plugin.attribute_01%TYPE := p_plugin.attribute_01; attr_app_valdtn_pos p_plugin.attribute_02%'
||'TYPE := p_plugin.attribute_02; v_date_picker_type apex_application_page_items.attribute_01%TYPE := p_item.attribute_01; v_other_item apex_application_page_items.attribute_02%TYPE := upper(p_item.attribute_02); v_minDate apex_appl_plugins.attribute_05'
||'%TYPE := p_item.attribute_05; v_maxDate apex_appl_plugins.attribute_06%TYPE := p_item.attribute_06; v_minmaxHoursMins apex_appl_plugins.attribute_07%TYPE := p_item.attribute_07; v_multipleDatesSeparator apex_appl_plugins.attribute_09%TYPE := p_item.a'
||'ttribute_09; v_dateTimeSeparator apex_appl_plugins.attribute_10%TYPE := p_item.attribute_10; v_timepicker apex_appl_plugins.attribute_11%TYPE := p_item.attribute_11; v_other_label apex_application_page_items.label%TYPE; v_other_item_val VARCHAR2(255)'
||'; att_orcl_date_format_mask apex_application_page_items.format_mask%TYPE := TRIM(trailing '':'' from Translate(Upper(nvl(p_item.format_mask, sys_context(''userenv'', ''nls_date_format''))), ''Ss'', ''::'')); v_minmax APEX_APPLICATION_GLOBAL.VC_ARR2; v_mins APE'
||'X_APPLICATION_GLOBAL.VC_ARR2; v_maxs APEX_APPLICATION_GLOBAL.VC_ARR2; v_minTime INTEGER; v_maxTime INTEGER; v_Time INTEGER; att_time_format BOOLEAN := CASE WHEN instr(att_orcl_date_format_mask, ''HH'') > 0 THEN TRUE ELSE FALSE END; v_date_frmt VARCHAR2'
||'(200); v_time_frmt VARCHAR2(200); v_date_arr WWV_FLOW_GLOBAL.VC_ARR2; l_date VARCHAR2(5000) := replace(p_value, v_dateTimeSeparator, '' ''); l_to_chk boolean := case when v_date_picker_type IN(2, 5, 8, 11) then true else false end; l_time_chk boolean :'
||'= v_timepicker = ''Y'' OR v_date_picker_type in (10, 11); l_msg VARCHAR2(1000) := ''%LABEL% Invalid '' || case v_date_picker_type when 10 then ''Time. Time'' else ''Date. Date'' end || '' must be in %FORMAT%'' || '' format Mask''; l_msg_gl VARCHAR2(1000) := ''%LA'
||'BEL% can not be %PREDICATE%''; BEGIN IF attr_app_valdtn_chk = ''Y'' THEN IF apex_application.g_debug THEN apex_plugin_util.debug_page_item(p_plugin => p_plugin, p_page_item => p_item, p_value => p_value, p_is_readonly => FALSE, p_is_printer_friendly => '
||'FALSE); END IF; v_result.display_location := CASE attr_app_valdtn_pos when ''FN'' THEN apex_plugin.c_inline_with_field_and_notif when ''F'' THEN apex_plugin.c_inline_with_field when ''N'' THEN apex_plugin.c_inline_in_notification when ''E'' THEN apex_plugin.'
||'c_on_error_page END; v_date_frmt := TRIM(substr(att_orcl_date_format_mask, 0, CASE WHEN att_time_format = FALSE THEN length(att_orcl_date_format_mask) ELSE Instr(UPPER(att_orcl_date_format_mask), ''HH'') - 1 END)); If l_time_chk THEN IF Not att_time_fo'
||'rmat THEN att_orcl_date_format_mask := att_orcl_date_format_mask || '' HH:MIPM''; END IF; att_time_format := TRUE; v_time_frmt := translateOracleJs(TRIM(substr(att_orcl_date_format_mask, Instr(UPPER(att_orcl_date_format_mask), ''HH''), length(att_orcl_da'
||'te_format_mask)))); v_minmax := APEX_UTIL.STRING_TO_TABLE(v_minmaxHoursMins, '',''); v_mins := APEX_UTIL.STRING_TO_TABLE(v_minmax(1), '':''); v_maxs := APEX_UTIL.STRING_TO_TABLE(v_minmax(2), '':''); v_minTime := v_mins(1) * 60 + v_mins(2); v_maxTime := v_m'
||'axs(1) * 60 + v_maxs(2); end if; IF v_date_picker_type IN (1, 2, 4, 5, 7, 8, 11) THEN if v_date_picker_type = 11 tHen v_date_frmt := att_orcl_date_format_mask; att_orcl_date_format_mask := TRIM(substr(att_orcl_date_format_mask, 0, CASE WHEN (att_time'
||'_format = FALSE) THEN length(att_orcl_date_format_mask) ELSE Instr(UPPER(att_orcl_date_format_mask), ''HH'') - 1 END)); ENd if; IF NOT l_to_chk AND l_date IS NULL THEN RETURN v_result; END IF; IF NOT wwv_flow_utilities.is_date(p_date => l_date, p_forma'
||'t => att_orcl_date_format_mask) THEN v_result.message := REPLACE(REPLACE(l_msg, ''%LABEL%'', ''#LABEL#''), ''%FORMAT%'', att_orcl_date_format_mask); RETURN v_result; END IF; v_time := To_NUMBER(To_char(To_date(l_date, att_orcl_date_format_mask), ''HH24'') * '
||'60) + To_NUMBER(To_char(To_date(l_date, att_orcl_date_format_mask), ''MI'')); IF (To_date(l_date, att_orcl_date_format_mask) < To_date(v_minDate, g_mnmx_frmt)) THEN v_result.message := REPLACE(REPLACE(l_msg_gl, ''%LABEL%'', ''#LABEL# date''), ''%PREDICATE%'''
||', ''less than '' || TO_CHAR(To_date(v_minDate, g_mnmx_frmt), att_orcl_date_format_mask) || '' minimum date.''); RETURN v_result; ELSIF (To_date(l_date, att_orcl_date_format_mask) > To_date(v_maxDate, g_mnmx_frmt)) THEN v_result.message := REPLACE(REPLACE'
||'(l_msg_gl, ''%LABEL%'', ''#LABEL# date''), ''%PREDICATE%'', ''greater than '' || TO_CHAR(To_date(v_maxDate, g_mnmx_frmt), att_orcl_date_format_mask) || '' maximum date.''); RETURN v_result; ELSIF v_date_picker_type != 11 AND v_time < v_minTime THEN v_result.me'
||'ssage := REPLACE(REPLACE(l_msg_gl, ''%LABEL%'', ''#LABEL# Time''), ''%PREDICATE%'', ''less than '' || v_minmax(1) || '' minimum time.''); RETURN v_result; ELSIF v_date_picker_type != 11 AND v_time > v_maxTime THEN v_result.message := REPLACE(REPLACE(l_msg_gl, '
||'''%LABEL%'', ''#LABEL# Time''), ''%PREDICATE%'', ''greater than '' || v_minmax(2) || '' maximum time.''); RETURN v_result; END IF; IF v_date_picker_type IN (2, 5, 8, 11) THEN if v_date_picker_type = 11 tHen att_orcl_date_format_mask := TRIM(substr(v_date_frmt,'
||' CASE att_time_format WHEN FALSE THEN length(v_date_frmt) + 1 ELSE Instr(UPPER(v_date_frmt), ''HH'') END, length(v_date_frmt))); ENd if; SELECT MAX(label) INTO v_other_label FROM apex_application_page_items WHERE application_id = v_app_id AND page_id ='
||' v_page_id AND item_name = upper(v_other_item); v_other_item_val := replace(v(v_other_item), v_dateTimeSeparator, '' ''); IF l_date IS NULL AND v_other_item_val IS NULL THEN RETURN v_result; ELSIF NOT wwv_flow_utilities.is_date(p_date => v_other_item_v'
||'al, p_format => att_orcl_date_format_mask) THEN l_msg := REPLACE(REPLACE(l_msg, ''%LABEL%'', v_other_label), ''%FORMAT%'', att_orcl_date_format_mask); v_result.message := case v_date_picker_type when 11 then Replace(l_msg, ''Date'', ''Time'') else l_msg end;'
||' v_result.page_item_name := v_other_item; RETURN v_result; END IF; v_time := To_NUMBER(To_char(To_date(v_other_item_val, att_orcl_date_format_mask), ''HH24'') * 60) + To_NUMBER(To_char(To_date(v_other_item_val, att_orcl_date_format_mask), ''MI'')); IF v_'
||'date_picker_type != 11 AND (To_date(v_other_item_val, att_orcl_date_format_mask) < To_date(v_minDate, g_mnmx_frmt)) THEN v_result.page_item_name := v_other_item; v_result.message := REPLACE(REPLACE(l_msg_gl, ''%LABEL%'', v_other_label || '' date''), ''%PR'
||'EDICATE%'', ''earlier than '' || TO_CHAR(To_date(v_minDate, g_mnmx_frmt), att_orcl_date_format_mask) || '' minimum date.''); RETURN v_result; ELSIF v_date_picker_type != 11 AND To_date(v_other_item_val, att_orcl_date_format_mask) > To_date(v_maxDate, g_mn'
||'mx_frmt) THEN v_result.page_item_name := v_other_item; v_result.message := REPLACE(REPLACE(l_msg_gl, ''%LABEL%'', v_other_label || '' date''), ''%PREDICATE%'', ''later than '' || TO_CHAR(To_date(v_maxDate, g_mnmx_frmt), att_orcl_date_format_mask) || '' maximu'
||'m date.''); RETURN v_result; ELSIF v_time < v_minTime THEN v_result.page_item_name := v_other_item; v_result.message := REPLACE(REPLACE(l_msg_gl, ''%LABEL%'', ''#LABEL# Time''), ''%PREDICATE%'', ''earlier than '' || v_minmax(1) || '' minimum time.''); RETURN v_'
||'result; ELSIF v_time > v_maxTime THEN v_result.page_item_name := v_other_item; v_result.message := REPLACE(REPLACE(l_msg_gl, ''%LABEL%'', v_other_label || '' date''), ''%PREDICATE%'', ''later than '' || v_minmax(2) || '' maximum time.''); RETURN v_result; END '
||'IF; END if; ELSIF v_date_picker_type = 10 THEN IF p_value IS NULL THEN RETURN v_result; END IF; IF NOT wwv_flow_utilities.is_date(p_date => l_date, p_format => att_orcl_date_format_mask) THEN v_result.message := REPLACE(l_msg, ''%LABEL%'', ''#LABEL#''); '
||'RETURN v_result; END IF; v_time := To_NUMBER(To_char(To_date(l_date, att_orcl_date_format_mask), ''HH24'') * 60) + To_NUMBER(To_char(To_date(l_date, att_orcl_date_format_mask), ''MI'')); IF v_time < v_minTime THEN v_result.message := REPLACE(REPLACE(l_ms'
||'g_gl, ''%LABEL%'', ''#LABEL# Time''), ''%PREDICATE%'', ''earlier than '' || v_minmax(1) || '' minimum time.''); RETURN v_result; ELSIF v_time > v_maxTime THEN v_result.message := REPLACE(REPLACE(l_msg_gl, ''%LABEL%'', ''#LABEL# Time''), ''%PREDICATE%'', ''later than '
||''' || v_minmax(2) || '' maximum time.''); RETURN v_result; END If; ELSIF v_date_picker_type IN (3, 6, 9) THEN IF p_value IS NULL THEN RETURN v_result; ELSE v_date_arr := APEX_UTIL.STRING_TO_TABLE(p_value, NVL(v_multipleDatesSeparator, '','')); FOR i IN 1 '
||'.. v_date_arr.count LOOP IF NOT wwv_flow_utilities.is_date(p_date => replace(v_date_arr(i), v_dateTimeSeparator, '' ''), p_format => att_orcl_date_format_mask) THEN v_result.message := ''#LABEL# Invalid date.Date must be in '' || att_orcl_date_format_mas'
||'k || '' format Mask''; RETURN v_result; END IF; v_time := To_NUMBER(To_char(To_date(v_date_arr(i), att_orcl_date_format_mask), ''HH24'') * 60) + To_NUMBER(To_char(To_date(v_date_arr(i), att_orcl_date_format_mask), ''MI'')); IF To_date(v_date_arr(i), att_or'
||'cl_date_format_mask) < To_date(v_minDate, g_mnmx_frmt) THEN v_result.message := REPLACE(REPLACE(l_msg_gl, ''%LABEL%'', ''#LABEL#''), ''%PREDICATE%'', ''earlier than '' || TO_CHAR(To_date(v_minDate, g_mnmx_frmt), att_orcl_date_format_mask) || '' minimum date.'''
||'); RETURN v_result; ELSIF (To_date(v_date_arr(i), att_orcl_date_format_mask) > To_date(v_maxDate, g_mnmx_frmt)) THEN v_result.message := REPLACE(REPLACE(l_msg_gl, ''%LABEL%'', ''#LABEL#''), ''%PREDICATE%'', ''later than '' || TO_CHAR(To_date(v_maxDate, g_mnm'
||'x_frmt), att_orcl_date_format_mask) || '' maximum date.''); RETURN v_result; ELSIF v_time < v_minTime THEN v_result.message := REPLACE(REPLACE(l_msg_gl, ''%LABEL%'', ''#LABEL# Time''), ''%PREDICATE%'', ''earlier than '' || v_minmax(1) || '' minimum time.''); RET'
||'URN v_result; ELSIF v_time > v_maxTime THEN v_result.message := REPLACE(REPLACE(l_msg_gl, ''%LABEL%'', ''#LABEL# Time''), ''%PREDICATE%'', ''later than '' || v_minmax(2) || '' maximum time.''); RETURN v_result; END IF; END LOOP; END IF; END IF; END IF; RETURN '
||'v_result; END F_VALIDATE_DATEPICKER;',
''))
,p_render_function=>'F_RENDER_DATEPICKER'
,p_validation_function=>'F_VALIDATE_DATEPICKER'
,p_standard_attributes=>'VISIBLE:SESSION_STATE:ESCAPE_OUTPUT:QUICKPICK:SOURCE:FORMAT_MASK_DATE:ELEMENT:WIDTH:HEIGHT:ELEMENT_OPTION:PLACEHOLDER:ENCRYPT'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.0'
,p_about_url=>'https://github.com/planetapex/apex-plugin-dynamicDateTimePicker'
,p_files_version=>29
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(7427375435373977)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Validation on Submit'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(7428544488503704)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Validation Display Position'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'FN'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(7427375435373977)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7429301114507234)
,p_plugin_attribute_id=>wwv_flow_api.id(7428544488503704)
,p_display_sequence=>10
,p_display_value=>'Inline with Field and in Notification'
,p_return_value=>'FN'
);
end;
/
begin
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7429698913508144)
,p_plugin_attribute_id=>wwv_flow_api.id(7428544488503704)
,p_display_sequence=>20
,p_display_value=>'Inline with Field'
,p_return_value=>'F'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7430085563509174)
,p_plugin_attribute_id=>wwv_flow_api.id(7428544488503704)
,p_display_sequence=>30
,p_display_value=>'Inline in Notification'
,p_return_value=>'N'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7430561719510000)
,p_plugin_attribute_id=>wwv_flow_api.id(7428544488503704)
,p_display_sequence=>40
,p_display_value=>'On Error Page'
,p_return_value=>'E'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(7434334895607472)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>3
,p_display_sequence=>8
,p_prompt=>'Language'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'en'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7435102343608674)
,p_plugin_attribute_id=>wwv_flow_api.id(7434334895607472)
,p_display_sequence=>10
,p_display_value=>'Chinese'
,p_return_value=>'zh'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7435504908611014)
,p_plugin_attribute_id=>wwv_flow_api.id(7434334895607472)
,p_display_sequence=>20
,p_display_value=>'Czech'
,p_return_value=>'cs'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7435950909613272)
,p_plugin_attribute_id=>wwv_flow_api.id(7434334895607472)
,p_display_sequence=>30
,p_display_value=>'Danish'
,p_return_value=>'da'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7436336552614764)
,p_plugin_attribute_id=>wwv_flow_api.id(7434334895607472)
,p_display_sequence=>40
,p_display_value=>'Deutsch(German)'
,p_return_value=>'de'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7436731063616366)
,p_plugin_attribute_id=>wwv_flow_api.id(7434334895607472)
,p_display_sequence=>50
,p_display_value=>'Dutch'
,p_return_value=>'nl'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7437169678618002)
,p_plugin_attribute_id=>wwv_flow_api.id(7434334895607472)
,p_display_sequence=>60
,p_display_value=>'English'
,p_return_value=>'en'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7437523266619139)
,p_plugin_attribute_id=>wwv_flow_api.id(7434334895607472)
,p_display_sequence=>70
,p_display_value=>'Finnish'
,p_return_value=>'fi'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7437912233620553)
,p_plugin_attribute_id=>wwv_flow_api.id(7434334895607472)
,p_display_sequence=>80
,p_display_value=>'French'
,p_return_value=>'fr'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7438291827622002)
,p_plugin_attribute_id=>wwv_flow_api.id(7434334895607472)
,p_display_sequence=>90
,p_display_value=>'Hungarian'
,p_return_value=>'hu'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7438687404623861)
,p_plugin_attribute_id=>wwv_flow_api.id(7434334895607472)
,p_display_sequence=>100
,p_display_value=>'Polish'
,p_return_value=>'pl'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7439153571625633)
,p_plugin_attribute_id=>wwv_flow_api.id(7434334895607472)
,p_display_sequence=>110
,p_display_value=>'Portuguese'
,p_return_value=>'pt'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7439479961626411)
,p_plugin_attribute_id=>wwv_flow_api.id(7434334895607472)
,p_display_sequence=>120
,p_display_value=>'Portuguese (Brazil)'
,p_return_value=>'pt-BR'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7439901262627740)
,p_plugin_attribute_id=>wwv_flow_api.id(7434334895607472)
,p_display_sequence=>130
,p_display_value=>'Romanian'
,p_return_value=>'ro'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7440317031628564)
,p_plugin_attribute_id=>wwv_flow_api.id(7434334895607472)
,p_display_sequence=>140
,p_display_value=>'Russian'
,p_return_value=>'ru'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7440718695629602)
,p_plugin_attribute_id=>wwv_flow_api.id(7434334895607472)
,p_display_sequence=>150
,p_display_value=>'Slovak'
,p_return_value=>'sk'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7441153810630706)
,p_plugin_attribute_id=>wwv_flow_api.id(7434334895607472)
,p_display_sequence=>160
,p_display_value=>'Spanish'
,p_return_value=>'es'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(7446393170724064)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Navigation Icons'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'def'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'<span class="fa fa-chevron-circle-left fa-2x"></span>'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7447218874725167)
,p_plugin_attribute_id=>wwv_flow_api.id(7446393170724064)
,p_display_sequence=>10
,p_display_value=>'Default'
,p_return_value=>'def'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7452043890779326)
,p_plugin_attribute_id=>wwv_flow_api.id(7446393170724064)
,p_display_sequence=>12
,p_display_value=>'Angle'
,p_return_value=>'fa-angle'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7452372339780712)
,p_plugin_attribute_id=>wwv_flow_api.id(7446393170724064)
,p_display_sequence=>14
,p_display_value=>'Angle Double'
,p_return_value=>'fa-angle-double'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7447596746735946)
,p_plugin_attribute_id=>wwv_flow_api.id(7446393170724064)
,p_display_sequence=>20
,p_display_value=>'Arrow'
,p_return_value=>'fa-arrow'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7448070375740780)
,p_plugin_attribute_id=>wwv_flow_api.id(7446393170724064)
,p_display_sequence=>30
,p_display_value=>'Arrow Circle'
,p_return_value=>'fa-arrow-circle'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7448797498745083)
,p_plugin_attribute_id=>wwv_flow_api.id(7446393170724064)
,p_display_sequence=>40
,p_display_value=>'Arrow Circle O'
,p_return_value=>'fa-arrow-circle-o'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7450810701772420)
,p_plugin_attribute_id=>wwv_flow_api.id(7446393170724064)
,p_display_sequence=>42
,p_display_value=>'Caret'
,p_return_value=>'fa-caret'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7451183222776245)
,p_plugin_attribute_id=>wwv_flow_api.id(7446393170724064)
,p_display_sequence=>44
,p_display_value=>'Caret  Square O'
,p_return_value=>'fa-caret-square-o'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7449228126755989)
,p_plugin_attribute_id=>wwv_flow_api.id(7446393170724064)
,p_display_sequence=>50
,p_display_value=>'Chevron'
,p_return_value=>'fa-chevron'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7449643013757732)
,p_plugin_attribute_id=>wwv_flow_api.id(7446393170724064)
,p_display_sequence=>60
,p_display_value=>'Chevron Circle'
,p_return_value=>'fa-chevron-circle'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7450004555763661)
,p_plugin_attribute_id=>wwv_flow_api.id(7446393170724064)
,p_display_sequence=>70
,p_display_value=>'Dedent/Indent'
,p_return_value=>'dent'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7450400374769348)
,p_plugin_attribute_id=>wwv_flow_api.id(7446393170724064)
,p_display_sequence=>80
,p_display_value=>'Hand O'
,p_return_value=>'fa-hand-o'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7451622987778029)
,p_plugin_attribute_id=>wwv_flow_api.id(7446393170724064)
,p_display_sequence=>110
,p_display_value=>'Long Arrow'
,p_return_value=>'fa-long-arrow'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7452869306785582)
,p_plugin_attribute_id=>wwv_flow_api.id(7446393170724064)
,p_display_sequence=>140
,p_display_value=>'Toggle'
,p_return_value=>'fa-toggle'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(7454939380875387)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Navigation Icon Size'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'fa-2x'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(7446393170724064)
,p_depending_on_condition_type=>'NOT_IN_LIST'
,p_depending_on_expression=>'def'
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7455731579877407)
,p_plugin_attribute_id=>wwv_flow_api.id(7454939380875387)
,p_display_sequence=>10
,p_display_value=>'1x'
,p_return_value=>'fa-1x'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7456110743878371)
,p_plugin_attribute_id=>wwv_flow_api.id(7454939380875387)
,p_display_sequence=>20
,p_display_value=>'2x'
,p_return_value=>'fa-2x'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7456517362879165)
,p_plugin_attribute_id=>wwv_flow_api.id(7454939380875387)
,p_display_sequence=>30
,p_display_value=>'3x'
,p_return_value=>'fa-3x'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7456919253880322)
,p_plugin_attribute_id=>wwv_flow_api.id(7454939380875387)
,p_display_sequence=>40
,p_display_value=>'4x'
,p_return_value=>'fa-4x'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(7230102311594788)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Date Picker Type'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'1'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Date Picker Type Selection.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7231023173596263)
,p_plugin_attribute_id=>wwv_flow_api.id(7230102311594788)
,p_display_sequence=>10
,p_display_value=>'Single Date Picker'
,p_return_value=>'1'
,p_help_text=>'Date Picker with only one date to select.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7231471800597113)
,p_plugin_attribute_id=>wwv_flow_api.id(7230102311594788)
,p_display_sequence=>20
,p_display_value=>'Date Range Picker'
,p_return_value=>'2'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>',
'Starting and ending date will be stored within separate APEX items. Attribute <b>Date to item</b> must be specified. Given APEX item will store ending date.',
'</p>',
'<b>Date to item</b> will get its ending range value from  Date Picker item'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7231794702597883)
,p_plugin_attribute_id=>wwv_flow_api.id(7230102311594788)
,p_display_sequence=>30
,p_display_value=>'Multiple Dates Picker'
,p_return_value=>'3'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Multiple Dates can be selected and stored in the Date Picker Item.</p>',
'<p>Multiple Dates Separator will be used to separate date. If not provided comma will be used as separator.</p>',
'<p>Multiple Dates works well with the following settings:',
'	<ul><li>Toggle Selected checked</li>',
'	<li>Auto Close unchecked</li>',
'</ul></p>'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7232244397599074)
,p_plugin_attribute_id=>wwv_flow_api.id(7230102311594788)
,p_display_sequence=>40
,p_display_value=>'Single Month Picker'
,p_return_value=>'4'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Months are displayed to be selected. Only a Single Month can be selected in this Picker.</p>',
'<p>Month Picker works well with the following settings:',
'	<ul>',
'	<li>Options => Auto close Checked</li>',
'	<li>Format Mask is set to <code><b>MM-YYYY</b></code></li>',
'	</ul>',
'</p>'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7320323374855978)
,p_plugin_attribute_id=>wwv_flow_api.id(7230102311594788)
,p_display_sequence=>50
,p_display_value=>'Months Range Picker'
,p_return_value=>'5'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'Months are displayed to be selected. ',
'<p>',
'Starting and ending months will be stored within separate APEX items. Attribute <b>Date to item</b> must be specified. Given APEX item will store ending month.',
'</p>',
'<p>Month Range Picker works well with the following settings:',
'	<ul>',
'	<li>Options => Auto close unchecked</li>',
'	<li>Format Mask is set to <code><b>MM-YYYY</b></code></li>',
'	</ul>',
'</p>'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7324611907981368)
,p_plugin_attribute_id=>wwv_flow_api.id(7230102311594788)
,p_display_sequence=>60
,p_display_value=>'Multiple Months Picker'
,p_return_value=>'6'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'Months are displayed to be selected.',
'<p>Multiple months  can be selected and stored in the Date Picker Item.</p>',
'<p>Multiple Date Separator will be used to separate months. If not provided comma will be used as a separator.</p>',
'<p>Multiple Months Picker works well with the following settings:',
'<ul>	',
'		<li>Toggle Selected checked </li>',
'		<li>Auto close unchecked.</li>',
'		<li>Format Mask is set to <code><b>MM-YYYY</b></code></li>',
'		</ul>',
'</p>'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7324991289982873)
,p_plugin_attribute_id=>wwv_flow_api.id(7230102311594788)
,p_display_sequence=>70
,p_display_value=>'Single Year Picker'
,p_return_value=>'7'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'Years are displayed to be selected. Only a single year can be selected in this Picker.',
'<p>Year Picker works well with the following settings:',
'	<ul>',
'			<li>Options => Auto close Checked</li>',
'			<li>Format Mask is set to <code><b>YYYY</b></code></li>',
'			</ul>',
'</p>'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7325439189984504)
,p_plugin_attribute_id=>wwv_flow_api.id(7230102311594788)
,p_display_sequence=>80
,p_display_value=>'Year Range Picker'
,p_return_value=>'8'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'Years are displayed to be selected. ',
'<p>',
'Starting and ending years will be stored within separate APEX items. Attribute <b>Date to item</b> must be specified. Given APEX item will store ending year.',
'</p>',
'',
'',
'<p>Year Range Picker works well with the following settings:',
'	<ul>',
'			<li>Options => Auto close Checked</li>',
'			<li>Format Mask is set to <code><b>YYYY</b></code></li>',
'	</ul>',
'</p>'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7325859112986649)
,p_plugin_attribute_id=>wwv_flow_api.id(7230102311594788)
,p_display_sequence=>90
,p_display_value=>'Multiple Years Picker'
,p_return_value=>'9'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'Years are displayed to be selected. ',
'<p>Multiple year can be selected and stored in the Date Picker Item.</p>',
'<p>Multiple Date Separator will be used to separate years. if not provided comma will be used as a separator.</p>',
'<p>Multiple Years Picker works well with the following settings:',
'	<ul>',
'			<li>Toggle Selected checked</li>',
'			<li>Options => Auto close Checked</li>',
'			<li>Format Mask is set to <code><b>YYYY</b></code></li>',
'	</ul>',
'</p>'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7328898335063761)
,p_plugin_attribute_id=>wwv_flow_api.id(7230102311594788)
,p_display_sequence=>100
,p_display_value=>'Time Picker Only'
,p_return_value=>'10'
,p_help_text=>'Only Time Picker is displayed.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7363163767875189)
,p_plugin_attribute_id=>wwv_flow_api.id(7230102311594788)
,p_display_sequence=>110
,p_display_value=>'Date Time Split'
,p_return_value=>'11'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'Date and Time will be will be stored within separate APEX items. The Date will be stored in the Date Picker Item and  Attribute <b>Date to item</b> item will store Time.',
'<p><b>Date to item</b> will get its time value from Date Picker item</p>',
'<p>Date Time Separator will be used to separate date and Time. if not provided space will be used as the default separator.</p>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(7192189823835827)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'To Date(Time) Item'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(7230102311594788)
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'2,5,8,11'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(7117015537136261)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>38
,p_prompt=>'First Day of Week'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_default_value=>'0'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'Determine which day the week will be started from. ',
'<p>By default Sunday is considered as first day of the week.</p>'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7117595168140935)
,p_plugin_attribute_id=>wwv_flow_api.id(7117015537136261)
,p_display_sequence=>10
,p_display_value=>'Sunday'
,p_return_value=>'0'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7118030637141776)
,p_plugin_attribute_id=>wwv_flow_api.id(7117015537136261)
,p_display_sequence=>20
,p_display_value=>'Monday'
,p_return_value=>'1'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7118386920146036)
,p_plugin_attribute_id=>wwv_flow_api.id(7117015537136261)
,p_display_sequence=>30
,p_display_value=>'Tuesday'
,p_return_value=>'2'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7118815920146667)
,p_plugin_attribute_id=>wwv_flow_api.id(7117015537136261)
,p_display_sequence=>40
,p_display_value=>'Wednesday'
,p_return_value=>'3'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7119235185147985)
,p_plugin_attribute_id=>wwv_flow_api.id(7117015537136261)
,p_display_sequence=>50
,p_display_value=>'Thursday'
,p_return_value=>'4'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7119602741148788)
,p_plugin_attribute_id=>wwv_flow_api.id(7117015537136261)
,p_display_sequence=>60
,p_display_value=>'Friday'
,p_return_value=>'5'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7120024519149760)
,p_plugin_attribute_id=>wwv_flow_api.id(7117015537136261)
,p_display_sequence=>70
,p_display_value=>'Saturday'
,p_return_value=>'6'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(7193531008890703)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Weekends'
,p_attribute_type=>'CHECKBOXES'
,p_is_required=>false
,p_default_value=>'6:0'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'List of day''s which will be considered as weekends. Class -weekend- will be added to relevant cells. ',
'<p>By default its Saturday and Sunday.</p>'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7194101814894750)
,p_plugin_attribute_id=>wwv_flow_api.id(7193531008890703)
,p_display_sequence=>10
,p_display_value=>'Saturday'
,p_return_value=>'6'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7194520764895481)
,p_plugin_attribute_id=>wwv_flow_api.id(7193531008890703)
,p_display_sequence=>20
,p_display_value=>'Sunday'
,p_return_value=>'0'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7194905602896152)
,p_plugin_attribute_id=>wwv_flow_api.id(7193531008890703)
,p_display_sequence=>30
,p_display_value=>'Monday'
,p_return_value=>'1'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7195273996897113)
,p_plugin_attribute_id=>wwv_flow_api.id(7193531008890703)
,p_display_sequence=>40
,p_display_value=>'Tuesday'
,p_return_value=>'2'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7195763170897775)
,p_plugin_attribute_id=>wwv_flow_api.id(7193531008890703)
,p_display_sequence=>50
,p_display_value=>'Wednesday'
,p_return_value=>'3'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7196124945898380)
,p_plugin_attribute_id=>wwv_flow_api.id(7193531008890703)
,p_display_sequence=>60
,p_display_value=>'Thursday'
,p_return_value=>'4'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7196493533899340)
,p_plugin_attribute_id=>wwv_flow_api.id(7193531008890703)
,p_display_sequence=>70
,p_display_value=>'Friday'
,p_return_value=>'5'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(7095886074924024)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Minimum Date'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<ul>',
'	<li>02/19/2017 </li>',
'	<li>Item Based . To set the minimum date to the start of the month, P1_MIN_DATE hidden Item is created and its value is set by the following <b>After Header PL/SQL Expression computation</b>:',
'		 <code>to_char(trunc(sysdate, ''MM''), ''MM/DD/YYYY'')</code></li>',
'</ul>',
'*Remember to use the date ''MM/DD/YYYY'' OR ''MM/DD/RRRR'' format Mask ',
'In the Minimum Date attribute refer the Item as :',
'<code>&P1_MIN_DATE.</code>'))
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'The minimum date for date picker. All dates, running before it can''t be selected.',
'<p>',
'	Minimum and Maximum date usually works well with the following settings:',
'	<ul>',
'		 <li>Disable Navigation When Out Of Range Option. So the user also can''t navigate to dates with Minimum and Maximum dates set.</li>',
'	</ul>',
'</p>',
'<p>The date value can be an absolute value in <code>"DD/MM/YYYY"</code> or <code>"DD/MM/RRRR"</code>date format mask or can be dynamic base on an item substituition value. </p>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(7096479665926063)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Maximum Date'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<ul>',
'	<li>02/19/2017 </li>',
'	<li>Item Based . To set the maximum date to the end of the month, P1_MAX_DATE hidden Item is created and its value is set by the following <b>After Header PL/SQL Expression computation</b>:',
'		 <code>to_char(last_day(sysdate), ''MM/DD/YYYY'')</code></li>',
'</ul>',
'*Remember to use the date ''MM/DD/YYYY'' OR ''MM/DD/RRRR'' format Mask ',
'In the Maximum Date attribute refer the Item as :',
'<code>&P1_MAX_DATE.</code>'))
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'The maximum date for date picker. All dates, running after it can''t be selected.',
'<p>',
'	Minimum and Maximum date usually works well with the following settings:',
'	<ul>',
'		 <li>Disable Navigation When Out Of Range Option. So the user also can''t navigate to dates with Minimum and Maximum dates set.</li>',
'	</ul>',
'</p>',
'<p>The date value can be an absolute value in <code>"DD/MM/YYYY"</code> or <code>"DD/MM/RRRR"</code>date format mask or can be dynamic base on an item substituition value. </p>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(7203275224048955)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>31
,p_prompt=>'Hours:Minutes Min Max'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'00:00,23:59'
,p_max_length=>15
,p_unit=>'Comma Separated'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(7199747980983736)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<ul>',
'	<li>Time from start of the day to 9:30 am then enter as following: 00:00,9:30 </li>',
'	<li>Restricting Time From 10:30 am to 6:45 pm is as following: 10:30,18:45</li>',
'</ul>'))
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'Minimum and Maximum hours value, must be between 00 and 23. You will not be able to choose value higher than this. ',
'<p>Minimum and Maximum Minutes value, must be between 00 and 59. You will not be able to choose value higher than this. </p>',
'',
'<p>',
'	The expression is a comma separated value between set of Minimum(Hour:Minute) and set of Maximum(Hour:Minute) as ',
'	 <code>Hour:Minute,Hour:Minute</code>',
'</p>',
'*<b>Do not leave any part.</b>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(7301320054134315)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_prompt=>'Show'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'clickicon'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Select when the date picker pop-up calendar displays.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7301788547136029)
,p_plugin_attribute_id=>wwv_flow_api.id(7301320054134315)
,p_display_sequence=>10
,p_display_value=>'On item click'
,p_return_value=>'click'
,p_help_text=>'The date time picker pop-up displays when the item  is clicked.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7302234308138573)
,p_plugin_attribute_id=>wwv_flow_api.id(7301320054134315)
,p_display_sequence=>20
,p_display_value=>'On icon click'
,p_return_value=>'icon'
,p_help_text=>'The date time picker pop-up displays when the icon is clicked.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7302666137145609)
,p_plugin_attribute_id=>wwv_flow_api.id(7301320054134315)
,p_display_sequence=>30
,p_display_value=>'On item and icon click'
,p_return_value=>'clickicon'
,p_help_text=>'The date time picker pop-up displays when the item or icon is clicked.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7302986727146805)
,p_plugin_attribute_id=>wwv_flow_api.id(7301320054134315)
,p_display_sequence=>40
,p_display_value=>'On focus'
,p_return_value=>'focus'
,p_help_text=>'The date time picker pop-up displays as soon as the item receives focus.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7303440865148382)
,p_plugin_attribute_id=>wwv_flow_api.id(7301320054134315)
,p_display_sequence=>50
,p_display_value=>'On mouse enter'
,p_return_value=>'mouseenter'
,p_help_text=>'The date time picker pop-up displays when mouse hovers over the item.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7303819588149460)
,p_plugin_attribute_id=>wwv_flow_api.id(7301320054134315)
,p_display_sequence=>60
,p_display_value=>'Inline'
,p_return_value=>'inline'
,p_help_text=>'The date time picker will be always visible, inline with the item.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(7098281174940437)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>22
,p_prompt=>'Multiple Dates Separator'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>','
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(7230102311594788)
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'3,6,9'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'Multiple Dates separator is used when concatenating dates to string in the following Date Picker types:',
'<ul>',
'	<li>Multiple Dates Picker</li>',
'	<li>Multiple Months Picker</li>',
'	<li>Multiple Years Picker</li>',
'</ul>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(7098916948941171)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>29
,p_prompt=>'Date Time Separator'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_max_length=>3
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(7199747980983736)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_examples=>'Separator between date and time'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(7199747980983736)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>28
,p_prompt=>'Time Picker'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_is_translatable=>false
,p_help_text=>'When Yes is selected , time picker widget will be added to Date Picker.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(7159558187850833)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>120
,p_prompt=>'Position'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_default_value=>'Bottom Left'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_examples=>'Right Top will set date picker''s position from right side upwards of text input.'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'Position of date picker relative to text input. ',
'<p>',
' <ul>',
' 	',
' 	 <li>First value is name of main axis, and </li>',
' 	 <li>second value is whether the Date Picker is rendered as ',
' 	   <ul>',
' 	   	 	    <li>Left(Leftwards)</li>',
' 	   	 	    <li>Right(Rightwards)</li>',
' 	   	 	    <li>Up(Upwards)</li>',
' 	   	 	    <li>Bottom(Downwards)</li>',
' 	   	</ul>',
' 	 </li>',
' </ul>',
'</p>'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7160151607853580)
,p_plugin_attribute_id=>wwv_flow_api.id(7159558187850833)
,p_display_sequence=>10
,p_display_value=>'Bottom Left'
,p_return_value=>'Bottom Left'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7160513521855580)
,p_plugin_attribute_id=>wwv_flow_api.id(7159558187850833)
,p_display_sequence=>20
,p_display_value=>'Bottom Right'
,p_return_value=>'Bottom Right'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7160908235857246)
,p_plugin_attribute_id=>wwv_flow_api.id(7159558187850833)
,p_display_sequence=>30
,p_display_value=>'Right Bottom'
,p_return_value=>'Right Top'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7161314300858548)
,p_plugin_attribute_id=>wwv_flow_api.id(7159558187850833)
,p_display_sequence=>40
,p_display_value=>'Right Top'
,p_return_value=>'Right Bottom'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7162648483869599)
,p_plugin_attribute_id=>wwv_flow_api.id(7159558187850833)
,p_display_sequence=>50
,p_display_value=>'Top Left'
,p_return_value=>'Top Left'
);
end;
/
begin
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7163072060871118)
,p_plugin_attribute_id=>wwv_flow_api.id(7159558187850833)
,p_display_sequence=>60
,p_display_value=>'Top Right'
,p_return_value=>'Top Right'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7163402488871930)
,p_plugin_attribute_id=>wwv_flow_api.id(7159558187850833)
,p_display_sequence=>70
,p_display_value=>'Left Top'
,p_return_value=>'Left Bottom'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7163852675873787)
,p_plugin_attribute_id=>wwv_flow_api.id(7159558187850833)
,p_display_sequence=>80
,p_display_value=>'Left Bottom'
,p_return_value=>'Left Top'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(7165426170918401)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>13
,p_display_sequence=>130
,p_prompt=>'DatePicker Title'
,p_attribute_type=>'HTML'
,p_is_required=>false
,p_is_translatable=>false
,p_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'For days view: ',
'<pre>"days":"<span style=''color:red;background-color:yellow;font-size:2em''>Check In:MM, yyyy</span>" </pre>',
'',
'For months view: ',
'',
'<pre>"months":"<span style=''color:red;background-color:yellow;font-size:2em''>Year:yyyy</span>" </pre>',
'',
'For years view: ',
'',
'<pre>"years":"<span style=''color:red;background-color:yellow;font-size:2em''>Decade:yyyy1 - yyyy2</span>" </pre>',
'',
'All can be combined with comma as following',
'<pre>"days":"<span style=''color:red;background-color:yellow;font-size:2em''>Check In:MM, yyyy</span>","months":"<span style=''color:white;background-color:green;font-size:2em''>Year:yyyy</span>","years":"<span style=''color:yellow;background-color:green;'
||'font-size:2em''>Decade:yyyy1 - yyyy2</span>"</pre>'))
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'Content of datepicker''s title depending on current view. ',
'<p>There are three views in the Date Picker </p>',
'<ul>',
'	<li>Days view i.e when selecting days, </li>',
'	<li>Months view i.e when selecting months and </li>',
'	<li>Years view i.e when selecting years. </li>',
'</ul>',
'',
'*Missing fields will be taken from default values. ',
'',
'<p>This setting can contain simple text, HTML with Styling and relevant, specific format mask. check out examples</p> ',
'<b>*Never Hard Break i.e keyboard return in code.</b>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(3124814256803246)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>14
,p_display_sequence=>140
,p_prompt=>'Options:'
,p_attribute_type=>'CHECKBOXES'
,p_is_required=>false
,p_default_value=>'3:4:5:6:7:8:9:10:11'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(3126218837807003)
,p_plugin_attribute_id=>wwv_flow_api.id(3124814256803246)
,p_display_sequence=>10
,p_display_value=>'Toggle Selected'
,p_return_value=>'1'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'If checked, then clicking on selected cell will remove it from selection and its value from the item.',
'<p> Do not use with Range Type Date Pickers.As the user wouldn''t be able to select same date as From and To date. If the user wants to clear the date use the Clear Button.</p>'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(3126680614808827)
,p_plugin_attribute_id=>wwv_flow_api.id(3124814256803246)
,p_display_sequence=>20
,p_display_value=>'Auto Close'
,p_return_value=>'2'
,p_help_text=>'If checked, date picker will close after date selection.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(3127050831810664)
,p_plugin_attribute_id=>wwv_flow_api.id(3124814256803246)
,p_display_sequence=>30
,p_display_value=>'Keyboard Navigation'
,p_return_value=>'3'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'If checked, then one can navigate through calendar by keyboard.',
'<p>',
'	Hot keys:</p>',
'<pre>',
'    <code>Ctrl + → | ↑</code>- move one month forwards',
'    <code>Ctrl + ← | ↓</code>- move one month backwards',
'    <code>Shift + → | ↑</code>- move one year forwards',
'    <code>Shift + ← | ↓</code>- move one year backwards',
'    <code>Alt + → | ↑</code>- move 10 years forwards',
'    <code>Alt + ← | ↓</code>- move 10 years backwards',
'    <code>Ctrl + Shift + ↑</code>- move to next view',
'    <code>Esc</code>- hides date picker',
'</pre>'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(3127449105814538)
,p_plugin_attribute_id=>wwv_flow_api.id(3124814256803246)
,p_display_sequence=>40
,p_display_value=>'Today Button'
,p_return_value=>'4'
,p_help_text=>'If checked,  "Today"  button will be visible.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(3127802351816078)
,p_plugin_attribute_id=>wwv_flow_api.id(3124814256803246)
,p_display_sequence=>50
,p_display_value=>'Clear Button'
,p_return_value=>'5'
,p_help_text=>'If checked, "Clear" button  will be visible.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(3128245273819138)
,p_plugin_attribute_id=>wwv_flow_api.id(3124814256803246)
,p_display_sequence=>60
,p_display_value=>'Show Days from Other Months[Days'' View]'
,p_return_value=>'6'
,p_help_text=>'If checked, days from other months will be visible.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(3128634379820806)
,p_plugin_attribute_id=>wwv_flow_api.id(3124814256803246)
,p_display_sequence=>70
,p_display_value=>'Select Days from Other Months[Days'' View]'
,p_return_value=>'7'
,p_help_text=>'If checked, the user can select days form other months.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(3129010447856208)
,p_plugin_attribute_id=>wwv_flow_api.id(3124814256803246)
,p_display_sequence=>80
,p_display_value=>'Transition to Selected Month[Days'' View]'
,p_return_value=>'8'
,p_help_text=>'If checked, selecting days from other month, will move to that month.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(3129432533858771)
,p_plugin_attribute_id=>wwv_flow_api.id(3124814256803246)
,p_display_sequence=>90
,p_display_value=>'Show other Years[Years'' View]'
,p_return_value=>'9'
,p_help_text=>'If checked, years from other decades will be visible.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(3129813776878050)
,p_plugin_attribute_id=>wwv_flow_api.id(3124814256803246)
,p_display_sequence=>100
,p_display_value=>'Select Other Years[Years'' View]	'
,p_return_value=>'10'
,p_help_text=>'If checked, user can select years from other decades'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(3130282347879764)
,p_plugin_attribute_id=>wwv_flow_api.id(3124814256803246)
,p_display_sequence=>110
,p_display_value=>'Transition to Selected Year[Years'' View]'
,p_return_value=>'11'
,p_help_text=>'If checked, selecting year from other decade, will move to that decade.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(3130684209881731)
,p_plugin_attribute_id=>wwv_flow_api.id(3124814256803246)
,p_display_sequence=>120
,p_display_value=>'Disable Navigation When Out Of Range'
,p_return_value=>'12'
,p_help_text=>'If checked, for dates less than minimum possible or more then maximum possible, navigation buttons (''forward'', ''back'') will be deactivated.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(3131040309885464)
,p_plugin_attribute_id=>wwv_flow_api.id(3124814256803246)
,p_display_sequence=>130
,p_display_value=>'Not Editiable'
,p_return_value=>'13'
,p_help_text=>'If checked, will make the Date Item(s) Read Only.'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(6959266564063072)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_name=>'onchangedecade'
,p_display_name=>'When Decade Changes'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(6960433244063074)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_name=>'onchangemonth'
,p_display_name=>'When Month Changes'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(7340033165457458)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_name=>'onchangeview'
,p_display_name=>'When View Changes'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(6959998442063074)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_name=>'onchangeyear'
,p_display_name=>'When Year Changes'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(6959642682063073)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_name=>'onhide'
,p_display_name=>'On Hiding'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(6961504711144427)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_name=>'onrendercell'
,p_display_name=>'On Rendering'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(6975261672386022)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_name=>'onselect'
,p_display_name=>'On Selection'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(6960796707144427)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_name=>'onshow'
,p_display_name=>'On Showing'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2166756E6374696F6E28742C652C69297B2166756E6374696F6E28297B76617220732C612C6E2C683D22322E322E33222C6F3D22646174657069636B6572222C723D222E646174657069636B65722D68657265222C633D21312C643D273C64697620636C';
wwv_flow_api.g_varchar2_table(2) := '6173733D22646174657069636B6572223E3C6920636C6173733D22646174657069636B65722D2D706F696E746572223E3C2F693E3C6E617620636C6173733D22646174657069636B65722D2D6E6176223E3C2F6E61763E3C64697620636C6173733D2264';
wwv_flow_api.g_varchar2_table(3) := '6174657069636B65722D2D636F6E74656E74223E3C2F6469763E3C2F6469763E272C6C3D7B746F64617942746E546578743A6E756C6C2C636C61737365733A22222C696E6C696E653A21312C6C616E67756167653A22656E222C7374617274446174653A';
wwv_flow_api.g_varchar2_table(4) := '6E657720446174652C66697273744461793A22222C7765656B656E64733A5B362C305D2C64617465466F726D61743A22222C616C744669656C643A22222C616C744669656C6444617465466F726D61743A2240222C746F67676C6553656C65637465643A';
wwv_flow_api.g_varchar2_table(5) := '21302C6B6579626F6172644E61763A21302C706F736974696F6E3A22626F74746F6D206C656674222C6F66667365743A31322C766965773A2264617973222C6D696E566965773A2264617973222C73686F774F746865724D6F6E7468733A21302C73656C';
wwv_flow_api.g_varchar2_table(6) := '6563744F746865724D6F6E7468733A21302C6D6F7665546F4F746865724D6F6E7468734F6E53656C6563743A21302C73686F774F7468657259656172733A21302C73656C6563744F7468657259656172733A21302C6D6F7665546F4F7468657259656172';
wwv_flow_api.g_varchar2_table(7) := '734F6E53656C6563743A21302C6D696E446174653A22222C6D6178446174653A22222C64697361626C654E61765768656E4F75744F6652616E67653A21302C6D756C7469706C6544617465733A21312C6D756C7469706C65446174657353657061726174';
wwv_flow_api.g_varchar2_table(8) := '6F723A222C222C72616E67653A21312C746F646179427574746F6E3A21312C636C656172427574746F6E3A21312C73686F774576656E743A22666F637573222C6175746F436C6F73653A21312C6D6F6E7468734669656C643A226D6F6E74687353686F72';
wwv_flow_api.g_varchar2_table(9) := '74222C7072657648746D6C3A273C7376673E3C7061746820643D224D2031372C3132206C202D352C35206C20352C35223E3C2F706174683E3C2F7376673E272C6E65787448746D6C3A273C7376673E3C7061746820643D224D2031342C3132206C20352C';
wwv_flow_api.g_varchar2_table(10) := '35206C202D352C35223E3C2F706174683E3C2F7376673E272C6E61765469746C65733A7B646179733A224D4D2C203C693E797979793C2F693E222C6D6F6E7468733A2279797979222C79656172733A227979797931202D207979797932227D2C74696D65';
wwv_flow_api.g_varchar2_table(11) := '7069636B65723A21312C6F6E6C7954696D657069636B65723A21312C6461746554696D65536570617261746F723A2220222C74696D65466F726D61743A22222C6D696E486F7572733A302C6D6178486F7572733A32342C6D696E4D696E757465733A302C';
wwv_flow_api.g_varchar2_table(12) := '6D61784D696E757465733A35392C686F757273537465703A312C6D696E75746573537465703A312C6F6E53656C6563743A22222C6F6E53686F773A22222C6F6E486964653A22222C6F6E4368616E67654D6F6E74683A22222C6F6E4368616E6765596561';
wwv_flow_api.g_varchar2_table(13) := '723A22222C6F6E4368616E67654465636164653A22222C6F6E4368616E6765566965773A22222C6F6E52656E64657243656C6C3A22227D2C753D7B6374726C52696768743A5B31372C33395D2C6374726C55703A5B31372C33385D2C6374726C4C656674';
wwv_flow_api.g_varchar2_table(14) := '3A5B31372C33375D2C6374726C446F776E3A5B31372C34305D2C736869667452696768743A5B31362C33395D2C736869667455703A5B31362C33385D2C73686966744C6566743A5B31362C33375D2C7368696674446F776E3A5B31362C34305D2C616C74';
wwv_flow_api.g_varchar2_table(15) := '55703A5B31382C33385D2C616C7452696768743A5B31382C33395D2C616C744C6566743A5B31382C33375D2C616C74446F776E3A5B31382C34305D2C6374726C536869667455703A5B31362C31372C33385D7D2C6D3D66756E6374696F6E28742C61297B';
wwv_flow_api.g_varchar2_table(16) := '746869732E656C3D742C746869732E24656C3D652874292C746869732E6F7074733D652E657874656E642821302C7B7D2C6C2C612C746869732E24656C2E646174612829292C733D3D69262628733D652822626F64792229292C746869732E6F7074732E';
wwv_flow_api.g_varchar2_table(17) := '7374617274446174657C7C28746869732E6F7074732E7374617274446174653D6E65772044617465292C22494E505554223D3D746869732E656C2E6E6F64654E616D65262628746869732E656C4973496E7075743D2130292C746869732E6F7074732E61';
wwv_flow_api.g_varchar2_table(18) := '6C744669656C64262628746869732E24616C744669656C643D22737472696E67223D3D747970656F6620746869732E6F7074732E616C744669656C643F6528746869732E6F7074732E616C744669656C64293A746869732E6F7074732E616C744669656C';
wwv_flow_api.g_varchar2_table(19) := '64292C746869732E696E697465643D21312C746869732E76697369626C653D21312C746869732E73696C656E743D21312C746869732E63757272656E74446174653D746869732E6F7074732E7374617274446174652C746869732E63757272656E745669';
wwv_flow_api.g_varchar2_table(20) := '65773D746869732E6F7074732E766965772C746869732E5F63726561746553686F72744375747328292C746869732E73656C656374656444617465733D5B5D2C746869732E76696577733D7B7D2C746869732E6B6579733D5B5D2C746869732E6D696E52';
wwv_flow_api.g_varchar2_table(21) := '616E67653D22222C746869732E6D617852616E67653D22222C746869732E5F707265764F6E53656C65637456616C75653D22222C746869732E696E697428297D3B6E3D6D2C6E2E70726F746F747970653D7B56455253494F4E3A682C76696577496E6465';
wwv_flow_api.g_varchar2_table(22) := '7865733A5B2264617973222C226D6F6E746873222C227965617273225D2C696E69743A66756E6374696F6E28297B637C7C746869732E6F7074732E696E6C696E657C7C21746869732E656C4973496E7075747C7C746869732E5F6275696C644461746570';
wwv_flow_api.g_varchar2_table(23) := '69636B657273436F6E7461696E657228292C746869732E5F6275696C644261736548746D6C28292C746869732E5F646566696E654C6F63616C6528746869732E6F7074732E6C616E6775616765292C746869732E5F73796E63576974684D696E4D617844';
wwv_flow_api.g_varchar2_table(24) := '6174657328292C746869732E656C4973496E707574262628746869732E6F7074732E696E6C696E657C7C28746869732E5F736574506F736974696F6E436C617373657328746869732E6F7074732E706F736974696F6E292C746869732E5F62696E644576';
wwv_flow_api.g_varchar2_table(25) := '656E74732829292C746869732E6F7074732E6B6579626F6172644E6176262621746869732E6F7074732E6F6E6C7954696D657069636B65722626746869732E5F62696E644B6579626F6172644576656E747328292C746869732E24646174657069636B65';
wwv_flow_api.g_varchar2_table(26) := '722E6F6E28226D6F757365646F776E222C746869732E5F6F6E4D6F757365446F776E446174657069636B65722E62696E64287468697329292C746869732E24646174657069636B65722E6F6E28226D6F7573657570222C746869732E5F6F6E4D6F757365';
wwv_flow_api.g_varchar2_table(27) := '5570446174657069636B65722E62696E6428746869732929292C746869732E6F7074732E636C61737365732626746869732E24646174657069636B65722E616464436C61737328746869732E6F7074732E636C6173736573292C746869732E6F7074732E';
wwv_flow_api.g_varchar2_table(28) := '74696D657069636B6572262628746869732E74696D657069636B65723D6E657720652E666E2E646174657069636B65722E54696D657069636B657228746869732C746869732E6F707473292C746869732E5F62696E6454696D657069636B65724576656E';
wwv_flow_api.g_varchar2_table(29) := '74732829292C746869732E6F7074732E6F6E6C7954696D657069636B65722626746869732E24646174657069636B65722E616464436C61737328222D6F6E6C792D74696D657069636B65722D22292C746869732E76696577735B746869732E6375727265';
wwv_flow_api.g_varchar2_table(30) := '6E74566965775D3D6E657720652E666E2E646174657069636B65722E426F647928746869732C746869732E63757272656E74566965772C746869732E6F707473292C746869732E76696577735B746869732E63757272656E74566965775D2E73686F7728';
wwv_flow_api.g_varchar2_table(31) := '292C746869732E6E61763D6E657720652E666E2E646174657069636B65722E4E617669676174696F6E28746869732C746869732E6F707473292C746869732E766965773D746869732E63757272656E74566965772C746869732E24656C2E6F6E2822636C';
wwv_flow_api.g_varchar2_table(32) := '69636B43656C6C2E616470222C746869732E5F6F6E436C69636B43656C6C2E62696E64287468697329292C746869732E24646174657069636B65722E6F6E28226D6F757365656E746572222C222E646174657069636B65722D2D63656C6C222C74686973';
wwv_flow_api.g_varchar2_table(33) := '2E5F6F6E4D6F757365456E74657243656C6C2E62696E64287468697329292C746869732E24646174657069636B65722E6F6E28226D6F7573656C65617665222C222E646174657069636B65722D2D63656C6C222C746869732E5F6F6E4D6F7573654C6561';
wwv_flow_api.g_varchar2_table(34) := '766543656C6C2E62696E64287468697329292C746869732E696E697465643D21307D2C5F63726561746553686F7274437574733A66756E6374696F6E28297B746869732E6D696E446174653D746869732E6F7074732E6D696E446174653F746869732E6F';
wwv_flow_api.g_varchar2_table(35) := '7074732E6D696E446174653A6E65772044617465282D38363339393939393133366535292C746869732E6D6178446174653D746869732E6F7074732E6D6178446174653F746869732E6F7074732E6D6178446174653A6E65772044617465283836333939';
wwv_flow_api.g_varchar2_table(36) := '3939393133366535297D2C5F62696E644576656E74733A66756E6374696F6E28297B746869732E24656C2E6F6E28746869732E6F7074732E73686F774576656E742B222E616470222C746869732E5F6F6E53686F774576656E742E62696E642874686973';
wwv_flow_api.g_varchar2_table(37) := '29292C746869732E24656C2E6F6E28226D6F75736575702E616470222C746869732E5F6F6E4D6F7573655570456C2E62696E64287468697329292C746869732E24656C2E6F6E2822626C75722E616470222C746869732E5F6F6E426C75722E62696E6428';
wwv_flow_api.g_varchar2_table(38) := '7468697329292C746869732E24656C2E6F6E28226B657975702E616470222C746869732E5F6F6E4B6579557047656E6572616C2E62696E64287468697329292C652874292E6F6E2822726573697A652E616470222C746869732E5F6F6E526573697A652E';
wwv_flow_api.g_varchar2_table(39) := '62696E64287468697329292C652822626F647922292E6F6E28226D6F75736575702E616470222C746869732E5F6F6E4D6F7573655570426F64792E62696E64287468697329297D2C5F62696E644B6579626F6172644576656E74733A66756E6374696F6E';
wwv_flow_api.g_varchar2_table(40) := '28297B746869732E24656C2E6F6E28226B6579646F776E2E616470222C746869732E5F6F6E4B6579446F776E2E62696E64287468697329292C746869732E24656C2E6F6E28226B657975702E616470222C746869732E5F6F6E4B657955702E62696E6428';
wwv_flow_api.g_varchar2_table(41) := '7468697329292C746869732E24656C2E6F6E2822686F744B65792E616470222C746869732E5F6F6E486F744B65792E62696E64287468697329297D2C5F62696E6454696D657069636B65724576656E74733A66756E6374696F6E28297B746869732E2465';
wwv_flow_api.g_varchar2_table(42) := '6C2E6F6E282274696D654368616E67652E616470222C746869732E5F6F6E54696D654368616E67652E62696E64287468697329297D2C69735765656B656E643A66756E6374696F6E2874297B72657475726E2D31213D3D746869732E6F7074732E776565';
wwv_flow_api.g_varchar2_table(43) := '6B656E64732E696E6465784F662874297D2C5F646566696E654C6F63616C653A66756E6374696F6E2874297B22737472696E67223D3D747970656F6620743F28746869732E6C6F633D652E666E2E646174657069636B65722E6C616E67756167655B745D';
wwv_flow_api.g_varchar2_table(44) := '2C746869732E6C6F637C7C28636F6E736F6C652E7761726E282243616E27742066696E64206C616E6775616765205C22222B742B272220696E20446174657069636B65722E6C616E67756167652C2077696C6C207573652022656E2220696E7374656164';
wwv_flow_api.g_varchar2_table(45) := '27292C746869732E6C6F633D652E657874656E642821302C7B7D2C652E666E2E646174657069636B65722E6C616E67756167652E656E29292C746869732E6C6F633D652E657874656E642821302C7B7D2C652E666E2E646174657069636B65722E6C616E';
wwv_flow_api.g_varchar2_table(46) := '67756167652E656E2C652E666E2E646174657069636B65722E6C616E67756167655B745D29293A746869732E6C6F633D652E657874656E642821302C7B7D2C652E666E2E646174657069636B65722E6C616E67756167652E656E2C74292C746869732E6F';
wwv_flow_api.g_varchar2_table(47) := '7074732E746F64617942746E54657874262628746869732E6C6F632E746F6461793D746869732E6F7074732E746F64617942746E54657874292C746869732E6F7074732E64617465466F726D6174262628746869732E6C6F632E64617465466F726D6174';
wwv_flow_api.g_varchar2_table(48) := '3D746869732E6F7074732E64617465466F726D6174292C746869732E6F7074732E74696D65466F726D6174262628746869732E6C6F632E74696D65466F726D61743D746869732E6F7074732E74696D65466F726D6174292C2222213D3D746869732E6F70';
wwv_flow_api.g_varchar2_table(49) := '74732E6669727374446179262628746869732E6C6F632E66697273744461793D746869732E6F7074732E6669727374446179292C746869732E6F7074732E74696D657069636B6572262628746869732E6C6F632E64617465466F726D61743D5B74686973';
wwv_flow_api.g_varchar2_table(50) := '2E6C6F632E64617465466F726D61742C746869732E6C6F632E74696D65466F726D61745D2E6A6F696E28746869732E6F7074732E6461746554696D65536570617261746F7229292C746869732E6F7074732E6F6E6C7954696D657069636B657226262874';
wwv_flow_api.g_varchar2_table(51) := '6869732E6C6F632E64617465466F726D61743D746869732E6C6F632E74696D65466F726D6174293B76617220693D746869732E5F676574576F7264426F756E646172795265674578703B28746869732E6C6F632E74696D65466F726D61742E6D61746368';
wwv_flow_api.g_varchar2_table(52) := '2869282261612229297C7C746869732E6C6F632E74696D65466F726D61742E6D6174636828692822414122292929262628746869732E616D706D3D2130297D2C5F6275696C64446174657069636B657273436F6E7461696E65723A66756E6374696F6E28';
wwv_flow_api.g_varchar2_table(53) := '297B633D21302C732E617070656E6428273C64697620636C6173733D22646174657069636B6572732D636F6E7461696E6572222069643D22646174657069636B6572732D636F6E7461696E6572223E3C2F6469763E27292C613D65282223646174657069';
wwv_flow_api.g_varchar2_table(54) := '636B6572732D636F6E7461696E657222297D2C5F6275696C644261736548746D6C3A66756E6374696F6E28297B76617220742C693D6528273C64697620636C6173733D22646174657069636B65722D696E6C696E65223E27293B743D22494E505554223D';
wwv_flow_api.g_varchar2_table(55) := '3D746869732E656C2E6E6F64654E616D653F746869732E6F7074732E696E6C696E653F692E696E73657274416674657228746869732E24656C293A613A692E617070656E64546F28746869732E24656C292C746869732E24646174657069636B65723D65';
wwv_flow_api.g_varchar2_table(56) := '2864292E617070656E64546F2874292C746869732E24636F6E74656E743D6528222E646174657069636B65722D2D636F6E74656E74222C746869732E24646174657069636B6572292C746869732E246E61763D6528222E646174657069636B65722D2D6E';
wwv_flow_api.g_varchar2_table(57) := '6176222C746869732E24646174657069636B6572297D2C5F747269676765724F6E4368616E67653A66756E6374696F6E28297B69662821746869732E73656C656374656444617465732E6C656E677468297B69662822223D3D3D746869732E5F70726576';
wwv_flow_api.g_varchar2_table(58) := '4F6E53656C65637456616C75652972657475726E3B72657475726E20746869732E5F707265764F6E53656C65637456616C75653D22222C746869732E6F7074732E6F6E53656C6563742822222C22222C74686973297D76617220742C653D746869732E73';
wwv_flow_api.g_varchar2_table(59) := '656C656374656444617465732C693D6E2E6765745061727365644461746528655B305D292C733D746869732C613D6E6577204461746528692E796561722C692E6D6F6E74682C692E646174652C692E686F7572732C692E6D696E75746573293B743D652E';
wwv_flow_api.g_varchar2_table(60) := '6D61702866756E6374696F6E2874297B72657475726E20732E666F726D61744461746528732E6C6F632E64617465466F726D61742C74297D292E6A6F696E28746869732E6F7074732E6D756C7469706C654461746573536570617261746F72292C287468';
wwv_flow_api.g_varchar2_table(61) := '69732E6F7074732E6D756C7469706C6544617465737C7C746869732E6F7074732E72616E676529262628613D652E6D61702866756E6374696F6E2874297B76617220653D6E2E676574506172736564446174652874293B72657475726E206E6577204461';
wwv_flow_api.g_varchar2_table(62) := '746528652E796561722C652E6D6F6E74682C652E646174652C652E686F7572732C652E6D696E75746573297D29292C746869732E5F707265764F6E53656C65637456616C75653D742C746869732E6F7074732E6F6E53656C65637428742C612C74686973';
wwv_flow_api.g_varchar2_table(63) := '297D2C6E6578743A66756E6374696F6E28297B76617220743D746869732E706172736564446174652C653D746869732E6F7074733B73776974636828746869732E76696577297B636173652264617973223A746869732E646174653D6E65772044617465';
wwv_flow_api.g_varchar2_table(64) := '28742E796561722C742E6D6F6E74682B312C31292C652E6F6E4368616E67654D6F6E74682626652E6F6E4368616E67654D6F6E746828746869732E706172736564446174652E6D6F6E74682C746869732E706172736564446174652E79656172293B6272';
wwv_flow_api.g_varchar2_table(65) := '65616B3B63617365226D6F6E746873223A746869732E646174653D6E6577204461746528742E796561722B312C742E6D6F6E74682C31292C652E6F6E4368616E6765596561722626652E6F6E4368616E67655965617228746869732E7061727365644461';
wwv_flow_api.g_varchar2_table(66) := '74652E79656172293B627265616B3B63617365227965617273223A746869732E646174653D6E6577204461746528742E796561722B31302C302C31292C652E6F6E4368616E67654465636164652626652E6F6E4368616E67654465636164652874686973';
wwv_flow_api.g_varchar2_table(67) := '2E637572446563616465297D7D2C707265763A66756E6374696F6E28297B76617220743D746869732E706172736564446174652C653D746869732E6F7074733B73776974636828746869732E76696577297B636173652264617973223A746869732E6461';
wwv_flow_api.g_varchar2_table(68) := '74653D6E6577204461746528742E796561722C742E6D6F6E74682D312C31292C652E6F6E4368616E67654D6F6E74682626652E6F6E4368616E67654D6F6E746828746869732E706172736564446174652E6D6F6E74682C746869732E7061727365644461';
wwv_flow_api.g_varchar2_table(69) := '74652E79656172293B627265616B3B63617365226D6F6E746873223A746869732E646174653D6E6577204461746528742E796561722D312C742E6D6F6E74682C31292C652E6F6E4368616E6765596561722626652E6F6E4368616E676559656172287468';
wwv_flow_api.g_varchar2_table(70) := '69732E706172736564446174652E79656172293B627265616B3B63617365227965617273223A746869732E646174653D6E6577204461746528742E796561722D31302C302C31292C652E6F6E4368616E67654465636164652626652E6F6E4368616E6765';
wwv_flow_api.g_varchar2_table(71) := '44656361646528746869732E637572446563616465297D7D2C666F726D6174446174653A66756E6374696F6E28742C65297B653D657C7C746869732E646174653B76617220692C733D742C613D746869732E5F676574576F7264426F756E646172795265';
wwv_flow_api.g_varchar2_table(72) := '674578702C683D746869732E6C6F632C6F3D6E2E6765744C656164696E675A65726F4E756D2C723D6E2E6765744465636164652865292C633D6E2E676574506172736564446174652865292C643D632E66756C6C486F7572732C6C3D632E686F7572732C';
wwv_flow_api.g_varchar2_table(73) := '753D742E6D617463682861282261612229297C7C742E6D617463682861282241412229292C6D3D22616D222C703D746869732E5F7265706C616365723B73776974636828746869732E6F7074732E74696D657069636B65722626746869732E74696D6570';
wwv_flow_api.g_varchar2_table(74) := '69636B6572262675262628693D746869732E74696D657069636B65722E5F67657456616C6964486F75727346726F6D4461746528652C75292C643D6F28692E686F757273292C6C3D692E686F7572732C6D3D692E646179506572696F64292C2130297B63';
wwv_flow_api.g_varchar2_table(75) := '6173652F402F2E746573742873293A733D732E7265706C616365282F402F2C652E67657454696D652829293B636173652F61612F2E746573742873293A733D7028732C612822616122292C6D293B636173652F41412F2E746573742873293A733D702873';
wwv_flow_api.g_varchar2_table(76) := '2C612822414122292C6D2E746F5570706572436173652829293B636173652F64642F2E746573742873293A733D7028732C612822646422292C632E66756C6C44617465293B636173652F642F2E746573742873293A733D7028732C6128226422292C632E';
wwv_flow_api.g_varchar2_table(77) := '64617465293B636173652F44442F2E746573742873293A733D7028732C612822444422292C682E646179735B632E6461795D293B636173652F442F2E746573742873293A733D7028732C6128224422292C682E6461797353686F72745B632E6461795D29';
wwv_flow_api.g_varchar2_table(78) := '3B636173652F6D6D2F2E746573742873293A733D7028732C6128226D6D22292C632E66756C6C4D6F6E7468293B636173652F6D2F2E746573742873293A733D7028732C6128226D22292C632E6D6F6E74682B31293B636173652F4D4D2F2E746573742873';
wwv_flow_api.g_varchar2_table(79) := '293A733D7028732C6128224D4D22292C746869732E6C6F632E6D6F6E7468735B632E6D6F6E74685D293B636173652F4D2F2E746573742873293A733D7028732C6128224D22292C682E6D6F6E74687353686F72745B632E6D6F6E74685D293B636173652F';
wwv_flow_api.g_varchar2_table(80) := '69692F2E746573742873293A733D7028732C612822696922292C632E66756C6C4D696E75746573293B636173652F692F2E746573742873293A733D7028732C6128226922292C632E6D696E75746573293B636173652F68682F2E746573742873293A733D';
wwv_flow_api.g_varchar2_table(81) := '7028732C612822686822292C64293B636173652F682F2E746573742873293A733D7028732C6128226822292C6C293B636173652F797979792F2E746573742873293A733D7028732C6128227979797922292C632E79656172293B636173652F7979797931';
wwv_flow_api.g_varchar2_table(82) := '2F2E746573742873293A733D7028732C612822797979793122292C725B305D293B636173652F79797979322F2E746573742873293A733D7028732C612822797979793222292C725B315D293B636173652F79792F2E746573742873293A733D7028732C61';
wwv_flow_api.g_varchar2_table(83) := '2822797922292C632E796561722E746F537472696E6728292E736C696365282D3229297D72657475726E20737D2C5F7265706C616365723A66756E6374696F6E28742C652C69297B72657475726E20742E7265706C61636528652C66756E6374696F6E28';
wwv_flow_api.g_varchar2_table(84) := '742C652C732C61297B72657475726E20652B692B617D297D2C5F676574576F7264426F756E646172795265674578703A66756E6374696F6E2874297B76617220653D225C5C737C5C5C2E7C2D7C2F7C5C5C5C5C7C2C7C5C5C247C5C5C217C5C5C3F7C3A7C';
wwv_flow_api.g_varchar2_table(85) := '3B223B72657475726E206E6577205265674578702822285E7C3E7C222B652B222928222B742B222928247C3C7C222B652B2229222C226722297D2C73656C656374446174653A66756E6374696F6E2874297B76617220653D746869732C693D652E6F7074';
wwv_flow_api.g_varchar2_table(86) := '732C733D652E706172736564446174652C613D652E73656C656374656444617465732C683D612E6C656E6774682C6F3D22223B69662841727261792E697341727261792874292972657475726E20766F696420742E666F72456163682866756E6374696F';
wwv_flow_api.g_varchar2_table(87) := '6E2874297B652E73656C656374446174652874297D293B6966287420696E7374616E63656F662044617465297B696628746869732E6C61737453656C6563746564446174653D742C746869732E74696D657069636B65722626746869732E74696D657069';
wwv_flow_api.g_varchar2_table(88) := '636B65722E5F73657454696D652874292C652E5F74726967676572282273656C65637444617465222C74292C746869732E74696D657069636B6572262628742E736574486F75727328746869732E74696D657069636B65722E686F757273292C742E7365';
wwv_flow_api.g_varchar2_table(89) := '744D696E7574657328746869732E74696D657069636B65722E6D696E7574657329292C2264617973223D3D652E766965772626742E6765744D6F6E74682829213D732E6D6F6E74682626692E6D6F7665546F4F746865724D6F6E7468734F6E53656C6563';
wwv_flow_api.g_varchar2_table(90) := '742626286F3D6E6577204461746528742E67657446756C6C5965617228292C742E6765744D6F6E746828292C3129292C227965617273223D3D652E766965772626742E67657446756C6C596561722829213D732E796561722626692E6D6F7665546F4F74';
wwv_flow_api.g_varchar2_table(91) := '68657259656172734F6E53656C6563742626286F3D6E6577204461746528742E67657446756C6C5965617228292C302C3129292C6F262628652E73696C656E743D21302C652E646174653D6F2C652E73696C656E743D21312C652E6E61762E5F72656E64';
wwv_flow_api.g_varchar2_table(92) := '65722829292C692E6D756C7469706C654461746573262621692E72616E6765297B696628683D3D3D692E6D756C7469706C6544617465732972657475726E3B652E5F697353656C65637465642874297C7C652E73656C656374656444617465732E707573';
wwv_flow_api.g_varchar2_table(93) := '682874297D656C736520692E72616E67653F323D3D683F28652E73656C656374656444617465733D5B745D2C652E6D696E52616E67653D742C652E6D617852616E67653D2222293A313D3D683F28652E73656C656374656444617465732E707573682874';
wwv_flow_api.g_varchar2_table(94) := '292C652E6D617852616E67653F652E6D696E52616E67653D743A652E6D617852616E67653D742C6E2E62696767657228652E6D617852616E67652C652E6D696E52616E676529262628652E6D617852616E67653D652E6D696E52616E67652C652E6D696E';
wwv_flow_api.g_varchar2_table(95) := '52616E67653D74292C652E73656C656374656444617465733D5B652E6D696E52616E67652C652E6D617852616E67655D293A28652E73656C656374656444617465733D5B745D2C652E6D696E52616E67653D74293A652E73656C65637465644461746573';
wwv_flow_api.g_varchar2_table(96) := '3D5B745D3B652E5F736574496E70757456616C756528292C692E6F6E53656C6563742626652E5F747269676765724F6E4368616E676528292C692E6175746F436C6F7365262621746869732E74696D657069636B65724973416374697665262628692E6D';
wwv_flow_api.g_varchar2_table(97) := '756C7469706C6544617465737C7C692E72616E67653F692E72616E67652626323D3D652E73656C656374656444617465732E6C656E6774682626652E6869646528293A652E686964652829292C652E76696577735B746869732E63757272656E74566965';
wwv_flow_api.g_varchar2_table(98) := '775D2E5F72656E64657228297D7D2C72656D6F7665446174653A66756E6374696F6E2874297B76617220653D746869732E73656C656374656444617465732C693D746869733B72657475726E207420696E7374616E63656F6620446174653F652E736F6D';
wwv_flow_api.g_varchar2_table(99) := '652866756E6374696F6E28732C61297B72657475726E206E2E697353616D6528732C74293F28652E73706C69636528612C31292C692E73656C656374656444617465732E6C656E6774683F692E6C61737453656C6563746564446174653D692E73656C65';
wwv_flow_api.g_varchar2_table(100) := '6374656444617465735B692E73656C656374656444617465732E6C656E6774682D315D3A28692E6D696E52616E67653D22222C692E6D617852616E67653D22222C692E6C61737453656C6563746564446174653D2222292C692E76696577735B692E6375';
wwv_flow_api.g_varchar2_table(101) := '7272656E74566965775D2E5F72656E64657228292C692E5F736574496E70757456616C756528292C692E6F7074732E6F6E53656C6563742626692E5F747269676765724F6E4368616E676528292C2130293A766F696420307D293A766F696420307D2C74';
wwv_flow_api.g_varchar2_table(102) := '6F6461793A66756E6374696F6E28297B746869732E73696C656E743D21302C746869732E766965773D746869732E6F7074732E6D696E566965772C746869732E73696C656E743D21312C746869732E646174653D6E657720446174652C746869732E6F70';
wwv_flow_api.g_varchar2_table(103) := '74732E746F646179427574746F6E20696E7374616E63656F6620446174652626746869732E73656C6563744461746528746869732E6F7074732E746F646179427574746F6E297D2C636C6561723A66756E6374696F6E28297B746869732E73656C656374';
wwv_flow_api.g_varchar2_table(104) := '656444617465733D5B5D2C746869732E6D696E52616E67653D22222C746869732E6D617852616E67653D22222C746869732E76696577735B746869732E63757272656E74566965775D2E5F72656E64657228292C746869732E5F736574496E7075745661';
wwv_flow_api.g_varchar2_table(105) := '6C756528292C746869732E6F7074732E6F6E53656C6563742626746869732E5F747269676765724F6E4368616E676528297D2C7570646174653A66756E6374696F6E28742C69297B76617220733D617267756D656E74732E6C656E6774682C613D746869';
wwv_flow_api.g_varchar2_table(106) := '732E6C61737453656C6563746564446174653B72657475726E20323D3D733F746869732E6F7074735B745D3D693A313D3D732626226F626A656374223D3D747970656F662074262628746869732E6F7074733D652E657874656E642821302C746869732E';
wwv_flow_api.g_varchar2_table(107) := '6F7074732C7429292C746869732E5F63726561746553686F72744375747328292C746869732E5F73796E63576974684D696E4D6178446174657328292C746869732E5F646566696E654C6F63616C6528746869732E6F7074732E6C616E6775616765292C';
wwv_flow_api.g_varchar2_table(108) := '746869732E6E61762E5F616464427574746F6E7349664E65656428292C746869732E6F7074732E6F6E6C7954696D657069636B65727C7C746869732E6E61762E5F72656E64657228292C746869732E76696577735B746869732E63757272656E74566965';
wwv_flow_api.g_varchar2_table(109) := '775D2E5F72656E64657228292C746869732E656C4973496E707574262621746869732E6F7074732E696E6C696E65262628746869732E5F736574506F736974696F6E436C617373657328746869732E6F7074732E706F736974696F6E292C746869732E76';
wwv_flow_api.g_varchar2_table(110) := '697369626C652626746869732E736574506F736974696F6E28746869732E6F7074732E706F736974696F6E29292C746869732E6F7074732E636C61737365732626746869732E24646174657069636B65722E616464436C61737328746869732E6F707473';
wwv_flow_api.g_varchar2_table(111) := '2E636C6173736573292C746869732E6F7074732E6F6E6C7954696D657069636B65722626746869732E24646174657069636B65722E616464436C61737328222D6F6E6C792D74696D657069636B65722D22292C746869732E6F7074732E74696D65706963';
wwv_flow_api.g_varchar2_table(112) := '6B6572262628612626746869732E74696D657069636B65722E5F68616E646C65446174652861292C746869732E74696D657069636B65722E5F75706461746552616E67657328292C746869732E74696D657069636B65722E5F7570646174654375727265';
wwv_flow_api.g_varchar2_table(113) := '6E7454696D6528292C61262628612E736574486F75727328746869732E74696D657069636B65722E686F757273292C612E7365744D696E7574657328746869732E74696D657069636B65722E6D696E757465732929292C746869732E5F736574496E7075';
wwv_flow_api.g_varchar2_table(114) := '7456616C756528292C746869737D2C5F73796E63576974684D696E4D617844617465733A66756E6374696F6E28297B76617220743D746869732E646174652E67657454696D6528293B746869732E73696C656E743D21302C746869732E6D696E54696D65';
wwv_flow_api.g_varchar2_table(115) := '3E74262628746869732E646174653D746869732E6D696E44617465292C746869732E6D617854696D653C74262628746869732E646174653D746869732E6D617844617465292C746869732E73696C656E743D21317D2C5F697353656C65637465643A6675';
wwv_flow_api.g_varchar2_table(116) := '6E6374696F6E28742C65297B76617220693D21313B72657475726E20746869732E73656C656374656444617465732E736F6D652866756E6374696F6E2873297B72657475726E206E2E697353616D6528732C742C65293F28693D732C2130293A766F6964';
wwv_flow_api.g_varchar2_table(117) := '20307D292C697D2C5F736574496E70757456616C75653A66756E6374696F6E28297B76617220742C653D746869732C693D652E6F7074732C733D652E6C6F632E64617465466F726D61742C613D692E616C744669656C6444617465466F726D61742C6E3D';
wwv_flow_api.g_varchar2_table(118) := '652E73656C656374656444617465732E6D61702866756E6374696F6E2874297B72657475726E20652E666F726D61744461746528732C74297D293B692E616C744669656C642626652E24616C744669656C642E6C656E677468262628743D746869732E73';
wwv_flow_api.g_varchar2_table(119) := '656C656374656444617465732E6D61702866756E6374696F6E2874297B72657475726E20652E666F726D61744461746528612C74297D292C743D742E6A6F696E28746869732E6F7074732E6D756C7469706C654461746573536570617261746F72292C74';
wwv_flow_api.g_varchar2_table(120) := '6869732E24616C744669656C642E76616C287429292C6E3D6E2E6A6F696E28746869732E6F7074732E6D756C7469706C654461746573536570617261746F72292C746869732E24656C2E76616C286E297D2C5F6973496E52616E67653A66756E6374696F';
wwv_flow_api.g_varchar2_table(121) := '6E28742C65297B76617220693D742E67657454696D6528292C733D6E2E676574506172736564446174652874292C613D6E2E6765745061727365644461746528746869732E6D696E44617465292C683D6E2E676574506172736564446174652874686973';
wwv_flow_api.g_varchar2_table(122) := '2E6D617844617465292C6F3D6E6577204461746528732E796561722C732E6D6F6E74682C612E64617465292E67657454696D6528292C723D6E6577204461746528732E796561722C732E6D6F6E74682C682E64617465292E67657454696D6528292C633D';
wwv_flow_api.g_varchar2_table(123) := '7B6461793A693E3D746869732E6D696E54696D652626693C3D746869732E6D617854696D652C6D6F6E74683A6F3E3D746869732E6D696E54696D652626723C3D746869732E6D617854696D652C796561723A732E796561723E3D612E796561722626732E';
wwv_flow_api.g_varchar2_table(124) := '796561723C3D682E796561727D3B72657475726E20653F635B655D3A632E6461797D2C5F67657444696D656E73696F6E733A66756E6374696F6E2874297B76617220653D742E6F666673657428293B72657475726E7B77696474683A742E6F7574657257';
wwv_flow_api.g_varchar2_table(125) := '6964746828292C6865696768743A742E6F7574657248656967687428292C6C6566743A652E6C6566742C746F703A652E746F707D7D2C5F6765744461746546726F6D43656C6C3A66756E6374696F6E2874297B76617220653D746869732E706172736564';
wwv_flow_api.g_varchar2_table(126) := '446174652C733D742E6461746128227965617222297C7C652E796561722C613D742E6461746128226D6F6E746822293D3D693F652E6D6F6E74683A742E6461746128226D6F6E746822292C6E3D742E6461746128226461746522297C7C313B7265747572';
wwv_flow_api.g_varchar2_table(127) := '6E206E6577204461746528732C612C6E297D2C5F736574506F736974696F6E436C61737365733A66756E6374696F6E2874297B743D742E73706C697428222022293B76617220653D745B305D2C693D745B315D2C733D22646174657069636B6572202D22';
wwv_flow_api.g_varchar2_table(128) := '2B652B222D222B692B222D202D66726F6D2D222B652B222D223B746869732E76697369626C65262628732B3D222061637469766522292C746869732E24646174657069636B65722E72656D6F7665417474722822636C61737322292E616464436C617373';
wwv_flow_api.g_varchar2_table(129) := '2873297D2C736574506F736974696F6E3A66756E6374696F6E2874297B743D747C7C746869732E6F7074732E706F736974696F6E3B76617220652C692C733D746869732E5F67657444696D656E73696F6E7328746869732E24656C292C613D746869732E';
wwv_flow_api.g_varchar2_table(130) := '5F67657444696D656E73696F6E7328746869732E24646174657069636B6572292C6E3D742E73706C697428222022292C683D746869732E6F7074732E6F66667365742C6F3D6E5B305D2C723D6E5B315D3B737769746368286F297B6361736522746F7022';
wwv_flow_api.g_varchar2_table(131) := '3A653D732E746F702D612E6865696768742D683B627265616B3B63617365227269676874223A693D732E6C6566742B732E77696474682B683B627265616B3B6361736522626F74746F6D223A653D732E746F702B732E6865696768742B683B627265616B';
wwv_flow_api.g_varchar2_table(132) := '3B63617365226C656674223A693D732E6C6566742D612E77696474682D687D7377697463682872297B6361736522746F70223A653D732E746F703B627265616B3B63617365227269676874223A693D732E6C6566742B732E77696474682D612E77696474';
wwv_flow_api.g_varchar2_table(133) := '683B627265616B3B6361736522626F74746F6D223A653D732E746F702B732E6865696768742D612E6865696768743B627265616B3B63617365226C656674223A693D732E6C6566743B627265616B3B636173652263656E746572223A2F6C6566747C7269';
wwv_flow_api.g_varchar2_table(134) := '6768742F2E74657374286F293F653D732E746F702B732E6865696768742F322D612E6865696768742F323A693D732E6C6566742B732E77696474682F322D612E77696474682F327D746869732E24646174657069636B65722E637373287B6C6566743A69';
wwv_flow_api.g_varchar2_table(135) := '2C746F703A657D297D2C73686F773A66756E6374696F6E28297B76617220743D746869732E6F7074732E6F6E53686F773B746869732E736574506F736974696F6E28746869732E6F7074732E706F736974696F6E292C746869732E24646174657069636B';
wwv_flow_api.g_varchar2_table(136) := '65722E616464436C617373282261637469766522292C746869732E76697369626C653D21302C742626746869732E5F62696E64566973696F6E4576656E74732874297D2C686964653A66756E6374696F6E28297B76617220743D746869732E6F7074732E';
wwv_flow_api.g_varchar2_table(137) := '6F6E486964653B746869732E24646174657069636B65722E72656D6F7665436C617373282261637469766522292E637373287B6C6566743A222D3130303030307078227D292C746869732E666F63757365643D22222C746869732E6B6579733D5B5D2C74';
wwv_flow_api.g_varchar2_table(138) := '6869732E696E466F6375733D21312C746869732E76697369626C653D21312C746869732E24656C2E626C757228292C742626746869732E5F62696E64566973696F6E4576656E74732874297D2C646F776E3A66756E6374696F6E2874297B746869732E5F';
wwv_flow_api.g_varchar2_table(139) := '6368616E67655669657728742C22646F776E22297D2C75703A66756E6374696F6E2874297B746869732E5F6368616E67655669657728742C22757022297D2C5F62696E64566973696F6E4576656E74733A66756E6374696F6E2874297B746869732E2464';
wwv_flow_api.g_varchar2_table(140) := '6174657069636B65722E6F666628227472616E736974696F6E656E642E647022292C7428746869732C2131292C746869732E24646174657069636B65722E6F6E6528227472616E736974696F6E656E642E6470222C742E62696E6428746869732C746869';
wwv_flow_api.g_varchar2_table(141) := '732C213029297D2C5F6368616E6765566965773A66756E6374696F6E28742C65297B743D747C7C746869732E666F63757365647C7C746869732E646174653B76617220693D227570223D3D653F746869732E76696577496E6465782B313A746869732E76';
wwv_flow_api.g_varchar2_table(142) := '696577496E6465782D313B693E32262628693D32292C303E69262628693D30292C746869732E73696C656E743D21302C746869732E646174653D6E6577204461746528742E67657446756C6C5965617228292C742E6765744D6F6E746828292C31292C74';
wwv_flow_api.g_varchar2_table(143) := '6869732E73696C656E743D21312C746869732E766965773D746869732E76696577496E64657865735B695D7D2C5F68616E646C65486F744B65793A66756E6374696F6E2874297B76617220652C692C732C613D6E2E676574506172736564446174652874';
wwv_flow_api.g_varchar2_table(144) := '6869732E5F676574466F6375736564446174652829292C683D746869732E6F7074732C6F3D21312C723D21312C633D21312C643D612E796561722C6C3D612E6D6F6E74682C753D612E646174653B7377697463682874297B63617365226374726C526967';
wwv_flow_api.g_varchar2_table(145) := '6874223A63617365226374726C5570223A6C2B3D312C6F3D21303B627265616B3B63617365226374726C4C656674223A63617365226374726C446F776E223A6C2D3D312C6F3D21303B627265616B3B636173652273686966745269676874223A63617365';
wwv_flow_api.g_varchar2_table(146) := '2273686966745570223A723D21302C642B3D313B627265616B3B636173652273686966744C656674223A63617365227368696674446F776E223A723D21302C642D3D313B627265616B3B6361736522616C745269676874223A6361736522616C74557022';
wwv_flow_api.g_varchar2_table(147) := '3A633D21302C642B3D31303B627265616B3B6361736522616C744C656674223A6361736522616C74446F776E223A633D21302C642D3D31303B627265616B3B63617365226374726C53686966745570223A746869732E757028297D733D6E2E6765744461';
wwv_flow_api.g_varchar2_table(148) := '7973436F756E74286E6577204461746528642C6C29292C693D6E6577204461746528642C6C2C75292C753E73262628753D73292C692E67657454696D6528293C746869732E6D696E54696D653F693D746869732E6D696E446174653A692E67657454696D';
wwv_flow_api.g_varchar2_table(149) := '6528293E746869732E6D617854696D65262628693D746869732E6D617844617465292C746869732E666F63757365643D692C653D6E2E676574506172736564446174652869292C6F2626682E6F6E4368616E67654D6F6E74682626682E6F6E4368616E67';
wwv_flow_api.g_varchar2_table(150) := '654D6F6E746828652E6D6F6E74682C652E79656172292C722626682E6F6E4368616E6765596561722626682E6F6E4368616E67655965617228652E79656172292C632626682E6F6E4368616E67654465636164652626682E6F6E4368616E676544656361';
wwv_flow_api.g_varchar2_table(151) := '646528746869732E637572446563616465297D2C5F72656769737465724B65793A66756E6374696F6E2874297B76617220653D746869732E6B6579732E736F6D652866756E6374696F6E2865297B72657475726E20653D3D747D293B657C7C746869732E';
wwv_flow_api.g_varchar2_table(152) := '6B6579732E707573682874297D2C5F756E52656769737465724B65793A66756E6374696F6E2874297B76617220653D746869732E6B6579732E696E6465784F662874293B746869732E6B6579732E73706C69636528652C31297D2C5F6973486F744B6579';
wwv_flow_api.g_varchar2_table(153) := '507265737365643A66756E6374696F6E28297B76617220742C653D21312C693D746869732C733D746869732E6B6579732E736F727428293B666F7228766172206120696E207529743D755B615D2C732E6C656E6774683D3D742E6C656E6774682626742E';
wwv_flow_api.g_varchar2_table(154) := '65766572792866756E6374696F6E28742C65297B72657475726E20743D3D735B655D7D29262628692E5F747269676765722822686F744B6579222C61292C653D2130293B72657475726E20657D2C5F747269676765723A66756E6374696F6E28742C6529';
wwv_flow_api.g_varchar2_table(155) := '7B746869732E24656C2E7472696767657228742C65297D2C5F666F6375734E65787443656C6C3A66756E6374696F6E28742C65297B653D657C7C746869732E63656C6C547970653B76617220693D6E2E6765745061727365644461746528746869732E5F';
wwv_flow_api.g_varchar2_table(156) := '676574466F6375736564446174652829292C733D692E796561722C613D692E6D6F6E74682C683D692E646174653B69662821746869732E5F6973486F744B6579507265737365642829297B7377697463682874297B636173652033373A22646179223D3D';
wwv_flow_api.g_varchar2_table(157) := '653F682D3D313A22222C226D6F6E7468223D3D653F612D3D313A22222C2279656172223D3D653F732D3D313A22223B627265616B3B636173652033383A22646179223D3D653F682D3D373A22222C226D6F6E7468223D3D653F612D3D333A22222C227965';
wwv_flow_api.g_varchar2_table(158) := '6172223D3D653F732D3D343A22223B627265616B3B636173652033393A22646179223D3D653F682B3D313A22222C226D6F6E7468223D3D653F612B3D313A22222C2279656172223D3D653F732B3D313A22223B627265616B3B636173652034303A226461';
wwv_flow_api.g_varchar2_table(159) := '79223D3D653F682B3D373A22222C226D6F6E7468223D3D653F612B3D333A22222C2279656172223D3D653F732B3D343A22227D766172206F3D6E6577204461746528732C612C68293B6F2E67657454696D6528293C746869732E6D696E54696D653F6F3D';
wwv_flow_api.g_varchar2_table(160) := '746869732E6D696E446174653A6F2E67657454696D6528293E746869732E6D617854696D652626286F3D746869732E6D617844617465292C746869732E666F63757365643D6F7D7D2C5F676574466F6375736564446174653A66756E6374696F6E28297B';
wwv_flow_api.g_varchar2_table(161) := '76617220743D746869732E666F63757365647C7C746869732E73656C656374656444617465735B746869732E73656C656374656444617465732E6C656E6774682D315D2C653D746869732E706172736564446174653B6966282174297377697463682874';
wwv_flow_api.g_varchar2_table(162) := '6869732E76696577297B636173652264617973223A743D6E6577204461746528652E796561722C652E6D6F6E74682C286E65772044617465292E676574446174652829293B627265616B3B63617365226D6F6E746873223A743D6E657720446174652865';
wwv_flow_api.g_varchar2_table(163) := '2E796561722C652E6D6F6E74682C31293B627265616B3B63617365227965617273223A743D6E6577204461746528652E796561722C302C31297D72657475726E20747D2C5F67657443656C6C3A66756E6374696F6E28742C69297B693D697C7C74686973';
wwv_flow_api.g_varchar2_table(164) := '2E63656C6C547970653B76617220732C613D6E2E676574506172736564446174652874292C683D272E646174657069636B65722D2D63656C6C5B646174612D796561723D22272B612E796561722B27225D273B7377697463682869297B63617365226D6F';
wwv_flow_api.g_varchar2_table(165) := '6E7468223A683D275B646174612D6D6F6E74683D22272B612E6D6F6E74682B27225D273B627265616B3B6361736522646179223A682B3D275B646174612D6D6F6E74683D22272B612E6D6F6E74682B27225D5B646174612D646174653D22272B612E6461';
wwv_flow_api.g_varchar2_table(166) := '74652B27225D277D72657475726E20733D746869732E76696577735B746869732E63757272656E74566965775D2E24656C2E66696E642868292C732E6C656E6774683F733A65282222297D2C64657374726F793A66756E6374696F6E28297B7661722074';
wwv_flow_api.g_varchar2_table(167) := '3D746869733B742E24656C2E6F666628222E61647022292E646174612822646174657069636B6572222C2222292C742E73656C656374656444617465733D5B5D2C742E666F63757365643D22222C742E76696577733D7B7D2C742E6B6579733D5B5D2C74';
wwv_flow_api.g_varchar2_table(168) := '2E6D696E52616E67653D22222C742E6D617852616E67653D22222C742E6F7074732E696E6C696E657C7C21742E656C4973496E7075743F742E24646174657069636B65722E636C6F7365737428222E646174657069636B65722D696E6C696E6522292E72';
wwv_flow_api.g_varchar2_table(169) := '656D6F766528293A742E24646174657069636B65722E72656D6F766528297D2C5F68616E646C65416C726561647953656C656374656444617465733A66756E6374696F6E28742C65297B746869732E6F7074732E72616E67653F746869732E6F7074732E';
wwv_flow_api.g_varchar2_table(170) := '746F67676C6553656C65637465643F746869732E72656D6F7665446174652865293A32213D746869732E73656C656374656444617465732E6C656E6774682626746869732E5F747269676765722822636C69636B43656C6C222C65293A746869732E6F70';
wwv_flow_api.g_varchar2_table(171) := '74732E746F67676C6553656C65637465642626746869732E72656D6F7665446174652865292C746869732E6F7074732E746F67676C6553656C65637465647C7C28746869732E6C61737453656C6563746564446174653D742C746869732E6F7074732E74';
wwv_flow_api.g_varchar2_table(172) := '696D657069636B6572262628746869732E74696D657069636B65722E5F73657454696D652874292C746869732E74696D657069636B65722E757064617465282929297D2C5F6F6E53686F774576656E743A66756E6374696F6E28297B746869732E766973';
wwv_flow_api.g_varchar2_table(173) := '69626C657C7C746869732E73686F7728297D2C5F6F6E426C75723A66756E6374696F6E28297B21746869732E696E466F6375732626746869732E76697369626C652626746869732E6869646528297D2C5F6F6E4D6F757365446F776E446174657069636B';
wwv_flow_api.g_varchar2_table(174) := '65723A66756E6374696F6E28297B746869732E696E466F6375733D21307D2C5F6F6E4D6F7573655570446174657069636B65723A66756E6374696F6E2874297B746869732E696E466F6375733D21312C742E6F726967696E616C4576656E742E696E466F';
wwv_flow_api.g_varchar2_table(175) := '6375733D21302C742E6F726967696E616C4576656E742E74696D657069636B6572466F6375737C7C746869732E24656C2E666F63757328297D2C5F6F6E4B6579557047656E6572616C3A66756E6374696F6E28297B76617220743D746869732E24656C2E';
wwv_flow_api.g_varchar2_table(176) := '76616C28293B747C7C746869732E636C65617228297D2C5F6F6E526573697A653A66756E6374696F6E28297B746869732E76697369626C652626746869732E736574506F736974696F6E28297D2C5F6F6E4D6F7573655570426F64793A66756E6374696F';
wwv_flow_api.g_varchar2_table(177) := '6E2874297B742E6F726967696E616C4576656E742E696E466F6375737C7C746869732E76697369626C65262621746869732E696E466F6375732626746869732E6869646528297D2C5F6F6E4D6F7573655570456C3A66756E6374696F6E2874297B742E6F';
wwv_flow_api.g_varchar2_table(178) := '726967696E616C4576656E742E696E466F6375733D21302C73657454696D656F757428746869732E5F6F6E4B6579557047656E6572616C2E62696E642874686973292C34297D2C5F6F6E4B6579446F776E3A66756E6374696F6E2874297B76617220653D';
wwv_flow_api.g_varchar2_table(179) := '742E77686963683B696628746869732E5F72656769737465724B65792865292C653E3D3337262634303E3D65262628742E70726576656E7444656661756C7428292C746869732E5F666F6375734E65787443656C6C286529292C31333D3D652626746869';
wwv_flow_api.g_varchar2_table(180) := '732E666F6375736564297B696628746869732E5F67657443656C6C28746869732E666F6375736564292E686173436C61737328222D64697361626C65642D22292972657475726E3B696628746869732E76696577213D746869732E6F7074732E6D696E56';
wwv_flow_api.g_varchar2_table(181) := '69657729746869732E646F776E28293B656C73657B76617220693D746869732E5F697353656C656374656428746869732E666F63757365642C746869732E63656C6C54797065293B69662821692972657475726E20746869732E74696D657069636B6572';
wwv_flow_api.g_varchar2_table(182) := '262628746869732E666F63757365642E736574486F75727328746869732E74696D657069636B65722E686F757273292C746869732E666F63757365642E7365744D696E7574657328746869732E74696D657069636B65722E6D696E7574657329292C766F';
wwv_flow_api.g_varchar2_table(183) := '696420746869732E73656C6563744461746528746869732E666F6375736564293B746869732E5F68616E646C65416C726561647953656C6563746564446174657328692C746869732E666F6375736564297D7D32373D3D652626746869732E6869646528';
wwv_flow_api.g_varchar2_table(184) := '297D2C5F6F6E4B657955703A66756E6374696F6E2874297B76617220653D742E77686963683B746869732E5F756E52656769737465724B65792865297D2C5F6F6E486F744B65793A66756E6374696F6E28742C65297B746869732E5F68616E646C65486F';
wwv_flow_api.g_varchar2_table(185) := '744B65792865297D2C5F6F6E4D6F757365456E74657243656C6C3A66756E6374696F6E2874297B76617220693D6528742E746172676574292E636C6F7365737428222E646174657069636B65722D2D63656C6C22292C733D746869732E5F676574446174';
wwv_flow_api.g_varchar2_table(186) := '6546726F6D43656C6C2869293B746869732E73696C656E743D21302C746869732E666F6375736564262628746869732E666F63757365643D2222292C692E616464436C61737328222D666F6375732D22292C746869732E666F63757365643D732C746869';
wwv_flow_api.g_varchar2_table(187) := '732E73696C656E743D21312C746869732E6F7074732E72616E67652626313D3D746869732E73656C656374656444617465732E6C656E677468262628746869732E6D696E52616E67653D746869732E73656C656374656444617465735B305D2C74686973';
wwv_flow_api.g_varchar2_table(188) := '2E6D617852616E67653D22222C6E2E6C65737328746869732E6D696E52616E67652C746869732E666F637573656429262628746869732E6D617852616E67653D746869732E6D696E52616E67652C746869732E6D696E52616E67653D2222292C74686973';
wwv_flow_api.g_varchar2_table(189) := '2E76696577735B746869732E63757272656E74566965775D2E5F7570646174652829297D2C5F6F6E4D6F7573654C6561766543656C6C3A66756E6374696F6E2874297B76617220693D6528742E746172676574292E636C6F7365737428222E6461746570';
wwv_flow_api.g_varchar2_table(190) := '69636B65722D2D63656C6C22293B692E72656D6F7665436C61737328222D666F6375732D22292C746869732E73696C656E743D21302C746869732E666F63757365643D22222C746869732E73696C656E743D21317D2C5F6F6E54696D654368616E67653A';
wwv_flow_api.g_varchar2_table(191) := '66756E6374696F6E28742C652C69297B76617220733D6E657720446174652C613D746869732E73656C656374656444617465732C6E3D21313B612E6C656E6774682626286E3D21302C733D746869732E6C61737453656C656374656444617465292C732E';
wwv_flow_api.g_varchar2_table(192) := '736574486F7572732865292C732E7365744D696E757465732869292C6E7C7C746869732E5F67657443656C6C2873292E686173436C61737328222D64697361626C65642D22293F28746869732E5F736574496E70757456616C756528292C746869732E6F';
wwv_flow_api.g_varchar2_table(193) := '7074732E6F6E53656C6563742626746869732E5F747269676765724F6E4368616E67652829293A746869732E73656C656374446174652873297D2C5F6F6E436C69636B43656C6C3A66756E6374696F6E28742C65297B746869732E74696D657069636B65';
wwv_flow_api.g_varchar2_table(194) := '72262628652E736574486F75727328746869732E74696D657069636B65722E686F757273292C652E7365744D696E7574657328746869732E74696D657069636B65722E6D696E7574657329292C746869732E73656C656374446174652865297D2C736574';
wwv_flow_api.g_varchar2_table(195) := '20666F63757365642874297B69662821742626746869732E666F6375736564297B76617220653D746869732E5F67657443656C6C28746869732E666F6375736564293B652E6C656E6774682626652E72656D6F7665436C61737328222D666F6375732D22';
wwv_flow_api.g_varchar2_table(196) := '297D746869732E5F666F63757365643D742C746869732E6F7074732E72616E67652626313D3D746869732E73656C656374656444617465732E6C656E677468262628746869732E6D696E52616E67653D746869732E73656C656374656444617465735B30';
wwv_flow_api.g_varchar2_table(197) := '5D2C746869732E6D617852616E67653D22222C6E2E6C65737328746869732E6D696E52616E67652C746869732E5F666F637573656429262628746869732E6D617852616E67653D746869732E6D696E52616E67652C746869732E6D696E52616E67653D22';
wwv_flow_api.g_varchar2_table(198) := '2229292C746869732E73696C656E747C7C28746869732E646174653D74297D2C67657420666F637573656428297B72657475726E20746869732E5F666F63757365647D2C676574207061727365644461746528297B72657475726E206E2E676574506172';
wwv_flow_api.g_varchar2_table(199) := '7365644461746528746869732E64617465297D2C73657420646174652874297B72657475726E207420696E7374616E63656F6620446174653F28746869732E63757272656E74446174653D742C746869732E696E69746564262621746869732E73696C65';
wwv_flow_api.g_varchar2_table(200) := '6E74262628746869732E76696577735B746869732E766965775D2E5F72656E64657228292C746869732E6E61762E5F72656E64657228292C746869732E76697369626C652626746869732E656C4973496E7075742626746869732E736574506F73697469';
wwv_flow_api.g_varchar2_table(201) := '6F6E2829292C74293A766F696420307D2C676574206461746528297B72657475726E20746869732E63757272656E74446174657D2C73657420766965772874297B72657475726E20746869732E76696577496E6465783D746869732E76696577496E6465';
wwv_flow_api.g_varchar2_table(202) := '7865732E696E6465784F662874292C746869732E76696577496E6465783C303F766F696420303A28746869732E70726576566965773D746869732E63757272656E74566965772C746869732E63757272656E74566965773D742C746869732E696E697465';
wwv_flow_api.g_varchar2_table(203) := '64262628746869732E76696577735B745D3F746869732E76696577735B745D2E5F72656E64657228293A746869732E76696577735B745D3D6E657720652E666E2E646174657069636B65722E426F647928746869732C742C746869732E6F707473292C74';
wwv_flow_api.g_varchar2_table(204) := '6869732E76696577735B746869732E70726576566965775D2E6869646528292C746869732E76696577735B745D2E73686F7728292C746869732E6E61762E5F72656E64657228292C746869732E6F7074732E6F6E4368616E676556696577262674686973';
wwv_flow_api.g_varchar2_table(205) := '2E6F7074732E6F6E4368616E6765566965772874292C746869732E656C4973496E7075742626746869732E76697369626C652626746869732E736574506F736974696F6E2829292C74297D2C676574207669657728297B72657475726E20746869732E63';
wwv_flow_api.g_varchar2_table(206) := '757272656E74566965777D2C6765742063656C6C5479706528297B72657475726E20746869732E766965772E737562737472696E6728302C746869732E766965772E6C656E6774682D31297D2C676574206D696E54696D6528297B76617220743D6E2E67';
wwv_flow_api.g_varchar2_table(207) := '65745061727365644461746528746869732E6D696E44617465293B72657475726E206E6577204461746528742E796561722C742E6D6F6E74682C742E64617465292E67657454696D6528297D2C676574206D617854696D6528297B76617220743D6E2E67';
wwv_flow_api.g_varchar2_table(208) := '65745061727365644461746528746869732E6D617844617465293B72657475726E206E6577204461746528742E796561722C742E6D6F6E74682C742E64617465292E67657454696D6528297D2C6765742063757244656361646528297B72657475726E20';
wwv_flow_api.g_varchar2_table(209) := '6E2E67657444656361646528746869732E64617465297D7D2C6E2E67657444617973436F756E743D66756E6374696F6E2874297B72657475726E206E6577204461746528742E67657446756C6C5965617228292C742E6765744D6F6E746828292B312C30';
wwv_flow_api.g_varchar2_table(210) := '292E6765744461746528297D2C6E2E676574506172736564446174653D66756E6374696F6E2874297B72657475726E7B796561723A742E67657446756C6C5965617228292C6D6F6E74683A742E6765744D6F6E746828292C66756C6C4D6F6E74683A742E';
wwv_flow_api.g_varchar2_table(211) := '6765744D6F6E746828292B313C31303F2230222B28742E6765744D6F6E746828292B31293A742E6765744D6F6E746828292B312C646174653A742E6765744461746528292C66756C6C446174653A742E6765744461746528293C31303F2230222B742E67';
wwv_flow_api.g_varchar2_table(212) := '65744461746528293A742E6765744461746528292C6461793A742E67657444617928292C686F7572733A742E676574486F75727328292C66756C6C486F7572733A742E676574486F75727328293C31303F2230222B742E676574486F75727328293A742E';
wwv_flow_api.g_varchar2_table(213) := '676574486F75727328292C6D696E757465733A742E6765744D696E7574657328292C66756C6C4D696E757465733A742E6765744D696E7574657328293C31303F2230222B742E6765744D696E7574657328293A742E6765744D696E7574657328297D7D2C';
wwv_flow_api.g_varchar2_table(214) := '6E2E6765744465636164653D66756E6374696F6E2874297B76617220653D31302A4D6174682E666C6F6F7228742E67657446756C6C5965617228292F3130293B72657475726E5B652C652B395D7D2C6E2E74656D706C6174653D66756E6374696F6E2874';
wwv_flow_api.g_varchar2_table(215) := '2C65297B72657475726E20742E7265706C616365282F235C7B285B5C775D2B295C7D2F672C66756E6374696F6E28742C69297B72657475726E20655B695D7C7C303D3D3D655B695D3F655B695D3A766F696420307D297D2C6E2E697353616D653D66756E';
wwv_flow_api.g_varchar2_table(216) := '6374696F6E28742C652C69297B69662821747C7C21652972657475726E21313B76617220733D6E2E676574506172736564446174652874292C613D6E2E676574506172736564446174652865292C683D693F693A22646179222C6F3D7B6461793A732E64';
wwv_flow_api.g_varchar2_table(217) := '6174653D3D612E646174652626732E6D6F6E74683D3D612E6D6F6E74682626732E796561723D3D612E796561722C6D6F6E74683A732E6D6F6E74683D3D612E6D6F6E74682626732E796561723D3D612E796561722C796561723A732E796561723D3D612E';
wwv_flow_api.g_varchar2_table(218) := '796561727D3B72657475726E206F5B685D7D2C6E2E6C6573733D66756E6374696F6E28742C65297B72657475726E20742626653F652E67657454696D6528293C742E67657454696D6528293A21317D2C6E2E6269676765723D66756E6374696F6E28742C';
wwv_flow_api.g_varchar2_table(219) := '65297B72657475726E20742626653F652E67657454696D6528293E742E67657454696D6528293A21317D2C6E2E6765744C656164696E675A65726F4E756D3D66756E6374696F6E2874297B72657475726E207061727365496E742874293C31303F223022';
wwv_flow_api.g_varchar2_table(220) := '2B743A747D2C6E2E726573657454696D653D66756E6374696F6E2874297B72657475726E226F626A656374223D3D747970656F6620743F28743D6E2E676574506172736564446174652874292C6E6577204461746528742E796561722C742E6D6F6E7468';
wwv_flow_api.g_varchar2_table(221) := '2C742E6461746529293A766F696420307D2C652E666E2E646174657069636B65723D66756E6374696F6E2874297B72657475726E20746869732E656163682866756E6374696F6E28297B696628652E6461746128746869732C6F29297B76617220693D65';
wwv_flow_api.g_varchar2_table(222) := '2E6461746128746869732C6F293B692E6F7074733D652E657874656E642821302C692E6F7074732C74292C692E75706461746528297D656C736520652E6461746128746869732C6F2C6E6577206D28746869732C7429297D297D2C652E666E2E64617465';
wwv_flow_api.g_varchar2_table(223) := '7069636B65722E436F6E7374727563746F723D6D2C652E666E2E646174657069636B65722E6C616E67756167653D7B656E3A7B646179733A5B2253756E646179222C224D6F6E646179222C2254756573646179222C225765646E6573646179222C225468';
wwv_flow_api.g_varchar2_table(224) := '757273646179222C22467269646179222C225361747572646179225D2C6461797353686F72743A5B2253756E222C224D6F6E222C22547565222C22576564222C22546875222C22467269222C22536174225D2C646179734D696E3A5B225375222C224D6F';
wwv_flow_api.g_varchar2_table(225) := '222C225475222C225765222C225468222C224672222C225361225D2C6D6F6E7468733A5B224A616E75617279222C224665627275617279222C224D61726368222C22417072696C222C224D6179222C224A756E65222C224A756C79222C22417567757374';
wwv_flow_api.g_varchar2_table(226) := '222C2253657074656D626572222C224F63746F626572222C224E6F76656D626572222C22446563656D626572225D2C6D6F6E74687353686F72743A5B224A616E222C22466562222C224D6172222C22417072222C224D6179222C224A756E222C224A756C';
wwv_flow_api.g_varchar2_table(227) := '222C22417567222C22536570222C224F6374222C224E6F76222C22446563225D2C746F6461793A22546F646179222C636C6561723A22436C656172222C64617465466F726D61743A226D6D2F64642F79797979222C74696D65466F726D61743A2268683A';
wwv_flow_api.g_varchar2_table(228) := '6969206161222C66697273744461793A307D7D2C652866756E6374696F6E28297B652872292E646174657069636B657228297D297D28292C66756E6374696F6E28297B76617220743D7B646179733A273C64697620636C6173733D22646174657069636B';
wwv_flow_api.g_varchar2_table(229) := '65722D2D6461797320646174657069636B65722D2D626F6479223E3C64697620636C6173733D22646174657069636B65722D2D646179732D6E616D6573223E3C2F6469763E3C64697620636C6173733D22646174657069636B65722D2D63656C6C732064';
wwv_flow_api.g_varchar2_table(230) := '6174657069636B65722D2D63656C6C732D64617973223E3C2F6469763E3C2F6469763E272C6D6F6E7468733A273C64697620636C6173733D22646174657069636B65722D2D6D6F6E74687320646174657069636B65722D2D626F6479223E3C6469762063';
wwv_flow_api.g_varchar2_table(231) := '6C6173733D22646174657069636B65722D2D63656C6C7320646174657069636B65722D2D63656C6C732D6D6F6E746873223E3C2F6469763E3C2F6469763E272C79656172733A273C64697620636C6173733D22646174657069636B65722D2D7965617273';
wwv_flow_api.g_varchar2_table(232) := '20646174657069636B65722D2D626F6479223E3C64697620636C6173733D22646174657069636B65722D2D63656C6C7320646174657069636B65722D2D63656C6C732D7965617273223E3C2F6469763E3C2F6469763E277D2C733D652E666E2E64617465';
wwv_flow_api.g_varchar2_table(233) := '7069636B65722C613D732E436F6E7374727563746F723B732E426F64793D66756E6374696F6E28742C692C73297B746869732E643D742C746869732E747970653D692C746869732E6F7074733D732C746869732E24656C3D65282222292C746869732E6F';
wwv_flow_api.g_varchar2_table(234) := '7074732E6F6E6C7954696D657069636B65727C7C746869732E696E697428297D2C732E426F64792E70726F746F747970653D7B696E69743A66756E6374696F6E28297B746869732E5F6275696C644261736548746D6C28292C746869732E5F72656E6465';
wwv_flow_api.g_varchar2_table(235) := '7228292C746869732E5F62696E644576656E747328297D2C5F62696E644576656E74733A66756E6374696F6E28297B746869732E24656C2E6F6E2822636C69636B222C222E646174657069636B65722D2D63656C6C222C652E70726F787928746869732E';
wwv_flow_api.g_varchar2_table(236) := '5F6F6E436C69636B43656C6C2C7468697329297D2C5F6275696C644261736548746D6C3A66756E6374696F6E28297B746869732E24656C3D6528745B746869732E747970655D292E617070656E64546F28746869732E642E24636F6E74656E74292C7468';
wwv_flow_api.g_varchar2_table(237) := '69732E246E616D65733D6528222E646174657069636B65722D2D646179732D6E616D6573222C746869732E24656C292C746869732E2463656C6C733D6528222E646174657069636B65722D2D63656C6C73222C746869732E24656C297D2C5F6765744461';
wwv_flow_api.g_varchar2_table(238) := '794E616D657348746D6C3A66756E6374696F6E28742C652C732C61297B72657475726E20653D65213D693F653A742C733D733F733A22222C613D61213D693F613A302C613E373F733A373D3D653F746869732E5F6765744461794E616D657348746D6C28';
wwv_flow_api.g_varchar2_table(239) := '742C302C732C2B2B61293A28732B3D273C64697620636C6173733D22646174657069636B65722D2D6461792D6E616D65272B28746869732E642E69735765656B656E642865293F22202D7765656B656E642D223A2222292B27223E272B746869732E642E';
wwv_flow_api.g_varchar2_table(240) := '6C6F632E646179734D696E5B655D2B223C2F6469763E222C746869732E5F6765744461794E616D657348746D6C28742C2B2B652C732C2B2B6129297D2C5F67657443656C6C436F6E74656E74733A66756E6374696F6E28742C65297B76617220693D2264';
wwv_flow_api.g_varchar2_table(241) := '6174657069636B65722D2D63656C6C20646174657069636B65722D2D63656C6C2D222B652C733D6E657720446174652C6E3D746869732E642C683D612E726573657454696D65286E2E6D696E52616E6765292C6F3D612E726573657454696D65286E2E6D';
wwv_flow_api.g_varchar2_table(242) := '617852616E6765292C723D6E2E6F7074732C633D612E676574506172736564446174652874292C643D7B7D2C6C3D632E646174653B7377697463682865297B6361736522646179223A6E2E69735765656B656E6428632E64617929262628692B3D22202D';
wwv_flow_api.g_varchar2_table(243) := '7765656B656E642D22292C632E6D6F6E7468213D746869732E642E706172736564446174652E6D6F6E7468262628692B3D22202D6F746865722D6D6F6E74682D222C722E73656C6563744F746865724D6F6E7468737C7C28692B3D22202D64697361626C';
wwv_flow_api.g_varchar2_table(244) := '65642D22292C722E73686F774F746865724D6F6E7468737C7C286C3D222229293B627265616B3B63617365226D6F6E7468223A6C3D6E2E6C6F635B6E2E6F7074732E6D6F6E7468734669656C645D5B632E6D6F6E74685D3B627265616B3B636173652279';
wwv_flow_api.g_varchar2_table(245) := '656172223A76617220753D6E2E6375724465636164653B6C3D632E796561722C28632E796561723C755B305D7C7C632E796561723E755B315D29262628692B3D22202D6F746865722D6465636164652D222C722E73656C6563744F746865725965617273';
wwv_flow_api.g_varchar2_table(246) := '7C7C28692B3D22202D64697361626C65642D22292C722E73686F774F7468657259656172737C7C286C3D222229297D72657475726E20722E6F6E52656E64657243656C6C262628643D722E6F6E52656E64657243656C6C28742C65297C7C7B7D2C6C3D64';
wwv_flow_api.g_varchar2_table(247) := '2E68746D6C3F642E68746D6C3A6C2C692B3D642E636C61737365733F2220222B642E636C61737365733A2222292C722E72616E6765262628612E697353616D6528682C742C6529262628692B3D22202D72616E67652D66726F6D2D22292C612E69735361';
wwv_flow_api.g_varchar2_table(248) := '6D65286F2C742C6529262628692B3D22202D72616E67652D746F2D22292C313D3D6E2E73656C656374656444617465732E6C656E67746826266E2E666F63757365643F2828612E62696767657228682C74292626612E6C657373286E2E666F6375736564';
wwv_flow_api.g_varchar2_table(249) := '2C74297C7C612E6C657373286F2C74292626612E626967676572286E2E666F63757365642C742929262628692B3D22202D696E2D72616E67652D22292C612E6C657373286F2C74292626612E697353616D65286E2E666F63757365642C7429262628692B';
wwv_flow_api.g_varchar2_table(250) := '3D22202D72616E67652D66726F6D2D22292C612E62696767657228682C74292626612E697353616D65286E2E666F63757365642C7429262628692B3D22202D72616E67652D746F2D2229293A323D3D6E2E73656C656374656444617465732E6C656E6774';
wwv_flow_api.g_varchar2_table(251) := '682626612E62696767657228682C74292626612E6C657373286F2C7429262628692B3D22202D696E2D72616E67652D2229292C612E697353616D6528732C742C6529262628692B3D22202D63757272656E742D22292C6E2E666F63757365642626612E69';
wwv_flow_api.g_varchar2_table(252) := '7353616D6528742C6E2E666F63757365642C6529262628692B3D22202D666F6375732D22292C6E2E5F697353656C656374656428742C6529262628692B3D22202D73656C65637465642D22292C6E2E5F6973496E52616E676528742C6529262621642E64';
wwv_flow_api.g_varchar2_table(253) := '697361626C65647C7C28692B3D22202D64697361626C65642D22292C7B68746D6C3A6C2C636C61737365733A697D7D2C5F6765744461797348746D6C3A66756E6374696F6E2874297B76617220653D612E67657444617973436F756E742874292C693D6E';
wwv_flow_api.g_varchar2_table(254) := '6577204461746528742E67657446756C6C5965617228292C742E6765744D6F6E746828292C31292E67657444617928292C733D6E6577204461746528742E67657446756C6C5965617228292C742E6765744D6F6E746828292C65292E6765744461792829';
wwv_flow_api.g_varchar2_table(255) := '2C6E3D692D746869732E642E6C6F632E66697273744461792C683D362D732B746869732E642E6C6F632E66697273744461793B6E3D303E6E3F6E2B373A6E2C683D683E363F682D373A683B666F7228766172206F2C722C633D2D6E2B312C643D22222C6C';
wwv_flow_api.g_varchar2_table(256) := '3D632C753D652B683B753E3D6C3B6C2B2B29723D742E67657446756C6C5965617228292C6F3D742E6765744D6F6E746828292C642B3D746869732E5F67657444617948746D6C286E6577204461746528722C6F2C6C29293B72657475726E20647D2C5F67';
wwv_flow_api.g_varchar2_table(257) := '657444617948746D6C3A66756E6374696F6E2874297B76617220653D746869732E5F67657443656C6C436F6E74656E747328742C2264617922293B72657475726E273C64697620636C6173733D22272B652E636C61737365732B272220646174612D6461';
wwv_flow_api.g_varchar2_table(258) := '74653D22272B742E6765744461746528292B272220646174612D6D6F6E74683D22272B742E6765744D6F6E746828292B272220646174612D796561723D22272B742E67657446756C6C5965617228292B27223E272B652E68746D6C2B223C2F6469763E22';
wwv_flow_api.g_varchar2_table(259) := '7D2C5F6765744D6F6E74687348746D6C3A66756E6374696F6E2874297B666F722876617220653D22222C693D612E676574506172736564446174652874292C733D303B31323E733B29652B3D746869732E5F6765744D6F6E746848746D6C286E65772044';
wwv_flow_api.g_varchar2_table(260) := '61746528692E796561722C7329292C732B2B3B72657475726E20657D2C5F6765744D6F6E746848746D6C3A66756E6374696F6E2874297B76617220653D746869732E5F67657443656C6C436F6E74656E747328742C226D6F6E746822293B72657475726E';
wwv_flow_api.g_varchar2_table(261) := '273C64697620636C6173733D22272B652E636C61737365732B272220646174612D6D6F6E74683D22272B742E6765744D6F6E746828292B27223E272B652E68746D6C2B223C2F6469763E227D2C5F676574596561727348746D6C3A66756E6374696F6E28';
wwv_flow_api.g_varchar2_table(262) := '74297B76617220653D28612E676574506172736564446174652874292C612E676574446563616465287429292C693D655B305D2D312C733D22222C6E3D693B666F72286E3B6E3C3D655B315D2B313B6E2B2B29732B3D746869732E5F6765745965617248';
wwv_flow_api.g_varchar2_table(263) := '746D6C286E65772044617465286E2C3029293B72657475726E20737D2C5F6765745965617248746D6C3A66756E6374696F6E2874297B76617220653D746869732E5F67657443656C6C436F6E74656E747328742C227965617222293B72657475726E273C';
wwv_flow_api.g_varchar2_table(264) := '64697620636C6173733D22272B652E636C61737365732B272220646174612D796561723D22272B742E67657446756C6C5965617228292B27223E272B652E68746D6C2B223C2F6469763E227D2C5F72656E64657254797065733A7B646179733A66756E63';
wwv_flow_api.g_varchar2_table(265) := '74696F6E28297B76617220743D746869732E5F6765744461794E616D657348746D6C28746869732E642E6C6F632E6669727374446179292C653D746869732E5F6765744461797348746D6C28746869732E642E63757272656E7444617465293B74686973';
wwv_flow_api.g_varchar2_table(266) := '2E2463656C6C732E68746D6C2865292C746869732E246E616D65732E68746D6C2874297D2C6D6F6E7468733A66756E6374696F6E28297B76617220743D746869732E5F6765744D6F6E74687348746D6C28746869732E642E63757272656E744461746529';
wwv_flow_api.g_varchar2_table(267) := '3B746869732E2463656C6C732E68746D6C2874297D2C79656172733A66756E6374696F6E28297B76617220743D746869732E5F676574596561727348746D6C28746869732E642E63757272656E7444617465293B746869732E2463656C6C732E68746D6C';
wwv_flow_api.g_varchar2_table(268) := '2874297D7D2C5F72656E6465723A66756E6374696F6E28297B746869732E6F7074732E6F6E6C7954696D657069636B65727C7C746869732E5F72656E64657254797065735B746869732E747970655D2E62696E6428746869732928297D2C5F7570646174';
wwv_flow_api.g_varchar2_table(269) := '653A66756E6374696F6E28297B76617220742C692C732C613D6528222E646174657069636B65722D2D63656C6C222C746869732E2463656C6C73292C6E3D746869733B612E656163682866756E6374696F6E28297B693D652874686973292C733D6E2E64';
wwv_flow_api.g_varchar2_table(270) := '2E5F6765744461746546726F6D43656C6C2865287468697329292C743D6E2E5F67657443656C6C436F6E74656E747328732C6E2E642E63656C6C54797065292C692E617474722822636C617373222C742E636C6173736573297D297D2C73686F773A6675';
wwv_flow_api.g_varchar2_table(271) := '6E6374696F6E28297B746869732E6F7074732E6F6E6C7954696D657069636B65727C7C28746869732E24656C2E616464436C617373282261637469766522292C746869732E6163697476653D2130297D2C686964653A66756E6374696F6E28297B746869';
wwv_flow_api.g_varchar2_table(272) := '732E24656C2E72656D6F7665436C617373282261637469766522292C746869732E6163746976653D21317D2C5F68616E646C65436C69636B3A66756E6374696F6E2874297B76617220653D742E6461746128226461746522297C7C312C693D742E646174';
wwv_flow_api.g_varchar2_table(273) := '6128226D6F6E746822297C7C302C733D742E6461746128227965617222297C7C746869732E642E706172736564446174652E796561722C613D746869732E643B696628612E76696577213D746869732E6F7074732E6D696E566965772972657475726E20';
wwv_flow_api.g_varchar2_table(274) := '766F696420612E646F776E286E6577204461746528732C692C6529293B766172206E3D6E6577204461746528732C692C65292C683D746869732E642E5F697353656C6563746564286E2C746869732E642E63656C6C54797065293B72657475726E20683F';
wwv_flow_api.g_varchar2_table(275) := '766F696420612E5F68616E646C65416C726561647953656C656374656444617465732E62696E6428612C682C6E2928293A766F696420612E5F747269676765722822636C69636B43656C6C222C6E297D2C5F6F6E436C69636B43656C6C3A66756E637469';
wwv_flow_api.g_varchar2_table(276) := '6F6E2874297B76617220693D6528742E746172676574292E636C6F7365737428222E646174657069636B65722D2D63656C6C22293B692E686173436C61737328222D64697361626C65642D22297C7C746869732E5F68616E646C65436C69636B2E62696E';
wwv_flow_api.g_varchar2_table(277) := '642874686973292869297D7D7D28292C66756E6374696F6E28297B76617220743D273C64697620636C6173733D22646174657069636B65722D2D6E61762D616374696F6E2220646174612D616374696F6E3D2270726576223E237B7072657648746D6C7D';
wwv_flow_api.g_varchar2_table(278) := '3C2F6469763E3C64697620636C6173733D22646174657069636B65722D2D6E61762D7469746C65223E237B7469746C657D3C2F6469763E3C64697620636C6173733D22646174657069636B65722D2D6E61762D616374696F6E2220646174612D61637469';
wwv_flow_api.g_varchar2_table(279) := '6F6E3D226E657874223E237B6E65787448746D6C7D3C2F6469763E272C693D273C64697620636C6173733D22646174657069636B65722D2D627574746F6E7320612D627574746F6E223E3C2F6469763E272C733D273C7370616E20636C6173733D226461';
wwv_flow_api.g_varchar2_table(280) := '74657069636B65722D2D627574746F6E2220646174612D616374696F6E3D22237B616374696F6E7D223E237B6C6162656C7D3C2F7370616E3E272C613D652E666E2E646174657069636B65722C6E3D612E436F6E7374727563746F723B612E4E61766967';
wwv_flow_api.g_varchar2_table(281) := '6174696F6E3D66756E6374696F6E28742C65297B746869732E643D742C746869732E6F7074733D652C746869732E24627574746F6E73436F6E7461696E65723D22222C746869732E696E697428297D2C612E4E617669676174696F6E2E70726F746F7479';
wwv_flow_api.g_varchar2_table(282) := '70653D7B696E69743A66756E6374696F6E28297B746869732E5F6275696C644261736548746D6C28292C746869732E5F62696E644576656E747328297D2C5F62696E644576656E74733A66756E6374696F6E28297B746869732E642E246E61762E6F6E28';
wwv_flow_api.g_varchar2_table(283) := '22636C69636B222C222E646174657069636B65722D2D6E61762D616374696F6E222C652E70726F787928746869732E5F6F6E436C69636B4E6176427574746F6E2C7468697329292C746869732E642E246E61762E6F6E2822636C69636B222C222E646174';
wwv_flow_api.g_varchar2_table(284) := '657069636B65722D2D6E61762D7469746C65222C652E70726F787928746869732E5F6F6E436C69636B4E61765469746C652C7468697329292C746869732E642E24646174657069636B65722E6F6E2822636C69636B222C222E646174657069636B65722D';
wwv_flow_api.g_varchar2_table(285) := '2D627574746F6E222C652E70726F787928746869732E5F6F6E436C69636B4E6176427574746F6E2C7468697329297D2C5F6275696C644261736548746D6C3A66756E6374696F6E28297B746869732E6F7074732E6F6E6C7954696D657069636B65727C7C';
wwv_flow_api.g_varchar2_table(286) := '746869732E5F72656E64657228292C746869732E5F616464427574746F6E7349664E65656428297D2C5F616464427574746F6E7349664E6565643A66756E6374696F6E28297B746869732E6F7074732E746F646179427574746F6E2626746869732E5F61';
wwv_flow_api.g_varchar2_table(287) := '6464427574746F6E2822746F64617922292C746869732E6F7074732E636C656172427574746F6E2626746869732E5F616464427574746F6E2822636C65617222297D2C5F72656E6465723A66756E6374696F6E28297B76617220693D746869732E5F6765';
wwv_flow_api.g_varchar2_table(288) := '745469746C6528746869732E642E63757272656E7444617465292C733D6E2E74656D706C61746528742C652E657874656E64287B7469746C653A697D2C746869732E6F70747329293B746869732E642E246E61762E68746D6C2873292C22796561727322';
wwv_flow_api.g_varchar2_table(289) := '3D3D746869732E642E7669657726266528222E646174657069636B65722D2D6E61762D7469746C65222C746869732E642E246E6176292E616464436C61737328222D64697361626C65642D22292C746869732E7365744E617653746174757328297D2C5F';
wwv_flow_api.g_varchar2_table(290) := '6765745469746C653A66756E6374696F6E2874297B72657475726E20746869732E642E666F726D61744461746528746869732E6F7074732E6E61765469746C65735B746869732E642E766965775D2C74297D2C5F616464427574746F6E3A66756E637469';
wwv_flow_api.g_varchar2_table(291) := '6F6E2874297B746869732E24627574746F6E73436F6E7461696E65722E6C656E6774687C7C746869732E5F616464427574746F6E73436F6E7461696E657228293B76617220693D7B616374696F6E3A742C6C6162656C3A746869732E642E6C6F635B745D';
wwv_flow_api.g_varchar2_table(292) := '7D2C613D6E2E74656D706C61746528732C69293B6528225B646174612D616374696F6E3D222B742B225D222C746869732E24627574746F6E73436F6E7461696E6572292E6C656E6774687C7C746869732E24627574746F6E73436F6E7461696E65722E61';
wwv_flow_api.g_varchar2_table(293) := '7070656E642861297D2C5F616464427574746F6E73436F6E7461696E65723A66756E6374696F6E28297B746869732E642E24646174657069636B65722E617070656E642869292C746869732E24627574746F6E73436F6E7461696E65723D6528222E6461';
wwv_flow_api.g_varchar2_table(294) := '74657069636B65722D2D627574746F6E73222C746869732E642E24646174657069636B6572297D2C7365744E61765374617475733A66756E6374696F6E28297B69662828746869732E6F7074732E6D696E446174657C7C746869732E6F7074732E6D6178';
wwv_flow_api.g_varchar2_table(295) := '44617465292626746869732E6F7074732E64697361626C654E61765768656E4F75744F6652616E6765297B76617220743D746869732E642E706172736564446174652C653D742E6D6F6E74682C693D742E796561722C733D742E646174653B7377697463';
wwv_flow_api.g_varchar2_table(296) := '6828746869732E642E76696577297B636173652264617973223A746869732E642E5F6973496E52616E6765286E6577204461746528692C652D312C31292C226D6F6E746822297C7C746869732E5F64697361626C654E617628227072657622292C746869';
wwv_flow_api.g_varchar2_table(297) := '732E642E5F6973496E52616E6765286E6577204461746528692C652B312C31292C226D6F6E746822297C7C746869732E5F64697361626C654E617628226E65787422293B627265616B3B63617365226D6F6E746873223A746869732E642E5F6973496E52';
wwv_flow_api.g_varchar2_table(298) := '616E6765286E6577204461746528692D312C652C73292C227965617222297C7C746869732E5F64697361626C654E617628227072657622292C746869732E642E5F6973496E52616E6765286E6577204461746528692B312C652C73292C22796561722229';
wwv_flow_api.g_varchar2_table(299) := '7C7C746869732E5F64697361626C654E617628226E65787422293B627265616B3B63617365227965617273223A76617220613D6E2E67657444656361646528746869732E642E64617465293B746869732E642E5F6973496E52616E6765286E6577204461';
wwv_flow_api.g_varchar2_table(300) := '746528615B305D2D312C302C31292C227965617222297C7C746869732E5F64697361626C654E617628227072657622292C746869732E642E5F6973496E52616E6765286E6577204461746528615B315D2B312C302C31292C227965617222297C7C746869';
wwv_flow_api.g_varchar2_table(301) := '732E5F64697361626C654E617628226E65787422297D7D7D2C5F64697361626C654E61763A66756E6374696F6E2874297B6528275B646174612D616374696F6E3D22272B742B27225D272C746869732E642E246E6176292E616464436C61737328222D64';
wwv_flow_api.g_varchar2_table(302) := '697361626C65642D22297D2C5F61637469766174654E61763A66756E6374696F6E2874297B6528275B646174612D616374696F6E3D22272B742B27225D272C746869732E642E246E6176292E72656D6F7665436C61737328222D64697361626C65642D22';
wwv_flow_api.g_varchar2_table(303) := '297D2C5F6F6E436C69636B4E6176427574746F6E3A66756E6374696F6E2874297B76617220693D6528742E746172676574292E636C6F7365737428225B646174612D616374696F6E5D22292C733D692E646174612822616374696F6E22293B746869732E';
wwv_flow_api.g_varchar2_table(304) := '645B735D28297D2C5F6F6E436C69636B4E61765469746C653A66756E6374696F6E2874297B72657475726E206528742E746172676574292E686173436C61737328222D64697361626C65642D22293F766F696420303A2264617973223D3D746869732E64';
wwv_flow_api.g_varchar2_table(305) := '2E766965773F746869732E642E766965773D226D6F6E746873223A766F696428746869732E642E766965773D22796561727322297D7D7D28292C66756E6374696F6E28297B76617220743D273C64697620636C6173733D22646174657069636B65722D2D';
wwv_flow_api.g_varchar2_table(306) := '74696D65223E3C64697620636C6173733D22646174657069636B65722D2D74696D652D63757272656E74223E2020203C7370616E20636C6173733D22646174657069636B65722D2D74696D652D63757272656E742D686F757273223E237B686F75725669';
wwv_flow_api.g_varchar2_table(307) := '7369626C657D3C2F7370616E3E2020203C7370616E20636C6173733D22646174657069636B65722D2D74696D652D63757272656E742D636F6C6F6E223E3A3C2F7370616E3E2020203C7370616E20636C6173733D22646174657069636B65722D2D74696D';
wwv_flow_api.g_varchar2_table(308) := '652D63757272656E742D6D696E75746573223E237B6D696E56616C75657D3C2F7370616E3E3C2F6469763E3C64697620636C6173733D22646174657069636B65722D2D74696D652D736C6964657273223E2020203C64697620636C6173733D2264617465';
wwv_flow_api.g_varchar2_table(309) := '7069636B65722D2D74696D652D726F77223E2020202020203C696E70757420747970653D2272616E676522206E616D653D22686F757273222076616C75653D22237B686F757256616C75657D22206D696E3D22237B686F75724D696E7D22206D61783D22';
wwv_flow_api.g_varchar2_table(310) := '237B686F75724D61787D2220737465703D22237B686F7572537465707D222F3E2020203C2F6469763E2020203C64697620636C6173733D22646174657069636B65722D2D74696D652D726F77223E2020202020203C696E70757420747970653D2272616E';
wwv_flow_api.g_varchar2_table(311) := '676522206E616D653D226D696E75746573222076616C75653D22237B6D696E56616C75657D22206D696E3D22237B6D696E4D696E7D22206D61783D22237B6D696E4D61787D2220737465703D22237B6D696E537465707D222F3E2020203C2F6469763E3C';
wwv_flow_api.g_varchar2_table(312) := '2F6469763E3C2F6469763E272C693D652E666E2E646174657069636B65722C733D692E436F6E7374727563746F723B692E54696D657069636B65723D66756E6374696F6E28742C65297B746869732E643D742C746869732E6F7074733D652C746869732E';
wwv_flow_api.g_varchar2_table(313) := '696E697428297D2C692E54696D657069636B65722E70726F746F747970653D7B696E69743A66756E6374696F6E28297B76617220743D22696E707574223B746869732E5F73657454696D6528746869732E642E64617465292C746869732E5F6275696C64';
wwv_flow_api.g_varchar2_table(314) := '48544D4C28292C6E6176696761746F722E757365724167656E742E6D61746368282F74726964656E742F676929262628743D226368616E676522292C746869732E642E24656C2E6F6E282273656C65637444617465222C746869732E5F6F6E53656C6563';
wwv_flow_api.g_varchar2_table(315) := '74446174652E62696E64287468697329292C746869732E2472616E6765732E6F6E28742C746869732E5F6F6E4368616E676552616E67652E62696E64287468697329292C746869732E2472616E6765732E6F6E28226D6F7573657570222C746869732E5F';
wwv_flow_api.g_varchar2_table(316) := '6F6E4D6F757365557052616E67652E62696E64287468697329292C746869732E2472616E6765732E6F6E28226D6F7573656D6F766520666F63757320222C746869732E5F6F6E4D6F757365456E74657252616E67652E62696E64287468697329292C7468';
wwv_flow_api.g_varchar2_table(317) := '69732E2472616E6765732E6F6E28226D6F7573656F757420626C7572222C746869732E5F6F6E4D6F7573654F757452616E67652E62696E64287468697329297D2C5F73657454696D653A66756E6374696F6E2874297B76617220653D732E676574506172';
wwv_flow_api.g_varchar2_table(318) := '736564446174652874293B746869732E5F68616E646C65446174652874292C746869732E686F7572733D652E686F7572733C746869732E6D696E486F7572733F746869732E6D696E486F7572733A652E686F7572732C746869732E6D696E757465733D65';
wwv_flow_api.g_varchar2_table(319) := '2E6D696E757465733C746869732E6D696E4D696E757465733F746869732E6D696E4D696E757465733A652E6D696E757465737D2C5F7365744D696E54696D6546726F6D446174653A66756E6374696F6E2874297B746869732E6D696E486F7572733D742E';
wwv_flow_api.g_varchar2_table(320) := '676574486F75727328292C746869732E6D696E4D696E757465733D742E6765744D696E7574657328292C746869732E642E6C61737453656C6563746564446174652626746869732E642E6C61737453656C6563746564446174652E676574486F75727328';
wwv_flow_api.g_varchar2_table(321) := '293E742E676574486F7572732829262628746869732E6D696E4D696E757465733D746869732E6F7074732E6D696E4D696E75746573293B0A7D2C5F7365744D617854696D6546726F6D446174653A66756E6374696F6E2874297B746869732E6D6178486F';
wwv_flow_api.g_varchar2_table(322) := '7572733D742E676574486F75727328292C746869732E6D61784D696E757465733D742E6765744D696E7574657328292C746869732E642E6C61737453656C6563746564446174652626746869732E642E6C61737453656C6563746564446174652E676574';
wwv_flow_api.g_varchar2_table(323) := '486F75727328293C742E676574486F7572732829262628746869732E6D61784D696E757465733D746869732E6F7074732E6D61784D696E75746573297D2C5F73657444656661756C744D696E4D617854696D653A66756E6374696F6E28297B7661722074';
wwv_flow_api.g_varchar2_table(324) := '3D32332C653D35392C693D746869732E6F7074733B746869732E6D696E486F7572733D692E6D696E486F7572733C307C7C692E6D696E486F7572733E743F303A692E6D696E486F7572732C746869732E6D696E4D696E757465733D692E6D696E4D696E75';
wwv_flow_api.g_varchar2_table(325) := '7465733C307C7C692E6D696E4D696E757465733E653F303A692E6D696E4D696E757465732C746869732E6D6178486F7572733D692E6D6178486F7572733C307C7C692E6D6178486F7572733E743F743A692E6D6178486F7572732C746869732E6D61784D';
wwv_flow_api.g_varchar2_table(326) := '696E757465733D692E6D61784D696E757465733C307C7C692E6D61784D696E757465733E653F653A692E6D61784D696E757465737D2C5F76616C6964617465486F7572734D696E757465733A66756E6374696F6E28297B746869732E686F7572733C7468';
wwv_flow_api.g_varchar2_table(327) := '69732E6D696E486F7572733F746869732E686F7572733D746869732E6D696E486F7572733A746869732E686F7572733E746869732E6D6178486F757273262628746869732E686F7572733D746869732E6D6178486F757273292C746869732E6D696E7574';
wwv_flow_api.g_varchar2_table(328) := '65733C746869732E6D696E4D696E757465733F746869732E6D696E757465733D746869732E6D696E4D696E757465733A746869732E6D696E757465733E746869732E6D61784D696E75746573262628746869732E6D696E757465733D746869732E6D6178';
wwv_flow_api.g_varchar2_table(329) := '4D696E75746573297D2C5F6275696C6448544D4C3A66756E6374696F6E28297B76617220693D732E6765744C656164696E675A65726F4E756D2C613D7B686F75724D696E3A746869732E6D696E486F7572732C686F75724D61783A6928746869732E6D61';
wwv_flow_api.g_varchar2_table(330) := '78486F757273292C686F7572537465703A746869732E6F7074732E686F757273537465702C686F757256616C75653A746869732E686F7572732C686F757256697369626C653A6928746869732E646973706C6179486F757273292C6D696E4D696E3A7468';
wwv_flow_api.g_varchar2_table(331) := '69732E6D696E4D696E757465732C6D696E4D61783A6928746869732E6D61784D696E75746573292C6D696E537465703A746869732E6F7074732E6D696E75746573537465702C6D696E56616C75653A6928746869732E6D696E75746573297D2C6E3D732E';
wwv_flow_api.g_varchar2_table(332) := '74656D706C61746528742C61293B746869732E2474696D657069636B65723D65286E292E617070656E64546F28746869732E642E24646174657069636B6572292C746869732E2472616E6765733D6528275B747970653D2272616E6765225D272C746869';
wwv_flow_api.g_varchar2_table(333) := '732E2474696D657069636B6572292C746869732E24686F7572733D6528275B6E616D653D22686F757273225D272C746869732E2474696D657069636B6572292C746869732E246D696E757465733D6528275B6E616D653D226D696E75746573225D272C74';
wwv_flow_api.g_varchar2_table(334) := '6869732E2474696D657069636B6572292C746869732E24686F757273546578743D6528222E646174657069636B65722D2D74696D652D63757272656E742D686F757273222C746869732E2474696D657069636B6572292C746869732E246D696E75746573';
wwv_flow_api.g_varchar2_table(335) := '546578743D6528222E646174657069636B65722D2D74696D652D63757272656E742D6D696E75746573222C746869732E2474696D657069636B6572292C746869732E642E616D706D262628746869732E24616D706D3D6528273C7370616E20636C617373';
wwv_flow_api.g_varchar2_table(336) := '3D22646174657069636B65722D2D74696D652D63757272656E742D616D706D223E27292E617070656E64546F286528222E646174657069636B65722D2D74696D652D63757272656E74222C746869732E2474696D657069636B657229292E68746D6C2874';
wwv_flow_api.g_varchar2_table(337) := '6869732E646179506572696F64292C746869732E2474696D657069636B65722E616464436C61737328222D616D2D706D2D2229297D2C5F75706461746543757272656E7454696D653A66756E6374696F6E28297B76617220743D732E6765744C65616469';
wwv_flow_api.g_varchar2_table(338) := '6E675A65726F4E756D28746869732E646973706C6179486F757273292C653D732E6765744C656164696E675A65726F4E756D28746869732E6D696E75746573293B746869732E24686F757273546578742E68746D6C2874292C746869732E246D696E7574';
wwv_flow_api.g_varchar2_table(339) := '6573546578742E68746D6C2865292C746869732E642E616D706D2626746869732E24616D706D2E68746D6C28746869732E646179506572696F64297D2C5F75706461746552616E6765733A66756E6374696F6E28297B746869732E24686F7572732E6174';
wwv_flow_api.g_varchar2_table(340) := '7472287B6D696E3A746869732E6D696E486F7572732C6D61783A746869732E6D6178486F7572737D292E76616C28746869732E686F757273292C746869732E246D696E757465732E61747472287B6D696E3A746869732E6D696E4D696E757465732C6D61';
wwv_flow_api.g_varchar2_table(341) := '783A746869732E6D61784D696E757465737D292E76616C28746869732E6D696E75746573297D2C5F68616E646C65446174653A66756E6374696F6E2874297B746869732E5F73657444656661756C744D696E4D617854696D6528292C74262628732E6973';
wwv_flow_api.g_varchar2_table(342) := '53616D6528742C746869732E642E6F7074732E6D696E44617465293F746869732E5F7365744D696E54696D6546726F6D4461746528746869732E642E6F7074732E6D696E44617465293A732E697353616D6528742C746869732E642E6F7074732E6D6178';
wwv_flow_api.g_varchar2_table(343) := '44617465292626746869732E5F7365744D617854696D6546726F6D4461746528746869732E642E6F7074732E6D61784461746529292C746869732E5F76616C6964617465486F7572734D696E757465732874297D2C7570646174653A66756E6374696F6E';
wwv_flow_api.g_varchar2_table(344) := '28297B746869732E5F75706461746552616E67657328292C746869732E5F75706461746543757272656E7454696D6528297D2C5F67657456616C6964486F75727346726F6D446174653A66756E6374696F6E28742C65297B76617220693D742C613D743B';
wwv_flow_api.g_varchar2_table(345) := '7420696E7374616E63656F662044617465262628693D732E676574506172736564446174652874292C613D692E686F757273293B766172206E3D657C7C746869732E642E616D706D2C683D22616D223B6966286E29737769746368282130297B63617365';
wwv_flow_api.g_varchar2_table(346) := '20303D3D613A613D31323B627265616B3B636173652031323D3D613A683D22706D223B627265616B3B6361736520613E31313A612D3D31322C683D22706D227D72657475726E7B686F7572733A612C646179506572696F643A687D7D2C73657420686F75';
wwv_flow_api.g_varchar2_table(347) := '72732874297B746869732E5F686F7572733D743B76617220653D746869732E5F67657456616C6964486F75727346726F6D446174652874293B746869732E646973706C6179486F7572733D652E686F7572732C746869732E646179506572696F643D652E';
wwv_flow_api.g_varchar2_table(348) := '646179506572696F647D2C67657420686F75727328297B72657475726E20746869732E5F686F7572737D2C5F6F6E4368616E676552616E67653A66756E6374696F6E2874297B76617220693D6528742E746172676574292C733D692E6174747228226E61';
wwv_flow_api.g_varchar2_table(349) := '6D6522293B746869732E642E74696D657069636B657249734163746976653D21302C746869735B735D3D692E76616C28292C746869732E5F75706461746543757272656E7454696D6528292C746869732E642E5F74726967676572282274696D65436861';
wwv_flow_api.g_varchar2_table(350) := '6E6765222C5B746869732E686F7572732C746869732E6D696E757465735D292C746869732E5F68616E646C654461746528746869732E642E6C61737453656C656374656444617465292C746869732E75706461746528297D2C5F6F6E53656C6563744461';
wwv_flow_api.g_varchar2_table(351) := '74653A66756E6374696F6E28742C65297B746869732E5F68616E646C65446174652865292C746869732E75706461746528297D2C5F6F6E4D6F757365456E74657252616E67653A66756E6374696F6E2874297B76617220693D6528742E74617267657429';
wwv_flow_api.g_varchar2_table(352) := '2E6174747228226E616D6522293B6528222E646174657069636B65722D2D74696D652D63757272656E742D222B692C746869732E2474696D657069636B6572292E616464436C61737328222D666F6375732D22297D2C5F6F6E4D6F7573654F757452616E';
wwv_flow_api.g_varchar2_table(353) := '67653A66756E6374696F6E2874297B76617220693D6528742E746172676574292E6174747228226E616D6522293B746869732E642E696E466F6375737C7C6528222E646174657069636B65722D2D74696D652D63757272656E742D222B692C746869732E';
wwv_flow_api.g_varchar2_table(354) := '2474696D657069636B6572292E72656D6F7665436C61737328222D666F6375732D22297D2C5F6F6E4D6F757365557052616E67653A66756E6374696F6E28297B746869732E642E74696D657069636B657249734163746976653D21317D7D7D28297D2877';
wwv_flow_api.g_varchar2_table(355) := '696E646F772C6A5175657279293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(2885787576520268)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_file_name=>'js/datepicker.min.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2166756E6374696F6E2874297B742E776964676574282275692E64796E616D69634461746554696D655069636B6572222C7B6F7074696F6E733A7B646174654974656D49443A22222C64617465546F4974656D3A6E756C6C2C6465736B746F7055493A21';
wwv_flow_api.g_varchar2_table(2) := '302C6461746554696D6553706C69743A21312C726561644F6E6C793A21312C73686F774D6574686F643A6E756C6C2C746F64617942746E546578743A6E756C6C2C636C61737365733A22222C696E6C696E653A21312C6C616E67756167653A22656E222C';
wwv_flow_api.g_varchar2_table(3) := '66697273744461793A22222C7765656B656E64733A5B362C305D2C64617465466F726D61743A22222C746F67676C6553656C65637465643A21302C6B6579626F6172644E61763A21302C706F736974696F6E3A22626F74746F6D206C656674222C6F6666';
wwv_flow_api.g_varchar2_table(4) := '7365743A31322C766965773A2264617973222C6D696E566965773A2264617973222C73686F774F746865724D6F6E7468733A21302C73656C6563744F746865724D6F6E7468733A21302C6D6F7665546F4F746865724D6F6E7468734F6E53656C6563743A';
wwv_flow_api.g_varchar2_table(5) := '21302C73686F774F7468657259656172733A21302C73656C6563744F7468657259656172733A21302C6D6F7665546F4F7468657259656172734F6E53656C6563743A21302C6D696E446174653A22222C6D6178446174653A22222C64697361626C654E61';
wwv_flow_api.g_varchar2_table(6) := '765768656E4F75744F6652616E67653A21302C6D756C7469706C6544617465733A21312C6D756C7469706C654461746573536570617261746F723A222C222C72616E67653A21312C746F646179427574746F6E3A21312C636C656172427574746F6E3A21';
wwv_flow_api.g_varchar2_table(7) := '312C6175746F436C6F73653A21312C6E61765469746C65733A7B646179733A224D4D2C203C693E797979793C2F693E222C6D6F6E7468733A2279797979222C79656172733A227979797931202D207979797932227D2C74696D657069636B65723A21312C';
wwv_flow_api.g_varchar2_table(8) := '6F6E6C7954696D657069636B65723A21312C6461746554696D65536570617261746F723A2220222C74696D65466F726D61743A22222C6D696E486F7572733A302C6D6178486F7572733A32342C6D696E4D696E757465733A302C6D61784D696E75746573';
wwv_flow_api.g_varchar2_table(9) := '3A35392C686F757273537465703A312C6D696E75746573537465703A312C6F6E53656C6563743A22222C6F6E53686F773A22222C6F6E486964653A22222C6F6E4368616E67654D6F6E74683A22222C6F6E4368616E6765596561723A22222C6F6E436861';
wwv_flow_api.g_varchar2_table(10) := '6E67654465636164653A22222C6F6E4368616E6765566965773A22222C6F6E52656E64657243656C6C3A22227D2C5F736574576964676574566172733A66756E6374696F6E28297B313D3D746869732E6F7074696F6E732E6465736B746F7055493F7468';
wwv_flow_api.g_varchar2_table(11) := '69732E617065783D7B6974656D3A746869732E656C656D656E742C24656C6D3A7428746869732E656C656D656E74292C746F4974656D3A7428646F63756D656E742E676574456C656D656E744279496428746869732E6F7074696F6E732E64617465546F';
wwv_flow_api.g_varchar2_table(12) := '4974656D29292C646174657069636B6572427574746F6E3A746869732E656C656D656E742E6E657874416C6C2822627574746F6E22292E666972737428292C646174657069636B6572546F427574746F6E3A7428646F63756D656E742E676574456C656D';
wwv_flow_api.g_varchar2_table(13) := '656E744279496428746869732E6F7074696F6E732E64617465546F4974656D29292E6E657874416C6C2822627574746F6E22292E666972737428292C7069636B65723A6E756C6C2C746F5069636B65723A6E756C6C7D3A746869732E617065783D7B6974';
wwv_flow_api.g_varchar2_table(14) := '656D3A746869732E656C656D656E742C24656C6D3A7428746869732E656C656D656E74292C746F4974656D3A7428646F63756D656E742E676574456C656D656E744279496428746869732E6F7074696F6E732E64617465546F4974656D29292C7069636B';
wwv_flow_api.g_varchar2_table(15) := '65723A6E756C6C2C746F5069636B65723A6E756C6C7D2C746869732E64617465546F3D7B6974656D3A7428746869732E6F7074696F6E732E64617465546F4974656D292C646174657069636B6572427574746F6E3A6E756C6C7D2C746869732E5F73636F';
wwv_flow_api.g_varchar2_table(16) := '70653D2275692E64796E616D69634461746554696D655069636B6572227D2C5F696E69743A66756E6374696F6E28297B617065782E64656275672E6C6F6728746869732E5F73636F70652C225F696E6974222C74686973297D2C5F6372656174653A6675';
wwv_flow_api.g_varchar2_table(17) := '6E6374696F6E28297B746869732E6F7074696F6E732E64617465546F4974656D2626746869732E6F7074696F6E732E726561644F6E6C79262674282223222B746869732E6F7074696F6E732E64617465546F4974656D292E70726F702822726561646F6E';
wwv_flow_api.g_varchar2_table(18) := '6C79222C2130292C6E756C6C213D746869732E6F7074696F6E732E64617465546F4974656D2626746869732E6F7074696F6E732E6465736B746F705549262628746869732E6F7074696F6E732E72616E67657C7C746869732E6F7074696F6E732E646174';
wwv_flow_api.g_varchar2_table(19) := '6554696D6553706C697429262674282223222B746869732E6F7074696F6E732E64617465546F4974656D292E616674657228273C627574746F6E20747970653D22627574746F6E2220636C6173733D2264796E646174657069636B65722D747269676765';
wwv_flow_api.g_varchar2_table(20) := '7220612D427574746F6E20612D427574746F6E2D2D63616C656E646172223E3C7370616E20636C6173733D22612D49636F6E2069636F6E2D63616C656E646172223E3C2F7370616E3E3C2F627574746F6E3E27292C746869732E5F736574576964676574';
wwv_flow_api.g_varchar2_table(21) := '5661727328293B746869732E5F73636F70652B225F637265617465223B617065782E64656275672E6C6F672822746869733A222C74686973293B617065782E64656275672E6C6F672822656C656D656E743A222C746869732E617065782E6974656D292C';
wwv_flow_api.g_varchar2_table(22) := '22726967687420626F74746F6D22213D746869732E6F7074696F6E732E706F736974696F6E262622726967687420746F7022213D746869732E6F7074696F6E732E706F736974696F6E7C7C28746869732E6F7074696F6E732E6F66667365743D3437292C';
wwv_flow_api.g_varchar2_table(23) := '746869732E6F7074696F6E732E6F6E53656C6563743D66756E6374696F6E28652C692C6F297B6E756C6C213D6F2E6F7074732E64617465546F4974656D26266F2E6F7074732E72616E67653F2874282223222B6F2E6F7074732E646174654974656D4944';
wwv_flow_api.g_varchar2_table(24) := '292E76616C28652E73706C6974286F2E6F7074732E6D756C7469706C654461746573536570617261746F72295B305D292C74282223222B6F2E6F7074732E64617465546F4974656D292E76616C28652E737562737472696E6728652E73706C6974286F2E';
wwv_flow_api.g_varchar2_table(25) := '6F7074732E6D756C7469706C654461746573536570617261746F72295B305D2E6C656E6774682B312C652E6C656E6774682929293A6E756C6C213D6F2E6F7074732E64617465546F4974656D26266F2E6F7074732E6461746554696D6553706C69742626';
wwv_flow_api.g_varchar2_table(26) := '2874282223222B6F2E656C2E6964292E76616C28652E73706C6974286F2E6F7074732E6461746554696D65536570617261746F72295B305D292C74282223222B6F2E6F7074732E64617465546F4974656D292E76616C28652E737562737472696E672865';
wwv_flow_api.g_varchar2_table(27) := '2E73706C6974286F2E6F7074732E6461746554696D65536570617261746F72295B305D2E6C656E6774682B312C652E6C656E6774682929293B766172206E3D7B66643A652C646174653A692C696E73743A6F7D2C733D74282223222B6F2E656C2E696429';
wwv_flow_api.g_varchar2_table(28) := '3B732E7472696767657228226F6E73656C656374222C6E297D2C746869732E6F7074696F6E732E6F6E53686F773D66756E6374696F6E28652C69297B766172206F3D7B696E73743A652C616E696D6174696F6E436F6D706C657465643A697D2C6E3D7428';
wwv_flow_api.g_varchar2_table(29) := '2223222B652E656C2E6964293B6926266E2E7472696767657228226F6E73686F77222C6F297D2C746869732E6F7074696F6E732E6F6E486964653D66756E6374696F6E28652C69297B766172206F3D7B696E73743A652C616E696D6174696F6E436F6D70';
wwv_flow_api.g_varchar2_table(30) := '6C657465643A697D2C6E3D74282223222B652E656C2E6964293B6926266E2E7472696767657228226F6E68696465222C6F297D2C746869732E6F7074696F6E732E6F6E4368616E67654D6F6E74683D66756E6374696F6E28652C69297B766172206F3D7B';
wwv_flow_api.g_varchar2_table(31) := '6D6F6E74683A652C796561723A692C696E73743A746869737D2C6E3D74282223222B746869732E646174654974656D4944293B6E2E7472696767657228226F6E6368616E67656D6F6E7468222C6F297D2C746869732E6F7074696F6E732E6F6E4368616E';
wwv_flow_api.g_varchar2_table(32) := '6765596561723D66756E6374696F6E2865297B76617220693D7B796561723A652C696E73743A746869737D2C6F3D74282223222B746869732E646174654974656D4944293B6F2E7472696767657228226F6E6368616E676579656172222C69297D2C7468';
wwv_flow_api.g_varchar2_table(33) := '69732E6F7074696F6E732E6F6E4368616E67654465636164653D66756E6374696F6E2865297B76617220693D7B6465636164653A652C696E73743A746869737D2C6F3D74282223222B746869732E646174654974656D4944293B6F2E7472696767657228';
wwv_flow_api.g_varchar2_table(34) := '226F6E6368616E6765646563616465222C69297D2C746869732E6F7074696F6E732E6F6E4368616E6765566965773D66756E6374696F6E2865297B76617220693D7B766965773A652C696E73743A746869737D2C6F3D74282223222B746869732E646174';
wwv_flow_api.g_varchar2_table(35) := '654974656D4944293B6F2E7472696767657228226F6E6368616E676576696577222C69297D2C746869732E6F7074696F6E732E6F6E52656E64657243656C6C3D66756E6374696F6E28652C69297B766172206F3D7B646174653A652C63656C6C54797065';
wwv_flow_api.g_varchar2_table(36) := '3A692C696E73743A746869737D2C6E3D74282223222B746869732E646174654974656D4944293B6E2E7472696767657228226F6E72656E64657263656C6C222C6F297D2C746869732E6F7074696F6E732E73686F774576656E743D22222C746869732E61';
wwv_flow_api.g_varchar2_table(37) := '7065782E7069636B65723D746869732E617065782E6974656D2E646174657069636B657228746869732E6F7074696F6E732C66756E6374696F6E28297B7D292E646174612822646174657069636B657222292C6E756C6C213D746869732E6F7074696F6E';
wwv_flow_api.g_varchar2_table(38) := '732E64617465546F4974656D2626746869732E6F7074696F6E732E72616E67652626746869732E6F7074696F6E732E696E6C696E652626746869732E6F7074696F6E732E6465736B746F705549262674282223222B746869732E6F7074696F6E732E6461';
wwv_flow_api.g_varchar2_table(39) := '74654974656D4944292E616674657228273C627574746F6E20747970653D22627574746F6E2220636C6173733D2264796E646174657069636B65722D7472696767657220612D427574746F6E20612D427574746F6E2D2D63616C656E646172223E3C7370';
wwv_flow_api.g_varchar2_table(40) := '616E20636C6173733D22612D49636F6E2069636F6E2D63616C656E646172223E3C2F7370616E3E3C2F627574746F6E3E27292C22636C69636B223D3D746869732E6F7074696F6E732E73686F774D6574686F643F28746869732E617065782E6974656D2E';
wwv_flow_api.g_varchar2_table(41) := '6F6E2822636C69636B222C742E70726F787928746869732E5F6E617469766553686F775069636B65722C7468697329292C746869732E617065782E746F4974656D2E6F6E2822636C69636B222C742E70726F787928746869732E5F6E617469766553686F';
wwv_flow_api.g_varchar2_table(42) := '775069636B65722C746869732929293A2269636F6E223D3D746869732E6F7074696F6E732E73686F774D6574686F642626746869732E6F7074696F6E732E6465736B746F7055493F28746869732E617065782E646174657069636B6572427574746F6E2E';
wwv_flow_api.g_varchar2_table(43) := '6F6E2822636C69636B222C742E70726F787928746869732E5F6E617469766553686F775069636B65722C7468697329292C746869732E617065782E646174657069636B6572546F427574746F6E2E6F6E2822636C69636B222C742E70726F787928746869';
wwv_flow_api.g_varchar2_table(44) := '732E5F6E617469766553686F775069636B65722C746869732929293A22636C69636B69636F6E223D3D746869732E6F7074696F6E732E73686F774D6574686F643F28746869732E617065782E6974656D2E6F6E2822636C69636B222C742E70726F787928';
wwv_flow_api.g_varchar2_table(45) := '746869732E5F6E617469766553686F775069636B65722C7468697329292C746869732E617065782E746F4974656D2E6F6E2822636C69636B222C742E70726F787928746869732E5F6E617469766553686F775069636B65722C7468697329292C74686973';
wwv_flow_api.g_varchar2_table(46) := '2E6F7074696F6E732E6465736B746F705549262628746869732E617065782E646174657069636B6572427574746F6E2E6F6E2822636C69636B222C742E70726F787928746869732E5F6E617469766553686F775069636B65722C7468697329292C746869';
wwv_flow_api.g_varchar2_table(47) := '732E617065782E646174657069636B6572546F427574746F6E2E6F6E2822636C69636B222C742E70726F787928746869732E5F6E617469766553686F775069636B65722C74686973292929293A22666F637573223D3D746869732E6F7074696F6E732E73';
wwv_flow_api.g_varchar2_table(48) := '686F774D6574686F643F746869732E617065782E6974656D2E6F6E2822666F637573222C742E70726F787928746869732E5F6E617469766553686F775069636B65722C7468697329293A226D6F757365656E746572223D3D746869732E6F7074696F6E73';
wwv_flow_api.g_varchar2_table(49) := '2E73686F774D6574686F64262628746869732E617065782E6974656D2E6F6E28226D6F757365656E746572222C742E70726F787928746869732E5F6E617469766553686F775069636B65722C7468697329292C746869732E617065782E64617465706963';
wwv_flow_api.g_varchar2_table(50) := '6B6572427574746F6E2E6F6E28226D6F757365656E746572222C742E70726F787928746869732E5F6E617469766553686F775069636B65722C746869732929292C746869732E5F617065785F646128746869732E61706578297D2C5F6E61746976655368';
wwv_flow_api.g_varchar2_table(51) := '6F775069636B65723A66756E6374696F6E28297B72657475726E20746869732E617065782E6974656D2E697328222E64697361626C656422293F21313A766F696420746869732E617065782E7069636B65722E73686F7728297D2C5F6E61746976655069';
wwv_flow_api.g_varchar2_table(52) := '636B6572486964653A66756E6374696F6E28297B72657475726E20746869732E617065782E6974656D2E697328222E64697361626C656422293F21313A766F696420746869732E617065782E7069636B65722E6869646528297D2C5F617065785F64613A';
wwv_flow_api.g_varchar2_table(53) := '66756E6374696F6E2874297B76617220653D742E6974656D2E617474722822696422292C693D7B656E61626C653A66756E6374696F6E28297B742E6974656D2E64796E616D69634461746554696D655069636B65722822656E61626C6522292E72656D6F';
wwv_flow_api.g_varchar2_table(54) := '7665436C6173732822617065785F64697361626C656422297D2C64697361626C653A66756E6374696F6E28297B742E6974656D2E70726F70282264697361626C6564222C2130292E616464436C6173732822617065785F64697361626C656422292E6164';
wwv_flow_api.g_varchar2_table(55) := '64436C617373282264697361626C656422292C742E646174657069636B6572427574746F6E2E70726F70282264697361626C6564222C2130292E616464436C617373282264697361626C656422292C636F6E736F6C652E6C6F672874297D2C6166746572';
wwv_flow_api.g_varchar2_table(56) := '4D6F646966793A66756E6374696F6E28297B7D2C6C6F6164696E67496E64696361746F723A66756E6374696F6E2874297B72657475726E20747D7D3B617065782E7769646765742E696E6974506167654974656D28652C69297D2C64657374726F793A66';
wwv_flow_api.g_varchar2_table(57) := '756E6374696F6E28297B617065782E64656275672E6C6F6728746869732E5F73636F70652C2264657374726F79222C74686973292C742E5769646765742E70726F746F747970652E64657374726F792E6170706C7928746869732C617267756D656E7473';
wwv_flow_api.g_varchar2_table(58) := '292C7428746869732E656C656D656E74292E646174657069636B6572282264657374726F7922297D7D297D28617065782E6A51756572792C617065782E776964676574293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(5199880015099309)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_file_name=>'js/dynamicDateTimePicker.min.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '3B2866756E6374696F6E20282429207B20242E666E2E646174657069636B65722E6C616E67756167655B276373275D203D207B0A20202020646179733A205B274E6564C49B6C65272C2027506F6E64C49B6CC3AD272C2027C39A746572C3BD272C202753';
wwv_flow_api.g_varchar2_table(2) := '74C599656461272C2027C48C74767274656B272C202750C3A174656B272C2027536F626F7461275D2C0A202020206461797353686F72743A205B274E65272C2027506F272C2027C39A74272C20275374272C2027C48C74272C202750C3A1272C2027536F';
wwv_flow_api.g_varchar2_table(3) := '275D2C0A20202020646179734D696E3A205B274E65272C2027506F272C2027C39A74272C20275374272C2027C48C74272C202750C3A1272C2027536F275D2C0A202020206D6F6E7468733A205B274C6564656E272C2027C39A6E6F72272C202742C59965';
wwv_flow_api.g_varchar2_table(4) := '7A656E272C2027447562656E272C20274B76C49B74656E272C2027C48C657276656E272C2027C48C657276656E6563272C2027537270656E272C20275AC3A1C599C3AD272C2027C598C3AD6A656E272C20274C6973746F706164272C202750726F73696E';
wwv_flow_api.g_varchar2_table(5) := '6563275D2C0A202020206D6F6E74687353686F72743A205B274C6564272C2027C39A6E6F272C202742C59965272C2027447562272C20274B76C49B272C2027C48C766E272C2027C48C7663272C2027537270272C20275AC3A1C599272C2027C598C3AD6A';
wwv_flow_api.g_varchar2_table(6) := '272C20274C6973272C202750726F275D2C0A20202020746F6461793A2027446E6573272C0A20202020636C6561723A202756796D617A6174272C0A2020202064617465466F726D61743A202764642E6D6D2E79797979272C0A2020202074696D65466F72';
wwv_flow_api.g_varchar2_table(7) := '6D61743A202768683A6969272C0A2020202066697273744461793A20310A7D3B207D29286A5175657279293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(7373162648223277)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_file_name=>'js/i18n/datepicker.cs.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '3B2866756E6374696F6E20282429207B20242E666E2E646174657069636B65722E6C616E67756167655B276461275D203D207B0A20202020646179733A205B2753C3B86E646167272C20274D616E646167272C202754697273646167272C20274F6E7364';
wwv_flow_api.g_varchar2_table(2) := '6167272C2027546F7273646167272C2027467265646167272C20274CC3B872646167275D2C0A202020206461797353686F72743A205B2753C3B86E272C20274D616E272C2027546972272C20274F6E73272C2027546F72272C2027467265272C20274CC3';
wwv_flow_api.g_varchar2_table(3) := 'B872275D2C0A20202020646179734D696E3A205B2753C3B8272C20274D61272C20275469272C20274F6E272C2027546F272C20274672272C20274CC3B8275D2C0A202020206D6F6E7468733A205B274A616E756172272C2746656272756172272C274D61';
wwv_flow_api.g_varchar2_table(4) := '727473272C27417072696C272C274D616A272C274A756E69272C20274A756C69272C27417567757374272C2753657074656D626572272C274F6B746F626572272C274E6F76656D626572272C27446563656D626572275D2C0A202020206D6F6E74687353';
wwv_flow_api.g_varchar2_table(5) := '686F72743A205B274A616E272C2027466562272C20274D6172272C2027417072272C20274D616A272C20274A756E272C20274A756C272C2027417567272C2027536570272C20274F6B74272C20274E6F76272C2027446563275D2C0A20202020746F6461';
wwv_flow_api.g_varchar2_table(6) := '793A20274920646167272C0A20202020636C6561723A20274E756C7374696C272C0A2020202064617465466F726D61743A202764642F6D6D2F79797979272C0A2020202074696D65466F726D61743A202768683A6969272C0A2020202066697273744461';
wwv_flow_api.g_varchar2_table(7) := '793A20310A7D3B207D29286A5175657279293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(7373571331223825)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_file_name=>'js/i18n/datepicker.da.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '3B2866756E6374696F6E20282429207B20242E666E2E646174657069636B65722E6C616E67756167655B276465275D203D207B0A20202020646179733A205B27536F6E6E746167272C20274D6F6E746167272C20274469656E73746167272C20274D6974';
wwv_flow_api.g_varchar2_table(2) := '74776F6368272C2027446F6E6E657273746167272C202746726569746167272C202753616D73746167275D2C0A202020206461797353686F72743A205B27536F6E272C20274D6F6E272C2027446965272C20274D6974272C2027446F6E272C2027467265';
wwv_flow_api.g_varchar2_table(3) := '272C202753616D275D2C0A20202020646179734D696E3A205B27536F272C20274D6F272C20274469272C20274D69272C2027446F272C20274672272C20275361275D2C0A202020206D6F6E7468733A205B274A616E756172272C2746656272756172272C';
wwv_flow_api.g_varchar2_table(4) := '274DC3A4727A272C27417072696C272C274D6169272C274A756E69272C20274A756C69272C27417567757374272C2753657074656D626572272C274F6B746F626572272C274E6F76656D626572272C2744657A656D626572275D2C0A202020206D6F6E74';
wwv_flow_api.g_varchar2_table(5) := '687353686F72743A205B274A616E272C2027466562272C20274DC3A472272C2027417072272C20274D6169272C20274A756E272C20274A756C272C2027417567272C2027536570272C20274F6B74272C20274E6F76272C202744657A275D2C0A20202020';
wwv_flow_api.g_varchar2_table(6) := '746F6461793A20274865757465272C0A20202020636C6561723A202741756672C3A4756D656E272C0A2020202064617465466F726D61743A202764642E6D6D2E79797979272C0A2020202074696D65466F726D61743A202768683A6969272C0A20202020';
wwv_flow_api.g_varchar2_table(7) := '66697273744461793A20310A7D3B0A207D29286A5175657279293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(7373874490224275)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_file_name=>'js/i18n/datepicker.de.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '3B2866756E6374696F6E20282429207B20242E666E2E646174657069636B65722E6C616E67756167655B276573275D203D207B0A20202020646179733A205B27446F6D696E676F272C20274C756E6573272C20274D6172746573272C20274D69C3A97263';
wwv_flow_api.g_varchar2_table(2) := '6F6C6573272C20274A7565766573272C2027566965726E6573272C202753C3A16261646F275D2C0A202020206461797353686F72743A205B27446F6D272C20274C756E272C20274D6172272C20274D6965272C20274A7565272C2027566965272C202753';
wwv_flow_api.g_varchar2_table(3) := '6162275D2C0A20202020646179734D696E3A205B27446F272C20274C75272C20274D61272C20274D69272C20274A75272C20275669272C20275361275D2C0A202020206D6F6E7468733A205B27456E65726F272C274665627265726F272C274D61727A6F';
wwv_flow_api.g_varchar2_table(4) := '272C27416272696C272C274D61796F272C274A756E696F272C20274A756C696F272C274175676F73746F272C275365707469656D627265272C274F637475627265272C274E6F7669656D627265272C2744696369656D627265275D2C0A202020206D6F6E';
wwv_flow_api.g_varchar2_table(5) := '74687353686F72743A205B27456E65272C2027466562272C20274D6172272C2027416272272C20274D6179272C20274A756E272C20274A756C272C202741676F272C2027536570272C20274F6374272C20274E6F76272C2027446963275D2C0A20202020';
wwv_flow_api.g_varchar2_table(6) := '746F6461793A2027486F79272C0A20202020636C6561723A20274C696D70696172272C0A2020202064617465466F726D61743A202764642F6D6D2F79797979272C0A2020202074696D65466F726D61743A202768683A6969206161272C0A202020206669';
wwv_flow_api.g_varchar2_table(7) := '7273744461793A20310A7D3B207D29286A5175657279293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(7374592477226702)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_file_name=>'js/i18n/datepicker.es.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '3B2866756E6374696F6E20282429207B20242E666E2E646174657069636B65722E6C616E67756167655B276669275D203D207B0A20202020646179733A205B2753756E6E756E746169272C20274D61616E616E746169272C202754696973746169272C20';
wwv_flow_api.g_varchar2_table(2) := '274B65736B697669696B6B6F272C2027546F7273746169272C20275065726A616E746169272C20274C6175616E746169275D2C0A202020206461797353686F72743A205B275375272C20274D61272C20275469272C20274B65272C2027546F272C202750';
wwv_flow_api.g_varchar2_table(3) := '65272C20274C61275D2C0A20202020646179734D696E3A205B275375272C20274D61272C20275469272C20274B65272C2027546F272C20275065272C20274C61275D2C0A202020206D6F6E7468733A205B2754616D6D696B7575272C2748656C6D696B75';
wwv_flow_api.g_varchar2_table(4) := '75272C274D61616C69736B7575272C2748756874696B7575272C27546F756B6F6B7575272C274B6573C3A46B7575272C20274865696EC3A46B7575272C27456C6F6B7575272C27537979736B7575272C274C6F6B616B7575272C274D61727261736B7575';
wwv_flow_api.g_varchar2_table(5) := '272C274A6F756C756B7575275D2C0A202020206D6F6E74687353686F72743A205B2754616D6D69272C202748656C6D69272C20274D61616C6973272C20274875687469272C2027546F756B6F272C20274B6573C3A4272C20274865696EC3A4272C202745';
wwv_flow_api.g_varchar2_table(6) := '6C6F272C202753797973272C20274C6F6B61272C20274D6172726173272C20274A6F756C75275D2C0A20202020746F6461793A202754C3A46EC3A4C3A46E272C0A20202020636C6561723A20275479686A656E6EC3A4272C0A2020202064617465466F72';
wwv_flow_api.g_varchar2_table(7) := '6D61743A202764642E6D6D2E79797979272C0A2020202074696D65466F726D61743A202768683A6969272C0A2020202066697273744461793A20310A7D3B0A207D29286A5175657279293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(7375034805227781)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_file_name=>'js/i18n/datepicker.fi.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '3B2866756E6374696F6E20282429207B20242E666E2E646174657069636B65722E6C616E67756167655B276672275D203D207B0A20202020646179733A205B2744696D616E636865272C20274C756E6469272C20274D61726469272C20274D6572637265';
wwv_flow_api.g_varchar2_table(2) := '6469272C20274A65756469272C202756656E6472656469272C202753616D656469275D2C0A202020206461797353686F72743A205B2744696D272C20274C756E272C20274D6172272C20274D6572272C20274A6575272C202756656E272C202753616D27';
wwv_flow_api.g_varchar2_table(3) := '5D2C0A20202020646179734D696E3A205B274469272C20274C75272C20274D61272C20274D65272C20274A65272C20275665272C20275361275D2C0A202020206D6F6E7468733A205B274A616E76696572272C2746C3A97672696572272C274D61727327';
wwv_flow_api.g_varchar2_table(4) := '2C27417672696C272C274D6169272C274A75696E272C20274A75696C6C6574272C27416FC3BB74272C2753657074656D627265272C274F63746F627265272C274E6F76656D627265272C27446563656D627265275D2C0A202020206D6F6E74687353686F';
wwv_flow_api.g_varchar2_table(5) := '72743A205B274A616E272C202746C3A976272C20274D617273272C2027417672272C20274D6169272C20274A75696E272C20274A75696C272C2027416FC3BB74272C2027536570272C20274F6374272C20274E6F76272C2027446563275D2C0A20202020';
wwv_flow_api.g_varchar2_table(6) := '746F6461793A202241756A6F75726427687569222C0A20202020636C6561723A202745666661636572272C0A2020202064617465466F726D61743A202764642F6D6D2F79797979272C0A2020202074696D65466F726D61743A202768683A6969272C0A20';
wwv_flow_api.g_varchar2_table(7) := '20202066697273744461793A20310A7D3B207D29286A5175657279293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(7375391364228401)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_file_name=>'js/i18n/datepicker.fr.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '3B2866756E6374696F6E20282429207B203B2866756E6374696F6E20282429207B20242E666E2E646174657069636B65722E6C616E67756167655B276875275D203D207B0A20202020646179733A205B27566173C3A1726E6170272C202748C3A97466C5';
wwv_flow_api.g_varchar2_table(2) := '91272C20274B656464272C2027537A65726461272C20274373C3BC74C3B67274C3B66B272C202750C3A96E74656B272C2027537A6F6D626174275D2C0A202020206461797353686F72743A205B275661272C202748C3A9272C20274B65272C2027537A65';
wwv_flow_api.g_varchar2_table(3) := '272C20274373272C202750C3A9272C2027537A6F275D2C0A20202020646179734D696E3A205B2756272C202748272C20274B272C2027537A272C20274373272C202750272C2027537A275D2C0A202020206D6F6E7468733A205B274A616E75C3A172272C';
wwv_flow_api.g_varchar2_table(4) := '20274665627275C3A172272C20274DC3A17263697573272C2027C3817072696C6973272C20274DC3A16A7573272C20274AC3BA6E697573272C20274AC3BA6C697573272C202741756775737A747573272C2027537A657074656D626572272C20274F6B74';
wwv_flow_api.g_varchar2_table(5) := 'C3B3626572272C20274E6F76656D626572272C2027446563656D626572275D2C0A202020206D6F6E74687353686F72743A205B274A616E272C2027466562272C20274DC3A172272C2027C3817072272C20274DC3A16A272C20274AC3BA6E272C20274AC3';
wwv_flow_api.g_varchar2_table(6) := 'BA6C272C2027417567272C2027537A6570272C20274F6B74272C20274E6F76272C2027446563275D2C0A20202020746F6461793A20274D61272C0A20202020636C6561723A202754C3B6726CC3A973272C0A2020202064617465466F726D61743A202779';
wwv_flow_api.g_varchar2_table(7) := '7979792D6D6D2D6464272C0A2020202074696D65466F726D61743A202768683A6969206161272C0A2020202066697273744461793A20310A7D3B207D29286A5175657279293B207D29286A5175657279293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(7375813139229053)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_file_name=>'js/i18n/datepicker.hu.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '3B2866756E6374696F6E20282429207B20242E666E2E646174657069636B65722E6C616E67756167655B276E6C275D203D207B0A20202020646179733A205B277A6F6E646167272C20276D61616E646167272C202764696E73646167272C2027776F656E';
wwv_flow_api.g_varchar2_table(2) := '73646167272C2027646F6E646572646167272C20277672696A646167272C20277A61746572646167275D2C0A202020206461797353686F72743A205B277A6F272C20276D61272C20276469272C2027776F272C2027646F272C20277672272C20277A6127';
wwv_flow_api.g_varchar2_table(3) := '5D2C0A20202020646179734D696E3A205B277A6F272C20276D61272C20276469272C2027776F272C2027646F272C20277672272C20277A61275D2C0A202020206D6F6E7468733A205B274A616E75617269272C20274665627275617269272C20274D6161';
wwv_flow_api.g_varchar2_table(4) := '7274272C2027417072696C272C20274D6569272C20274A756E69272C20274A756C69272C20274175677573747573272C202753657074656D626572272C20274F6B746F626572272C20274E6F76656D626572272C2027446563656D626572275D2C0A2020';
wwv_flow_api.g_varchar2_table(5) := '20206D6F6E74687353686F72743A205B274A616E272C2027466562272C20274D7274272C2027417072272C20274D6569272C20274A756E272C20274A756C272C2027417567272C2027536570272C20274F6B74272C20274E6F76272C2027446563275D2C';
wwv_flow_api.g_varchar2_table(6) := '0A20202020746F6461793A202756616E64616167272C0A20202020636C6561723A20274C6567656E272C0A2020202064617465466F726D61743A202764642D4D4D2D7979272C0A2020202074696D65466F726D61743A202768683A6969272C0A20202020';
wwv_flow_api.g_varchar2_table(7) := '66697273744461793A20300A7D3B207D29286A5175657279293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(7376206397229638)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_file_name=>'js/i18n/datepicker.nl.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '3B2866756E6374696F6E20282429207B20242E666E2E646174657069636B65722E6C616E67756167655B27706C275D203D207B0A20202020646179733A205B274E6965647A69656C61272C2027506F6E6965647A6961C582656B272C202757746F72656B';
wwv_flow_api.g_varchar2_table(2) := '272C2027C59A726F6461272C2027437A77617274656B272C20275069C48574656B272C2027536F626F7461275D2C0A202020206461797353686F72743A205B274E6965272C2027506F6E272C202757746F272C2027C59A726F272C2027437A77272C2027';
wwv_flow_api.g_varchar2_table(3) := '5069C485272C2027536F62275D2C0A20202020646179734D696E3A205B274E64272C2027506E272C20275774272C2027C59A72272C2027437A77272C20275074272C2027536F275D2C0A202020206D6F6E7468733A205B27537479637A65C584272C274C';
wwv_flow_api.g_varchar2_table(4) := '757479272C274D61727A6563272C274B776965636965C584272C274D616A272C27437A657277696563272C20274C6970696563272C2753696572706965C584272C2757727A65736965C584272C275061C5BA647A6965726E696B272C274C6973746F7061';
wwv_flow_api.g_varchar2_table(5) := '64272C27477275647A6965C584275D2C0A202020206D6F6E74687353686F72743A205B27537479272C20274C7574272C20274D6172272C20274B7769272C20274D616A272C2027437A65272C20274C6970272C2027536965272C202757727A272C202750';
wwv_flow_api.g_varchar2_table(6) := '61C5BA272C20274C6973272C2027477275275D2C0A20202020746F6461793A2027447A697369616A272C0A20202020636C6561723A20275779637A79C59BC487272C0A2020202064617465466F726D61743A2027797979792D6D6D2D6464272C0A202020';
wwv_flow_api.g_varchar2_table(7) := '2074696D65466F726D61743A202768683A69693A6161272C0A2020202066697273744461793A20310A7D3B0A207D29286A5175657279293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(7376576032230151)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_file_name=>'js/i18n/datepicker.pl.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '3B2866756E6374696F6E20282429207B20242E666E2E646174657069636B65722E6C616E67756167655B277074275D203D207B0A20202020646179733A205B27446F6D696E676F272C2027536567756E6461272C2027546572C3A761272C202751756172';
wwv_flow_api.g_varchar2_table(2) := '7461272C20275175696E7461272C20275365787461272C202753C3A16261646F275D2C0A202020206461797353686F72743A205B27446F6D272C2027536567272C2027546572272C2027517561272C2027517569272C2027536578272C2027536162275D';
wwv_flow_api.g_varchar2_table(3) := '2C0A20202020646179734D696E3A205B27446F272C20275365272C20275465272C20275161272C20275169272C20275378272C20275361275D2C0A202020206D6F6E7468733A205B274A616E6569726F272C202746657665726569726F272C20274D6172';
wwv_flow_api.g_varchar2_table(4) := 'C3A76F272C2027416272696C272C20274D61696F272C20274A756E686F272C20274A756C686F272C202741676F73746F272C2027536574656D62726F272C20274F75747562726F272C20274E6F76656D62726F272C202744657A656D62726F275D2C0A20';
wwv_flow_api.g_varchar2_table(5) := '2020206D6F6E74687353686F72743A205B274A616E272C2027466576272C20274D6172272C2027416272272C20274D6169272C20274A756E272C20274A756C272C202741676F272C2027536574272C20274F7574272C20274E6F76272C202744657A275D';
wwv_flow_api.g_varchar2_table(6) := '2C0A20202020746F6461793A2027486F6A65272C0A20202020636C6561723A20274C696D706172272C0A2020202064617465466F726D61743A202764642F6D6D2F79797979272C0A2020202074696D65466F726D61743A202768683A6969272C0A202020';
wwv_flow_api.g_varchar2_table(7) := '2066697273744461793A20310A7D3B207D29286A5175657279293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(7377276016231295)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_file_name=>'js/i18n/datepicker.pt.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '3B2866756E6374696F6E20282429207B20242E666E2E646174657069636B65722E6C616E67756167655B2770742D4252275D203D207B0A20202020646179733A205B27446F6D696E676F272C2027536567756E6461272C2027546572C3A761272C202751';
wwv_flow_api.g_varchar2_table(2) := '7561727461272C20275175696E7461272C20275365787461272C202753C3A16261646F275D2C0A202020206461797353686F72743A205B27446F6D272C2027536567272C2027546572272C2027517561272C2027517569272C2027536578272C20275361';
wwv_flow_api.g_varchar2_table(3) := '62275D2C0A20202020646179734D696E3A205B27446F272C20275365272C20275465272C20275175272C20275175272C20275365272C20275361275D2C0A202020206D6F6E7468733A205B274A616E6569726F272C202746657665726569726F272C2027';
wwv_flow_api.g_varchar2_table(4) := '4D6172C3A76F272C2027416272696C272C20274D61696F272C20274A756E686F272C20274A756C686F272C202741676F73746F272C2027536574656D62726F272C20274F75747562726F272C20274E6F76656D62726F272C202744657A656D62726F275D';
wwv_flow_api.g_varchar2_table(5) := '2C0A202020206D6F6E74687353686F72743A205B274A616E272C2027466576272C20274D6172272C2027416272272C20274D6169272C20274A756E272C20274A756C272C202741676F272C2027536574272C20274F7574272C20274E6F76272C20274465';
wwv_flow_api.g_varchar2_table(6) := '7A275D2C0A20202020746F6461793A2027486F6A65272C0A20202020636C6561723A20274C696D706172272C0A2020202064617465466F726D61743A202764642F6D6D2F79797979272C0A2020202074696D65466F726D61743A202768683A6969272C0A';
wwv_flow_api.g_varchar2_table(7) := '2020202066697273744461793A20300A7D3B207D29286A5175657279293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(7377977969232657)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_file_name=>'js/i18n/datepicker.pt-BR.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '3B2866756E6374696F6E20282429207B20242E666E2E646174657069636B65722E6C616E67756167655B27726F275D203D207B0A20202020646179733A205B2744756D696E6963C483272C20274C756E69272C20274D6172C5A369272C20274D69657263';
wwv_flow_api.g_varchar2_table(2) := '757269272C20274A6F69272C202756696E657269272C202753C3A26D62C48374C483275D2C0A202020206461797353686F72743A205B2744756D272C20274C756E272C20274D6172272C20274D6965272C20274A6F69272C202756696E272C202753C3A2';
wwv_flow_api.g_varchar2_table(3) := '6D275D2C0A20202020646179734D696E3A205B2744272C20274C272C20274D61272C20274D69272C20274A272C202756272C202753275D2C0A202020206D6F6E7468733A205B2749616E7561726965272C27466562727561726965272C274D6172746965';
wwv_flow_api.g_varchar2_table(4) := '272C27417072696C6965272C274D6169272C2749756E6965272C2749756C6965272C27417567757374272C2753657074656D62726965272C274F63746F6D62726965272C274E6F69656D62726965272C27446563656D62726965275D2C0A202020206D6F';
wwv_flow_api.g_varchar2_table(5) := '6E74687353686F72743A205B2749616E272C2027466562272C20274D6172272C2027417072272C20274D6169272C202749756E272C202749756C272C2027417567272C202753657074272C20274F6374272C20274E6F76272C2027446563275D2C0A2020';
wwv_flow_api.g_varchar2_table(6) := '2020746F6461793A2027417A69272C0A20202020636C6561723A2027C59E7465726765272C0A2020202064617465466F726D61743A202764642E6D6D2E79797979272C0A2020202074696D65466F726D61743A202768683A6969272C0A20202020666972';
wwv_flow_api.g_varchar2_table(7) := '73744461793A20310A7D3B0A207D29286A5175657279293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(7378413709233254)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_file_name=>'js/i18n/datepicker.ro.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '3B2866756E6374696F6E20282429207B20242E666E2E646174657069636B65722E6C616E67756167655B277275275D203D207B0A202020202020202020202020646179733A205B27D092D0BED181D0BAD180D0B5D181D0B5D0BDD18CD0B5272C2027D09F';
wwv_flow_api.g_varchar2_table(2) := 'D0BED0BDD0B5D0B4D0B5D0BBD18CD0BDD0B8D0BA272C2027D092D182D0BED180D0BDD0B8D0BA272C2027D0A1D180D0B5D0B4D0B0272C2027D0A7D0B5D182D0B2D0B5D180D0B3272C2027D09FD18FD182D0BDD0B8D186D0B0272C2027D0A1D183D0B1D0B1';
wwv_flow_api.g_varchar2_table(3) := 'D0BED182D0B0275D2C0A2020202020202020202020206461797353686F72743A205B27D092D0BED181272C27D09FD0BED0BD272C27D092D182D0BE272C27D0A1D180D0B5272C27D0A7D0B5D182272C27D09FD18FD182272C27D0A1D183D0B1275D2C0A20';
wwv_flow_api.g_varchar2_table(4) := '2020202020202020202020646179734D696E3A205B27D092D181272C27D09FD0BD272C27D092D182272C27D0A1D180272C27D0A7D182272C27D09FD182272C27D0A1D0B1275D2C0A2020202020202020202020206D6F6E7468733A205B27D0AFD0BDD0B2';
wwv_flow_api.g_varchar2_table(5) := 'D0B0D180D18C272C2027D0A4D0B5D0B2D180D0B0D0BBD18C272C2027D09CD0B0D180D182272C2027D090D0BFD180D0B5D0BBD18C272C2027D09CD0B0D0B9272C2027D098D18ED0BDD18C272C2027D098D18ED0BBD18C272C2027D090D0B2D0B3D183D181';
wwv_flow_api.g_varchar2_table(6) := 'D182272C2027D0A1D0B5D0BDD182D18FD0B1D180D18C272C2027D09ED0BAD182D18FD0B1D180D18C272C2027D09DD0BED18FD0B1D180D18C272C2027D094D0B5D0BAD0B0D0B1D180D18C275D2C0A2020202020202020202020206D6F6E74687353686F72';
wwv_flow_api.g_varchar2_table(7) := '743A205B27D0AFD0BDD0B2272C2027D0A4D0B5D0B2272C2027D09CD0B0D180272C2027D090D0BFD180272C2027D09CD0B0D0B9272C2027D098D18ED0BD272C2027D098D18ED0BB272C2027D090D0B2D0B3272C2027D0A1D0B5D0BD272C2027D09ED0BAD1';
wwv_flow_api.g_varchar2_table(8) := '82272C2027D09DD0BED18F272C2027D094D0B5D0BA275D2C0A202020202020202020202020746F6461793A2027D0A1D0B5D0B3D0BED0B4D0BDD18F272C0A202020202020202020202020636C6561723A2027D09ED187D0B8D181D182D0B8D182D18C272C';
wwv_flow_api.g_varchar2_table(9) := '0A20202020202020202020202064617465466F726D61743A202764642E6D6D2E79797979272C0A20202020202020202020202074696D65466F726D61743A202768683A6969272C0A20202020202020202020202066697273744461793A20310A20207D3B';
wwv_flow_api.g_varchar2_table(10) := '207D29286A5175657279293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(7378782189234002)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_file_name=>'js/i18n/datepicker.ru.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '3B2866756E6374696F6E20282429207B20242E666E2E646174657069636B65722E6C616E67756167655B27736B275D203D207B0A20202020646179733A205B274E656465C4BE61272C2027506F6E64656C6F6B272C202755746F726F6B272C2027537472';
wwv_flow_api.g_varchar2_table(2) := '656461272C2027C5A0747672746F6B272C2027506961746F6B272C2027536F626F7461275D2C0A202020206461797353686F72743A205B274E6564272C2027506F6E272C202755746F272C2027537472272C2027C5A07476272C2027506961272C202753';
wwv_flow_api.g_varchar2_table(3) := '6F62275D2C0A20202020646179734D696E3A205B274E65272C2027506F272C20275574272C20275374272C2027C5A074272C20275069272C2027536F275D2C0A202020206D6F6E7468733A205B274A616E75C3A172272C274665627275C3A172272C274D';
wwv_flow_api.g_varchar2_table(4) := '61726563272C27417072C3AD6C272C274DC3A16A272C274AC3BA6E272C20274AC3BA6C272C27417567757374272C2753657074656D626572272C274F6B74C3B3626572272C274E6F76656D626572272C27446563656D626572275D2C0A202020206D6F6E';
wwv_flow_api.g_varchar2_table(5) := '74687353686F72743A205B274A616E272C2027466562272C20274D6172272C2027417072272C20274DC3A16A272C20274AC3BA6E272C20274A756C272C2027417567272C2027536570272C20274F6B74272C20274E6F76272C2027446563275D2C0A2020';
wwv_flow_api.g_varchar2_table(6) := '2020746F6461793A2027446E6573272C0A20202020636C6561723A202756796D617A61C5A5272C0A2020202064617465466F726D61743A202764642E6D6D2E79797979272C0A2020202074696D65466F726D61743A202768683A6969272C0A2020202066';
wwv_flow_api.g_varchar2_table(7) := '697273744461793A20310A7D3B207D29286A5175657279293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(7379234276234625)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_file_name=>'js/i18n/datepicker.sk.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := 'EFBBBF3B2866756E6374696F6E20282429207B20242E666E2E646174657069636B65722E6C616E67756167655B277A68275D203D207B0A20202020646179733A205B27E591A8E697A5272C2027E591A8E4B880272C2027E591A8E4BA8C272C2027E591A8';
wwv_flow_api.g_varchar2_table(2) := 'E4B889272C2027E591A8E59B9B272C2027E591A8E4BA94272C2027E591A8E585AD275D2C0A202020206461797353686F72743A205B27E697A5272C2027E4B880272C2027E4BA8C272C2027E4B889272C2027E59B9B272C2027E4BA94272C2027E585AD27';
wwv_flow_api.g_varchar2_table(3) := '5D2C0A20202020646179734D696E3A205B27E697A5272C2027E4B880272C2027E4BA8C272C2027E4B889272C2027E59B9B272C2027E4BA94272C2027E585AD275D2C0A202020206D6F6E7468733A205B27E4B880E69C88272C2027E4BA8CE69C88272C20';
wwv_flow_api.g_varchar2_table(4) := '27E4B889E69C88272C2027E59B9BE69C88272C2027E4BA94E69C88272C2027E585ADE69C88272C2027E4B883E69C88272C2027E585ABE69C88272C2027E4B99DE69C88272C2027E58D81E69C88272C2027E58D81E4B880E69C88272C2027E58D81E4BA8C';
wwv_flow_api.g_varchar2_table(5) := 'E69C88275D2C0A202020206D6F6E74687353686F72743A205B27E4B880E69C88272C2027E4BA8CE69C88272C2027E4B889E69C88272C2027E59B9BE69C88272C2027E4BA94E69C88272C2027E585ADE69C88272C2027E4B883E69C88272C2027E585ABE6';
wwv_flow_api.g_varchar2_table(6) := '9C88272C2027E4B99DE69C88272C2027E58D81E69C88272C2027E58D81E4B880E69C88272C2027E58D81E4BA8CE69C88275D2C0A20202020746F6461793A2027E4BB8AE5A4A9272C0A20202020636C6561723A2027E6B885E999A4272C0A202020206461';
wwv_flow_api.g_varchar2_table(7) := '7465466F726D61743A2027797979792D6D6D2D6464272C0A2020202074696D65466F726D61743A202768683A6969272C0A2020202066697273744461793A20310A7D3B207D29286A5175657279293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(7379623494235724)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_file_name=>'js/i18n/datepicker.zh.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2E646174657069636B65722D2D63656C6C737B646973706C61793A2D7765626B69742D666C65783B646973706C61793A2D6D732D666C6578626F783B646973706C61793A666C65783B2D7765626B69742D666C65782D777261703A777261703B2D6D732D';
wwv_flow_api.g_varchar2_table(2) := '666C65782D777261703A777261703B666C65782D777261703A777261707D2E646174657069636B65722D2D63656C6C7B626F726465722D7261646975733A3470783B626F782D73697A696E673A626F726465722D626F783B637572736F723A706F696E74';
wwv_flow_api.g_varchar2_table(3) := '65723B646973706C61793A2D7765626B69742D666C65783B646973706C61793A2D6D732D666C6578626F783B646973706C61793A666C65783B706F736974696F6E3A72656C61746976653B2D7765626B69742D616C69676E2D6974656D733A63656E7465';
wwv_flow_api.g_varchar2_table(4) := '723B2D6D732D666C65782D616C69676E3A63656E7465723B616C69676E2D6974656D733A63656E7465723B2D7765626B69742D6A7573746966792D636F6E74656E743A63656E7465723B2D6D732D666C65782D7061636B3A63656E7465723B6A75737469';
wwv_flow_api.g_varchar2_table(5) := '66792D636F6E74656E743A63656E7465723B6865696768743A333270783B7A2D696E6465783A317D2E646174657069636B65722D2D63656C6C2E2D666F6375732D7B6261636B67726F756E643A236630663066307D2E646174657069636B65722D2D6365';
wwv_flow_api.g_varchar2_table(6) := '6C6C2E2D63757272656E742D7B636F6C6F723A233445423545367D2E646174657069636B65722D2D63656C6C2E2D63757272656E742D2E2D666F6375732D7B636F6C6F723A233461346134617D2E646174657069636B65722D2D63656C6C2E2D63757272';
wwv_flow_api.g_varchar2_table(7) := '656E742D2E2D696E2D72616E67652D7B636F6C6F723A233445423545367D2E646174657069636B65722D2D63656C6C2E2D696E2D72616E67652D7B6261636B67726F756E643A726762612839322C3139362C3233392C2E31293B636F6C6F723A23346134';
wwv_flow_api.g_varchar2_table(8) := '6134613B626F726465722D7261646975733A307D2E646174657069636B65722D2D63656C6C2E2D696E2D72616E67652D2E2D666F6375732D7B6261636B67726F756E642D636F6C6F723A726762612839322C3139362C3233392C2E32297D2E6461746570';
wwv_flow_api.g_varchar2_table(9) := '69636B65722D2D63656C6C2E2D64697361626C65642D7B637572736F723A64656661756C743B636F6C6F723A236165616561657D2E646174657069636B65722D2D63656C6C2E2D64697361626C65642D2E2D666F6375732D7B636F6C6F723A2361656165';
wwv_flow_api.g_varchar2_table(10) := '61657D2E646174657069636B65722D2D63656C6C2E2D64697361626C65642D2E2D696E2D72616E67652D7B636F6C6F723A236131613161317D2E646174657069636B65722D2D63656C6C2E2D64697361626C65642D2E2D63757272656E742D2E2D666F63';
wwv_flow_api.g_varchar2_table(11) := '75732D7B636F6C6F723A236165616561657D2E646174657069636B65722D2D63656C6C2E2D72616E67652D66726F6D2D7B626F726465723A31707820736F6C696420726762612839322C3139362C3233392C2E35293B6261636B67726F756E642D636F6C';
wwv_flow_api.g_varchar2_table(12) := '6F723A726762612839322C3139362C3233392C2E31293B626F726465722D7261646975733A34707820302030203470787D2E646174657069636B65722D2D63656C6C2E2D72616E67652D746F2D7B626F726465723A31707820736F6C6964207267626128';
wwv_flow_api.g_varchar2_table(13) := '39322C3139362C3233392C2E35293B6261636B67726F756E642D636F6C6F723A726762612839322C3139362C3233392C2E31293B626F726465722D7261646975733A30203470782034707820307D2E646174657069636B65722D2D63656C6C2E2D73656C';
wwv_flow_api.g_varchar2_table(14) := '65637465642D2C2E646174657069636B65722D2D63656C6C2E2D73656C65637465642D2E2D63757272656E742D7B636F6C6F723A236666663B6261636B67726F756E643A233563633465667D2E646174657069636B65722D2D63656C6C2E2D72616E6765';
wwv_flow_api.g_varchar2_table(15) := '2D66726F6D2D2E2D72616E67652D746F2D7B626F726465722D7261646975733A3470787D2E646174657069636B65722D2D63656C6C2E2D73656C65637465642D7B626F726465723A6E6F6E657D2E646174657069636B65722D2D63656C6C2E2D73656C65';
wwv_flow_api.g_varchar2_table(16) := '637465642D2E2D666F6375732D7B6261636B67726F756E643A233435626365647D2E646174657069636B65722D2D63656C6C3A656D7074797B637572736F723A64656661756C747D2E646174657069636B65722D2D646179732D6E616D65737B64697370';
wwv_flow_api.g_varchar2_table(17) := '6C61793A2D7765626B69742D666C65783B646973706C61793A2D6D732D666C6578626F783B646973706C61793A666C65783B2D7765626B69742D666C65782D777261703A777261703B2D6D732D666C65782D777261703A777261703B666C65782D777261';
wwv_flow_api.g_varchar2_table(18) := '703A777261703B6D617267696E3A3870782030203370787D2E646174657069636B65722D2D6461792D6E616D657B636F6C6F723A234646394131393B646973706C61793A2D7765626B69742D666C65783B646973706C61793A2D6D732D666C6578626F78';
wwv_flow_api.g_varchar2_table(19) := '3B646973706C61793A666C65783B2D7765626B69742D616C69676E2D6974656D733A63656E7465723B2D6D732D666C65782D616C69676E3A63656E7465723B616C69676E2D6974656D733A63656E7465723B2D7765626B69742D6A7573746966792D636F';
wwv_flow_api.g_varchar2_table(20) := '6E74656E743A63656E7465723B2D6D732D666C65782D7061636B3A63656E7465723B6A7573746966792D636F6E74656E743A63656E7465723B2D7765626B69742D666C65783A313B2D6D732D666C65783A313B666C65783A313B746578742D616C69676E';
wwv_flow_api.g_varchar2_table(21) := '3A63656E7465723B746578742D7472616E73666F726D3A7570706572636173653B666F6E742D73697A653A2E38656D7D2E2D6F6E6C792D74696D657069636B65722D202E646174657069636B65722D2D636F6E74656E742C2E646174657069636B65722D';
wwv_flow_api.g_varchar2_table(22) := '2D626F64792C2E646174657069636B65722D696E6C696E65202E646174657069636B65722D2D706F696E7465727B646973706C61793A6E6F6E657D2E646174657069636B65722D2D63656C6C2D6461797B77696474683A31342E3238353731257D2E6461';
wwv_flow_api.g_varchar2_table(23) := '74657069636B65722D2D63656C6C732D6D6F6E7468737B6865696768743A31373070787D2E646174657069636B65722D2D63656C6C2D6D6F6E74687B77696474683A33332E3333253B6865696768743A3235257D2E646174657069636B65722D2D63656C';
wwv_flow_api.g_varchar2_table(24) := '6C732D79656172732C2E646174657069636B65722D2D79656172737B6865696768743A31373070787D2E646174657069636B65722D2D63656C6C2D796561727B77696474683A3235253B6865696768743A33332E3333257D2E646174657069636B657273';
wwv_flow_api.g_varchar2_table(25) := '2D636F6E7461696E65727B706F736974696F6E3A6162736F6C7574653B6C6566743A303B746F703A307D406D65646961207072696E747B2E646174657069636B6572732D636F6E7461696E65727B646973706C61793A6E6F6E657D7D2E64617465706963';
wwv_flow_api.g_varchar2_table(26) := '6B65727B6261636B67726F756E643A236666663B626F726465723A31707820736F6C696420236462646264623B626F782D736861646F773A30203470782031327078207267626128302C302C302C2E3135293B626F726465722D7261646975733A347078';
wwv_flow_api.g_varchar2_table(27) := '3B626F782D73697A696E673A636F6E74656E742D626F783B666F6E742D66616D696C793A5461686F6D612C73616E732D73657269663B666F6E742D73697A653A313470783B636F6C6F723A233461346134613B77696474683A32353070783B706F736974';
wwv_flow_api.g_varchar2_table(28) := '696F6E3A6162736F6C7574653B6C6566743A2D31303030303070783B6F7061636974793A303B7472616E736974696F6E3A6F706163697479202E337320656173652C6C656674203073202E33732C2D7765626B69742D7472616E73666F726D202E337320';
wwv_flow_api.g_varchar2_table(29) := '656173653B7472616E736974696F6E3A6F706163697479202E337320656173652C7472616E73666F726D202E337320656173652C6C656674203073202E33733B7472616E736974696F6E3A6F706163697479202E337320656173652C7472616E73666F72';
wwv_flow_api.g_varchar2_table(30) := '6D202E337320656173652C6C656674203073202E33732C2D7765626B69742D7472616E73666F726D202E337320656173653B7A2D696E6465783A3130307D2E646174657069636B65722E2D66726F6D2D746F702D7B2D7765626B69742D7472616E73666F';
wwv_flow_api.g_varchar2_table(31) := '726D3A7472616E736C61746559282D387078293B7472616E73666F726D3A7472616E736C61746559282D387078297D2E646174657069636B65722E2D66726F6D2D72696768742D7B2D7765626B69742D7472616E73666F726D3A7472616E736C61746558';
wwv_flow_api.g_varchar2_table(32) := '28387078293B7472616E73666F726D3A7472616E736C6174655828387078297D2E646174657069636B65722E2D66726F6D2D626F74746F6D2D7B2D7765626B69742D7472616E73666F726D3A7472616E736C6174655928387078293B7472616E73666F72';
wwv_flow_api.g_varchar2_table(33) := '6D3A7472616E736C6174655928387078297D2E646174657069636B65722E2D66726F6D2D6C6566742D7B2D7765626B69742D7472616E73666F726D3A7472616E736C61746558282D387078293B7472616E73666F726D3A7472616E736C61746558282D38';
wwv_flow_api.g_varchar2_table(34) := '7078297D2E646174657069636B65722E6163746976657B6F7061636974793A313B2D7765626B69742D7472616E73666F726D3A7472616E736C6174652830293B7472616E73666F726D3A7472616E736C6174652830293B7472616E736974696F6E3A6F70';
wwv_flow_api.g_varchar2_table(35) := '6163697479202E337320656173652C6C6566742030732030732C2D7765626B69742D7472616E73666F726D202E337320656173653B7472616E736974696F6E3A6F706163697479202E337320656173652C7472616E73666F726D202E337320656173652C';
wwv_flow_api.g_varchar2_table(36) := '6C6566742030732030733B7472616E736974696F6E3A6F706163697479202E337320656173652C7472616E73666F726D202E337320656173652C6C6566742030732030732C2D7765626B69742D7472616E73666F726D202E337320656173657D2E646174';
wwv_flow_api.g_varchar2_table(37) := '657069636B65722D696E6C696E65202E646174657069636B65727B626F726465722D636F6C6F723A236437643764373B626F782D736861646F773A6E6F6E653B706F736974696F6E3A7374617469633B6C6566743A6175746F3B72696768743A6175746F';
wwv_flow_api.g_varchar2_table(38) := '3B6F7061636974793A313B2D7765626B69742D7472616E73666F726D3A6E6F6E653B7472616E73666F726D3A6E6F6E657D2E646174657069636B65722D2D636F6E74656E747B626F782D73697A696E673A636F6E74656E742D626F783B70616464696E67';
wwv_flow_api.g_varchar2_table(39) := '3A3470787D2E646174657069636B65722D2D706F696E7465727B706F736974696F6E3A6162736F6C7574653B6261636B67726F756E643A236666663B626F726465722D746F703A31707820736F6C696420236462646264623B626F726465722D72696768';
wwv_flow_api.g_varchar2_table(40) := '743A31707820736F6C696420236462646264623B77696474683A313070783B6865696768743A313070783B7A2D696E6465783A2D317D2E646174657069636B65722D2D6E61762D616374696F6E3A686F7665722C2E646174657069636B65722D2D6E6176';
wwv_flow_api.g_varchar2_table(41) := '2D7469746C653A686F7665727B6261636B67726F756E643A236630663066307D2E2D746F702D63656E7465722D202E646174657069636B65722D2D706F696E7465722C2E2D746F702D6C6566742D202E646174657069636B65722D2D706F696E7465722C';
wwv_flow_api.g_varchar2_table(42) := '2E2D746F702D72696768742D202E646174657069636B65722D2D706F696E7465727B746F703A63616C632831303025202D20347078293B2D7765626B69742D7472616E73666F726D3A726F7461746528313335646567293B7472616E73666F726D3A726F';
wwv_flow_api.g_varchar2_table(43) := '7461746528313335646567297D2E2D72696768742D626F74746F6D2D202E646174657069636B65722D2D706F696E7465722C2E2D72696768742D63656E7465722D202E646174657069636B65722D2D706F696E7465722C2E2D72696768742D746F702D20';
wwv_flow_api.g_varchar2_table(44) := '2E646174657069636B65722D2D706F696E7465727B72696768743A63616C632831303025202D20347078293B2D7765626B69742D7472616E73666F726D3A726F7461746528323235646567293B7472616E73666F726D3A726F7461746528323235646567';
wwv_flow_api.g_varchar2_table(45) := '297D2E2D626F74746F6D2D63656E7465722D202E646174657069636B65722D2D706F696E7465722C2E2D626F74746F6D2D6C6566742D202E646174657069636B65722D2D706F696E7465722C2E2D626F74746F6D2D72696768742D202E64617465706963';
wwv_flow_api.g_varchar2_table(46) := '6B65722D2D706F696E7465727B626F74746F6D3A63616C632831303025202D20347078293B2D7765626B69742D7472616E73666F726D3A726F7461746528333135646567293B7472616E73666F726D3A726F7461746528333135646567297D2E2D6C6566';
wwv_flow_api.g_varchar2_table(47) := '742D626F74746F6D2D202E646174657069636B65722D2D706F696E7465722C2E2D6C6566742D63656E7465722D202E646174657069636B65722D2D706F696E7465722C2E2D6C6566742D746F702D202E646174657069636B65722D2D706F696E7465727B';
wwv_flow_api.g_varchar2_table(48) := '6C6566743A63616C632831303025202D20347078293B2D7765626B69742D7472616E73666F726D3A726F74617465283435646567293B7472616E73666F726D3A726F74617465283435646567297D2E2D626F74746F6D2D6C6566742D202E646174657069';
wwv_flow_api.g_varchar2_table(49) := '636B65722D2D706F696E7465722C2E2D746F702D6C6566742D202E646174657069636B65722D2D706F696E7465727B6C6566743A313070787D2E2D626F74746F6D2D72696768742D202E646174657069636B65722D2D706F696E7465722C2E2D746F702D';
wwv_flow_api.g_varchar2_table(50) := '72696768742D202E646174657069636B65722D2D706F696E7465727B72696768743A313070787D2E2D626F74746F6D2D63656E7465722D202E646174657069636B65722D2D706F696E7465722C2E2D746F702D63656E7465722D202E646174657069636B';
wwv_flow_api.g_varchar2_table(51) := '65722D2D706F696E7465727B6C6566743A63616C6328353025202D2031307078202F2032297D2E2D6C6566742D746F702D202E646174657069636B65722D2D706F696E7465722C2E2D72696768742D746F702D202E646174657069636B65722D2D706F69';
wwv_flow_api.g_varchar2_table(52) := '6E7465727B746F703A313070787D2E2D6C6566742D626F74746F6D2D202E646174657069636B65722D2D706F696E7465722C2E2D72696768742D626F74746F6D2D202E646174657069636B65722D2D706F696E7465727B626F74746F6D3A313070787D2E';
wwv_flow_api.g_varchar2_table(53) := '2D6C6566742D63656E7465722D202E646174657069636B65722D2D706F696E7465722C2E2D72696768742D63656E7465722D202E646174657069636B65722D2D706F696E7465727B746F703A63616C6328353025202D2031307078202F2032297D2E6461';
wwv_flow_api.g_varchar2_table(54) := '74657069636B65722D2D626F64792E6163746976657B646973706C61793A626C6F636B7D2E646174657069636B65722D2D6E61767B646973706C61793A2D7765626B69742D666C65783B646973706C61793A2D6D732D666C6578626F783B646973706C61';
wwv_flow_api.g_varchar2_table(55) := '793A666C65783B2D7765626B69742D6A7573746966792D636F6E74656E743A73706163652D6265747765656E3B2D6D732D666C65782D7061636B3A6A7573746966793B6A7573746966792D636F6E74656E743A73706163652D6265747765656E3B626F72';
wwv_flow_api.g_varchar2_table(56) := '6465722D626F74746F6D3A31707820736F6C696420236566656665663B6D696E2D6865696768743A333270783B70616464696E673A3470787D2E2D6F6E6C792D74696D657069636B65722D202E646174657069636B65722D2D6E61767B646973706C6179';
wwv_flow_api.g_varchar2_table(57) := '3A6E6F6E657D2E646174657069636B65722D2D6E61762D616374696F6E2C2E646174657069636B65722D2D6E61762D7469746C657B646973706C61793A2D7765626B69742D666C65783B646973706C61793A2D6D732D666C6578626F783B646973706C61';
wwv_flow_api.g_varchar2_table(58) := '793A666C65783B637572736F723A706F696E7465723B2D7765626B69742D616C69676E2D6974656D733A63656E7465723B2D6D732D666C65782D616C69676E3A63656E7465723B616C69676E2D6974656D733A63656E7465723B2D7765626B69742D6A75';
wwv_flow_api.g_varchar2_table(59) := '73746966792D636F6E74656E743A63656E7465723B2D6D732D666C65782D7061636B3A63656E7465723B6A7573746966792D636F6E74656E743A63656E7465727D2E646174657069636B65722D2D6E61762D616374696F6E7B77696474683A333270783B';
wwv_flow_api.g_varchar2_table(60) := '626F726465722D7261646975733A3470783B2D7765626B69742D757365722D73656C6563743A6E6F6E653B2D6D6F7A2D757365722D73656C6563743A6E6F6E653B2D6D732D757365722D73656C6563743A6E6F6E653B757365722D73656C6563743A6E6F';
wwv_flow_api.g_varchar2_table(61) := '6E657D2E646174657069636B65722D2D6E61762D616374696F6E2E2D64697361626C65642D7B7669736962696C6974793A68696464656E7D2E646174657069636B65722D2D6E61762D616374696F6E207376677B77696474683A333270783B6865696768';
wwv_flow_api.g_varchar2_table(62) := '743A333270787D2E646174657069636B65722D2D6E61762D616374696F6E20706174687B66696C6C3A6E6F6E653B7374726F6B653A233963396339633B7374726F6B652D77696474683A3270787D2E646174657069636B65722D2D6E61762D7469746C65';
wwv_flow_api.g_varchar2_table(63) := '7B626F726465722D7261646975733A3470783B70616464696E673A30203870787D2E646174657069636B65722D2D627574746F6E732C2E646174657069636B65722D2D74696D657B626F726465722D746F703A31707820736F6C69642023656665666566';
wwv_flow_api.g_varchar2_table(64) := '3B70616464696E673A3470787D2E646174657069636B65722D2D6E61762D7469746C6520697B666F6E742D7374796C653A6E6F726D616C3B636F6C6F723A233963396339633B6D617267696E2D6C6566743A3570787D2E646174657069636B65722D2D6E';
wwv_flow_api.g_varchar2_table(65) := '61762D7469746C652E2D64697361626C65642D7B637572736F723A64656661756C743B6261636B67726F756E643A3020307D2E646174657069636B65722D2D627574746F6E737B646973706C61793A2D7765626B69742D666C65783B646973706C61793A';
wwv_flow_api.g_varchar2_table(66) := '2D6D732D666C6578626F783B646973706C61793A666C65787D2E646174657069636B65722D2D627574746F6E7B636F6C6F723A233445423545363B637572736F723A706F696E7465723B626F726465722D7261646975733A3470783B2D7765626B69742D';
wwv_flow_api.g_varchar2_table(67) := '666C65783A313B2D6D732D666C65783A313B666C65783A313B646973706C61793A2D7765626B69742D696E6C696E652D666C65783B646973706C61793A2D6D732D696E6C696E652D666C6578626F783B646973706C61793A696E6C696E652D666C65783B';
wwv_flow_api.g_varchar2_table(68) := '2D7765626B69742D6A7573746966792D636F6E74656E743A63656E7465723B2D6D732D666C65782D7061636B3A63656E7465723B6A7573746966792D636F6E74656E743A63656E7465723B2D7765626B69742D616C69676E2D6974656D733A63656E7465';
wwv_flow_api.g_varchar2_table(69) := '723B2D6D732D666C65782D616C69676E3A63656E7465723B616C69676E2D6974656D733A63656E7465723B6865696768743A333270787D2E646174657069636B65722D2D627574746F6E3A686F7665727B636F6C6F723A233461346134613B6261636B67';
wwv_flow_api.g_varchar2_table(70) := '726F756E643A236630663066307D2E646174657069636B65722D2D74696D657B646973706C61793A2D7765626B69742D666C65783B646973706C61793A2D6D732D666C6578626F783B646973706C61793A666C65783B2D7765626B69742D616C69676E2D';
wwv_flow_api.g_varchar2_table(71) := '6974656D733A63656E7465723B2D6D732D666C65782D616C69676E3A63656E7465723B616C69676E2D6974656D733A63656E7465723B706F736974696F6E3A72656C61746976657D2E646174657069636B65722D2D74696D652E2D616D2D706D2D202E64';
wwv_flow_api.g_varchar2_table(72) := '6174657069636B65722D2D74696D652D736C69646572737B2D7765626B69742D666C65783A3020312031333870783B2D6D732D666C65783A3020312031333870783B666C65783A3020312031333870783B6D61782D77696474683A31333870787D2E2D6F';
wwv_flow_api.g_varchar2_table(73) := '6E6C792D74696D657069636B65722D202E646174657069636B65722D2D74696D657B626F726465722D746F703A6E6F6E657D2E646174657069636B65722D2D74696D652D736C69646572737B2D7765626B69742D666C65783A3020312031353370783B2D';
wwv_flow_api.g_varchar2_table(74) := '6D732D666C65783A3020312031353370783B666C65783A3020312031353370783B6D617267696E2D72696768743A313070783B6D61782D77696474683A31353370787D2E646174657069636B65722D2D74696D652D6C6162656C7B646973706C61793A6E';
wwv_flow_api.g_varchar2_table(75) := '6F6E653B666F6E742D73697A653A313270787D2E646174657069636B65722D2D74696D652D63757272656E747B646973706C61793A2D7765626B69742D666C65783B646973706C61793A2D6D732D666C6578626F783B646973706C61793A666C65783B2D';
wwv_flow_api.g_varchar2_table(76) := '7765626B69742D616C69676E2D6974656D733A63656E7465723B2D6D732D666C65782D616C69676E3A63656E7465723B616C69676E2D6974656D733A63656E7465723B2D7765626B69742D666C65783A313B2D6D732D666C65783A313B666C65783A313B';
wwv_flow_api.g_varchar2_table(77) := '666F6E742D73697A653A313470783B746578742D616C69676E3A63656E7465723B6D617267696E3A302030203020313070787D2E646174657069636B65722D2D74696D652D63757272656E742D636F6C6F6E7B6D617267696E3A3020327078203370783B';
wwv_flow_api.g_varchar2_table(78) := '6C696E652D6865696768743A317D2E646174657069636B65722D2D74696D652D63757272656E742D686F7572732C2E646174657069636B65722D2D74696D652D63757272656E742D6D696E757465737B6C696E652D6865696768743A313B666F6E742D73';
wwv_flow_api.g_varchar2_table(79) := '697A653A313970783B666F6E742D66616D696C793A2243656E7475727920476F74686963222C43656E74757279476F746869632C4170706C65476F746869632C73616E732D73657269663B706F736974696F6E3A72656C61746976653B7A2D696E646578';
wwv_flow_api.g_varchar2_table(80) := '3A317D2E646174657069636B65722D2D74696D652D63757272656E742D686F7572733A61667465722C2E646174657069636B65722D2D74696D652D63757272656E742D6D696E757465733A61667465727B636F6E74656E743A27273B6261636B67726F75';
wwv_flow_api.g_varchar2_table(81) := '6E643A236630663066303B626F726465722D7261646975733A3470783B706F736974696F6E3A6162736F6C7574653B6C6566743A2D3270783B746F703A2D3370783B72696768743A2D3270783B626F74746F6D3A2D3270783B7A2D696E6465783A2D313B';
wwv_flow_api.g_varchar2_table(82) := '6F7061636974793A307D2E646174657069636B65722D2D74696D652D63757272656E742D686F7572732E2D666F6375732D3A61667465722C2E646174657069636B65722D2D74696D652D63757272656E742D6D696E757465732E2D666F6375732D3A6166';
wwv_flow_api.g_varchar2_table(83) := '7465727B6F7061636974793A317D2E646174657069636B65722D2D74696D652D63757272656E742D616D706D7B746578742D7472616E73666F726D3A7570706572636173653B2D7765626B69742D616C69676E2D73656C663A666C65782D656E643B2D6D';
wwv_flow_api.g_varchar2_table(84) := '732D666C65782D6974656D2D616C69676E3A656E643B616C69676E2D73656C663A666C65782D656E643B636F6C6F723A233963396339633B6D617267696E2D6C6566743A3670783B666F6E742D73697A653A313170783B6D617267696E2D626F74746F6D';
wwv_flow_api.g_varchar2_table(85) := '3A3170787D2E646174657069636B65722D2D74696D652D726F777B646973706C61793A2D7765626B69742D666C65783B646973706C61793A2D6D732D666C6578626F783B646973706C61793A666C65783B2D7765626B69742D616C69676E2D6974656D73';
wwv_flow_api.g_varchar2_table(86) := '3A63656E7465723B2D6D732D666C65782D616C69676E3A63656E7465723B616C69676E2D6974656D733A63656E7465723B666F6E742D73697A653A313170783B6865696768743A313770783B6261636B67726F756E643A6C696E6561722D677261646965';
wwv_flow_api.g_varchar2_table(87) := '6E7428746F2072696768742C236465646564652C2364656465646529206C656674203530252F3130302520317078206E6F2D7265706561747D2E646174657069636B65722D2D74696D652D726F773A66697273742D6368696C647B6D617267696E2D626F';
wwv_flow_api.g_varchar2_table(88) := '74746F6D3A3470787D2E646174657069636B65722D2D74696D652D726F7720696E7075745B747970653D72616E67655D7B6261636B67726F756E643A3020303B637572736F723A706F696E7465723B2D7765626B69742D666C65783A313B2D6D732D666C';
wwv_flow_api.g_varchar2_table(89) := '65783A313B666C65783A313B6865696768743A313030253B70616464696E673A303B6D617267696E3A303B2D7765626B69742D617070656172616E63653A6E6F6E657D2E646174657069636B65722D2D74696D652D726F7720696E7075745B747970653D';
wwv_flow_api.g_varchar2_table(90) := '72616E67655D3A3A2D6D732D746F6F6C7469707B646973706C61793A6E6F6E657D2E646174657069636B65722D2D74696D652D726F7720696E7075745B747970653D72616E67655D3A686F7665723A3A2D7765626B69742D736C696465722D7468756D62';
wwv_flow_api.g_varchar2_table(91) := '7B626F726465722D636F6C6F723A236238623862387D2E646174657069636B65722D2D74696D652D726F7720696E7075745B747970653D72616E67655D3A686F7665723A3A2D6D6F7A2D72616E67652D7468756D627B626F726465722D636F6C6F723A23';
wwv_flow_api.g_varchar2_table(92) := '6238623862387D2E646174657069636B65722D2D74696D652D726F7720696E7075745B747970653D72616E67655D3A686F7665723A3A2D6D732D7468756D627B626F726465722D636F6C6F723A236238623862387D2E646174657069636B65722D2D7469';
wwv_flow_api.g_varchar2_table(93) := '6D652D726F7720696E7075745B747970653D72616E67655D3A666F6375737B6F75746C696E653A307D2E646174657069636B65722D2D74696D652D726F7720696E7075745B747970653D72616E67655D3A666F6375733A3A2D7765626B69742D736C6964';
wwv_flow_api.g_varchar2_table(94) := '65722D7468756D627B6261636B67726F756E643A233563633465663B626F726465722D636F6C6F723A233563633465667D2E646174657069636B65722D2D74696D652D726F7720696E7075745B747970653D72616E67655D3A666F6375733A3A2D6D6F7A';
wwv_flow_api.g_varchar2_table(95) := '2D72616E67652D7468756D627B6261636B67726F756E643A233563633465663B626F726465722D636F6C6F723A233563633465667D2E646174657069636B65722D2D74696D652D726F7720696E7075745B747970653D72616E67655D3A666F6375733A3A';
wwv_flow_api.g_varchar2_table(96) := '2D6D732D7468756D627B6261636B67726F756E643A233563633465663B626F726465722D636F6C6F723A233563633465667D2E646174657069636B65722D2D74696D652D726F7720696E7075745B747970653D72616E67655D3A3A2D7765626B69742D73';
wwv_flow_api.g_varchar2_table(97) := '6C696465722D7468756D627B2D7765626B69742D617070656172616E63653A6E6F6E653B626F782D73697A696E673A626F726465722D626F783B6865696768743A313270783B77696474683A313270783B626F726465722D7261646975733A3370783B62';
wwv_flow_api.g_varchar2_table(98) := '6F726465723A31707820736F6C696420236465646564653B6261636B67726F756E643A236666663B637572736F723A706F696E7465723B7472616E736974696F6E3A6261636B67726F756E64202E32733B6D617267696E2D746F703A2D3670787D2E6461';
wwv_flow_api.g_varchar2_table(99) := '74657069636B65722D2D74696D652D726F7720696E7075745B747970653D72616E67655D3A3A2D6D6F7A2D72616E67652D7468756D627B626F782D73697A696E673A626F726465722D626F783B6865696768743A313270783B77696474683A313270783B';
wwv_flow_api.g_varchar2_table(100) := '626F726465722D7261646975733A3370783B626F726465723A31707820736F6C696420236465646564653B6261636B67726F756E643A236666663B637572736F723A706F696E7465723B7472616E736974696F6E3A6261636B67726F756E64202E32737D';
wwv_flow_api.g_varchar2_table(101) := '2E646174657069636B65722D2D74696D652D726F7720696E7075745B747970653D72616E67655D3A3A2D6D732D7468756D627B626F782D73697A696E673A626F726465722D626F783B6865696768743A313270783B77696474683A313270783B626F7264';
wwv_flow_api.g_varchar2_table(102) := '65722D7261646975733A3370783B626F726465723A31707820736F6C696420236465646564653B6261636B67726F756E643A236666663B637572736F723A706F696E7465723B7472616E736974696F6E3A6261636B67726F756E64202E32737D2E646174';
wwv_flow_api.g_varchar2_table(103) := '657069636B65722D2D74696D652D726F7720696E7075745B747970653D72616E67655D3A3A2D7765626B69742D736C696465722D72756E6E61626C652D747261636B7B626F726465723A6E6F6E653B6865696768743A3170783B637572736F723A706F69';
wwv_flow_api.g_varchar2_table(104) := '6E7465723B636F6C6F723A7472616E73706172656E743B6261636B67726F756E643A236366643164337D2E646174657069636B65722D2D74696D652D726F7720696E7075745B747970653D72616E67655D3A3A2D6D6F7A2D72616E67652D747261636B7B';
wwv_flow_api.g_varchar2_table(105) := '626F726465723A6E6F6E653B6865696768743A3170783B637572736F723A706F696E7465723B636F6C6F723A7472616E73706172656E743B6261636B67726F756E643A236366643164337D2E646174657069636B65722D2D74696D652D726F7720696E70';
wwv_flow_api.g_varchar2_table(106) := '75745B747970653D72616E67655D3A3A2D6D732D747261636B7B626F726465723A6E6F6E653B6865696768743A3170783B637572736F723A706F696E7465723B636F6C6F723A7472616E73706172656E743B6261636B67726F756E643A23636664316433';
wwv_flow_api.g_varchar2_table(107) := '7D2E646174657069636B65722D2D74696D652D726F7720696E7075745B747970653D72616E67655D3A3A2D6D732D66696C6C2D6C6F7765727B6261636B67726F756E643A3020307D2E646174657069636B65722D2D74696D652D726F7720696E7075745B';
wwv_flow_api.g_varchar2_table(108) := '747970653D72616E67655D3A3A2D6D732D66696C6C2D75707065727B6261636B67726F756E643A3020307D2E646174657069636B65722D2D74696D652D726F77207370616E7B70616464696E673A3020313270787D2E646174657069636B65722D2D7469';
wwv_flow_api.g_varchar2_table(109) := '6D652D69636F6E7B636F6C6F723A233963396339633B626F726465723A31707820736F6C69643B626F726465722D7261646975733A3530253B666F6E742D73697A653A313670783B706F736974696F6E3A72656C61746976653B6D617267696E3A302035';
wwv_flow_api.g_varchar2_table(110) := '7078202D31707820303B77696474683A31656D3B6865696768743A31656D7D2E646174657069636B65722D2D74696D652D69636F6E3A61667465722C2E646174657069636B65722D2D74696D652D69636F6E3A6265666F72657B636F6E74656E743A2727';
wwv_flow_api.g_varchar2_table(111) := '3B6261636B67726F756E643A63757272656E74436F6C6F723B706F736974696F6E3A6162736F6C7574657D2E646174657069636B65722D2D74696D652D69636F6E3A61667465727B6865696768743A2E34656D3B77696474683A3170783B6C6566743A63';
wwv_flow_api.g_varchar2_table(112) := '616C6328353025202D20317078293B746F703A63616C6328353025202B20317078293B2D7765626B69742D7472616E73666F726D3A7472616E736C61746559282D31303025293B7472616E73666F726D3A7472616E736C61746559282D31303025297D2E';
wwv_flow_api.g_varchar2_table(113) := '646174657069636B65722D2D74696D652D69636F6E3A6265666F72657B77696474683A2E34656D3B6865696768743A3170783B746F703A63616C6328353025202B20317078293B6C6566743A63616C6328353025202D20317078297D2E64617465706963';
wwv_flow_api.g_varchar2_table(114) := '6B65722D2D63656C6C2D6461792E2D6F746865722D6D6F6E74682D2C2E646174657069636B65722D2D63656C6C2D796561722E2D6F746865722D6465636164652D7B636F6C6F723A236465646564657D2E646174657069636B65722D2D63656C6C2D6461';
wwv_flow_api.g_varchar2_table(115) := '792E2D6F746865722D6D6F6E74682D3A686F7665722C2E646174657069636B65722D2D63656C6C2D796561722E2D6F746865722D6465636164652D3A686F7665727B636F6C6F723A236335633563357D2E2D64697361626C65642D2E2D666F6375732D2E';
wwv_flow_api.g_varchar2_table(116) := '646174657069636B65722D2D63656C6C2D6461792E2D6F746865722D6D6F6E74682D2C2E2D64697361626C65642D2E2D666F6375732D2E646174657069636B65722D2D63656C6C2D796561722E2D6F746865722D6465636164652D7B636F6C6F723A2364';
wwv_flow_api.g_varchar2_table(117) := '65646564657D2E2D73656C65637465642D2E646174657069636B65722D2D63656C6C2D6461792E2D6F746865722D6D6F6E74682D2C2E2D73656C65637465642D2E646174657069636B65722D2D63656C6C2D796561722E2D6F746865722D646563616465';
wwv_flow_api.g_varchar2_table(118) := '2D7B636F6C6F723A236666663B6261636B67726F756E643A236132646466367D2E2D73656C65637465642D2E2D666F6375732D2E646174657069636B65722D2D63656C6C2D6461792E2D6F746865722D6D6F6E74682D2C2E2D73656C65637465642D2E2D';
wwv_flow_api.g_varchar2_table(119) := '666F6375732D2E646174657069636B65722D2D63656C6C2D796561722E2D6F746865722D6465636164652D7B6261636B67726F756E643A233861643566347D2E2D696E2D72616E67652D2E646174657069636B65722D2D63656C6C2D6461792E2D6F7468';
wwv_flow_api.g_varchar2_table(120) := '65722D6D6F6E74682D2C2E2D696E2D72616E67652D2E646174657069636B65722D2D63656C6C2D796561722E2D6F746865722D6465636164652D7B6261636B67726F756E642D636F6C6F723A726762612839322C3139362C3233392C2E31293B636F6C6F';
wwv_flow_api.g_varchar2_table(121) := '723A236363637D2E2D696E2D72616E67652D2E2D666F6375732D2E646174657069636B65722D2D63656C6C2D6461792E2D6F746865722D6D6F6E74682D2C2E2D696E2D72616E67652D2E2D666F6375732D2E646174657069636B65722D2D63656C6C2D79';
wwv_flow_api.g_varchar2_table(122) := '6561722E2D6F746865722D6465636164652D7B6261636B67726F756E642D636F6C6F723A726762612839322C3139362C3233392C2E32297D2E646174657069636B65722D2D63656C6C2D6461792E2D6F746865722D6D6F6E74682D3A656D7074792C2E64';
wwv_flow_api.g_varchar2_table(123) := '6174657069636B65722D2D63656C6C2D796561722E2D6F746865722D6465636164652D3A656D7074797B6261636B67726F756E643A3020303B626F726465723A6E6F6E657D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(7474772930424403)
,p_plugin_id=>wwv_flow_api.id(6933619177812799)
,p_file_name=>'css/datepicker.min.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
