CREATE OR REPLACE PACKAGE PKG_YASIR_PLUGINS AS

  FUNCTION F_RENDER_DATE(P_ITEM                IN APEX_PLUGIN.T_PAGE_ITEM,
                         P_PLUGIN              IN APEX_PLUGIN.T_PLUGIN,
                         P_VALUE               IN VARCHAR2,
                         P_IS_READONLY         IN BOOLEAN,
                         P_IS_PRINTER_FRIENDLY IN BOOLEAN)
  
   RETURN APEX_PLUGIN.T_PAGE_ITEM_RENDER_RESULT;

  FUNCTION f_validate_from_to_datepicker(p_item   IN apex_plugin.t_page_item,
                                         p_plugin IN apex_plugin.t_plugin,
                                         p_value  IN VARCHAR2)
    RETURN apex_plugin.t_page_item_validation_result;

END PKG_YASIR_PLUGINS;
/
CREATE OR REPLACE PACKAGE BODY PKG_YASIR_PLUGINS AS

  FUNCTION F_RENDER_DATE(P_ITEM                IN APEX_PLUGIN.T_PAGE_ITEM,
                         P_PLUGIN              IN APEX_PLUGIN.T_PLUGIN,
                         P_VALUE               IN VARCHAR2,
                         P_IS_READONLY         IN BOOLEAN,
                         P_IS_PRINTER_FRIENDLY IN BOOLEAN)
  
   RETURN APEX_PLUGIN.T_PAGE_ITEM_RENDER_RESULT AS
  
    -- Main plug-in variables
    V_RESULT APEX_PLUGIN.T_PAGE_ITEM_RENDER_RESULT; -- Result object to be returned
  
    -- APEX information
    V_APP_ID  APEX_APPLICATIONS.APPLICATION_ID%TYPE := V('APP_ID');
    V_PAGE_ID APEX_APPLICATION_PAGES.PAGE_ID%TYPE := V('APP_PAGE_ID');
  
    -- If a page item saves state, we have to call the
    -- get_input_name_for_page_item to render the internal
    -- hidden p_arg_names field. It will also return the
    -- HTML field name which we have to use when we render
    -- the HTML input field.
    V_PAGE_ITEM_NAME VARCHAR2(200);
    V_ESCAPED_VALUE  VARCHAR2(32767);
  
    V_HTML VARCHAR2(32767); -- Used for temp HTML    
  
    /*
    
      id                          number,
    name                        varchar2(255),
    label                       varchar2(4000),
    plain_label                 varchar2(4000),
    label_id                    varchar2(255), /* label id is set if "Standard Form Element" = no and label template uses #LABEL_ID# substitution */
    /*  placeholder                 varchar2(255),
      format_mask                 varchar2(255),
      is_required                 boolean,
      lov_definition              varchar2(4000),
      lov_display_extra           boolean,
      lov_display_null            boolean,
      lov_null_text               varchar2(255),
      lov_null_value              varchar2(255),
      lov_cascade_parent_items    varchar2(255),
      ajax_items_to_submit        varchar2(255),
      ajax_optimize_refresh       boolean,
      element_width               number,
      element_max_length          number,
      element_height              number,
      element_css_classes         varchar2(255),
      element_attributes          varchar2(2000),
      element_option_attributes   varchar2(4000),
      escape_output               boolean,
    
    
    */
  
    -- Application Plugin Attributes
    ---===============================
    v_button_img apex_appl_plugins.attribute_01%type := p_plugin.attribute_01;
  
    -- Item Plugin Attributes
    ---===============================
    -- assign local names to attributes
    -- get the values of the custom item type attributes
    subtype attr is apex_application_page_items.attribute_01%type;
  
    v_date_picker_type       attr := p_item.attribute_01;
    v_To_date_item_Name      attr := p_item.attribute_02;
    v_firstDay               attr := p_item.attribute_03;
    v_weekends               attr := p_item.attribute_04;
    v_minDate                attr := p_item.attribute_05;
    v_maxDate                attr := p_item.attribute_06;
    v_minHours               attr := p_item.attribute_07;
    v_maxHours               attr := p_item.attribute_08;
    v_multipleDatesSeparator attr := p_item.attribute_09;
    v_dateTimeSeparator      attr := p_item.attribute_10;
    v_inline                 attr := p_item.attribute_11;
    v_position               attr := p_item.attribute_12;
    v_navTitles              attr := p_item.attribute_13;
    v_todayClearButton       attr := p_item.attribute_14;
    v_language               attr := p_item.attribute_15;
  
    /* 
    v_dateFormat             attr := p_item.attribute_03;
     v_timeFormat             attr := p_item.attribute_13;*/
  
    --Name of other date picker item
  
    -- Other variables 
    -- Oracle date formats different from JS date formats 
    v_orcl_date_format_mask     p_item.format_mask%type; -- Oracle date format: http://www.techonthenet.com/oracle/functions/to_date.php 
    v_js_date_format_mask       p_item.format_mask%type; -- JS date format: http://docs.jquery.com/UI/Datepicker/formatDate 
    v_other_js_date_format_mask apex_application_page_items.format_mask%type; -- This is the other datepicker's JS date format. Required since it may not contain the same format mask as this date picker
    v_date_str VARCHAR2(100);
  BEGIN
    -- Debug information (if app is being run in debug mode)
    IF APEX_APPLICATION.G_DEBUG THEN
      APEX_PLUGIN_UTIL.DEBUG_PAGE_ITEM(P_PLUGIN              => P_PLUGIN,
                                       P_PAGE_ITEM           => P_ITEM,
                                       P_VALUE               => P_VALUE,
                                       P_IS_READONLY         => P_IS_READONLY,
                                       P_IS_PRINTER_FRIENDLY => P_IS_PRINTER_FRIENDLY);
    END IF;
  
    -- handle read only and printer friendly 
    IF P_IS_READONLY OR P_IS_PRINTER_FRIENDLY THEN
      -- omit hidden field if necessary
      APEX_PLUGIN_UTIL.PRINT_HIDDEN_IF_READONLY(P_ITEM_NAME           => P_ITEM.NAME,
                                                P_VALUE               => P_VALUE,
                                                P_IS_READONLY         => P_IS_READONLY,
                                                P_IS_PRINTER_FRIENDLY => P_IS_PRINTER_FRIENDLY);
      -- omit display span with the value
      APEX_PLUGIN_UTIL.PRINT_DISPLAY_ONLY(P_ITEM_NAME        => P_ITEM.NAME,
                                          P_DISPLAY_VALUE    => P_VALUE,
                                          P_SHOW_LINE_BREAKS => FALSE,
                                          P_ESCAPE           => TRUE, -- this is recommended to help prevent XSS
                                          P_ATTRIBUTES       => P_ITEM.ELEMENT_ATTRIBUTES);
    ELSE
    
      -- Print input element 
      -- If a page item saves state, we have to call the 
      -- get_input_name_for_page_item to render the internal 
      -- hidden p_arg_names field. It will also return the
      -- HTML field name which we have to use when we render
      -- the HTML input field.
      ---- Item name (different than ID)
      V_PAGE_ITEM_NAME := APEX_PLUGIN.GET_INPUT_NAME_FOR_PAGE_ITEM(FALSE);
      -- Only use escaped value for the HTML output!      
      V_ESCAPED_VALUE := SYS.HTF.ESCAPE_SC(P_VALUE);
    
      V_HTML := '<input type="text" id="%ID%" name="%NAME%" value="%VALUE%" autocomplete="off" size="%WIDTH%" ' ||
                'maxlength="%MAX_LEN%"  placeholder="%PLACEHOLDER%" ';
      --data-todate="Y"      
      IF v_date_picker_type in (2, 5) THEN
        V_HTML := V_HTML || ' data-otheritem="%OTHERITEM%" ';
      END IF;
      V_HTML := V_HTML ||
                COALESCE(P_ITEM.ELEMENT_ATTRIBUTES, 'class="x-form-text"') ||
                ' />';
    
      V_HTML := REPLACE(V_HTML, '%ID%', P_ITEM.NAME);
      V_HTML := REPLACE(V_HTML, '%NAME%', V_PAGE_ITEM_NAME);
      V_HTML := REPLACE(V_HTML, '%VALUE%', V_ESCAPED_VALUE);
      -- V_HTML := REPLACE(V_HTML, '%WIDTH%', P_ITEM.ELEMENT_WIDTH);
      -- V_HTML := REPLACE(V_HTML, '%WIDTH%',  coalesce(p_item.element_width,'50'));
      --V_HTML := REPLACE(V_HTML, '%WIDTH%', '100');
      V_HTML := REPLACE(V_HTML, '%MAX_LEN%', P_ITEM.ELEMENT_MAX_LENGTH);
      V_HTML := REPLACE(V_HTML, '%PLACEHOLDER%', P_ITEM.placeholder);
      V_HTML := REPLACE(V_HTML, '%OTHERITEM%', v_To_date_item_Name);
    
      SYS.HTP.P(V_HTML);
      V_HTML := '';
      /*SYS.HTP.P('
      <input id="' || P_ITEM.NAME || '" type="text" name="' ||
                    L_NAME || '" value="' || P_VALUE || '" />');
        */
    
      -- ****************************************************
      -- @todo - 
      -- ****************************************************
    
      -- ***********************************
      -- Here write code for widget,actual plug-in here 
      -- ***********************************
      -- Register the javascript library the plug-in uses.
      -- The add_library call will make sure that just one instance of the
      -- library is loaded when the plug-in is used multiple times on the page.
      -- If the developer stores the javascript file on the web-server, the
      -- p_plugin.file_prefix will contain the web-server URL. If the variable
      -- contains #PLUGIN_PREFIX#, the file will be read from the database.
      /*   APEX_CSS.ADD_FILE(P_NAME      => 'datepicker.min',
                        P_DIRECTORY => P_PLUGIN.FILE_PREFIX,
                        P_VERSION   => NULL);
      APEX_JAVASCRIPT.ADD_LIBRARY(P_NAME      => 'datepicker.min',
                                  P_DIRECTORY => P_PLUGIN.FILE_PREFIX,
                                  P_VERSION   => NULL);
      
      APEX_JAVASCRIPT.ADD_LIBRARY(P_NAME      => 'datepicker.en',
                                  P_DIRECTORY => P_PLUGIN.FILE_PREFIX,
                                  P_VERSION   => NULL);*/
    
      -- Initialize page item when the page has been rendered.    
      --========================================= 
    
      ---Preparing Basic Template DatePicker
      --===================================================================
    
      --this creates a javascript obj {name:"aseel","type":"dog"}
    
      -- SET VALUES 
      -- If no format mask is defined, use the system-level date format 
      v_orcl_date_format_mask := nvl(p_item.format_mask,
                                     sys_context('userenv',
                                                 'nls_date_format'));
      -- Convert the Oracle date format to JS format mask 
      v_js_date_format_mask := wwv_flow_utilities.get_javascript_date_format(p_format => v_orcl_date_format_mask);
    
      if v_js_date_format_mask IS NOT NULL THEN
        V_HTML := V_HTML ||
                  apex_javascript.add_attribute('dateFormat',
                                                v_js_date_format_mask);
      END IF;
    
    
    Declare
  l_bool boolean;
  l_str  varchar2(200);
  l_date date;
  v_minDate varchar2(200) := 'sysdate';
  v_orcl_date_format_mask varchar2(100):= 'MM/DD/RRRR';

BEgin

  --‎new Date('17-Feb-17')  
        EXECUTE IMMEDIATE q'[SELECT :IN_DATE FROM dual]'
          INTO l_str
          USING v_minDate; --,v_orcl_date_format_mask;
      

  -- l_bool := wwv_flow_load_data.is_date(p_string => 'SYSDATE');
  dbms_output.put_line(l_str);
end;
    
    
      if v_firstDay IS NOT NULL THEN
        V_HTML := V_HTML ||
                  apex_javascript.add_attribute('firstDay', v_firstDay - 1);
      END IF;
    
      if v_weekends IS NOT NULL THEN
        V_HTML := V_HTML ||
                  apex_javascript.add_attribute('weekends', v_weekends);
      END IF;
    
      if v_minDate IS NOT NULL THEN
      
        -- v_js_date_format_mask := wwv_flow_utilities.get_javascript_date_format(p_format => v_orcl_date_format_mask);
        --‎new Date('17-Feb-17')  
        EXECUTE IMMEDIATE 'SELECT to_date(:IN_MIN_DATE,:IN_FORMAT_MASK) FROM dual'
          INTO v_date_str
          USING v_minDate,v_orcl_date_format_mask;
      
        V_HTML := V_HTML || 'minDate:‎new Date(' || v_date_str || '),';
      
        --  V_HTML := V_HTML ||  apex_javascript.add_attribute('minDate', v_minDate);
      
      END IF;
    
      if v_maxDate IS NOT NULL THEN
        V_HTML := V_HTML ||
                  apex_javascript.add_attribute('maxDate', v_maxDate);
      END IF;
    
      if v_inline IS NOT NULL THEN
        V_HTML := V_HTML || apex_javascript.add_attribute('inline', TRUE);
      end if;
    
      if v_position IS NOT NULL THEN
        V_HTML := V_HTML ||
                  apex_javascript.add_attribute('position', v_position);
      end if;
    
      if v_navTitles IS NOT NULL THEN
        V_HTML := V_HTML || 'navTitles: {' || v_navTitles || '},';
      end if;
    
      IF v_todayClearButton IS NOT NULL THEN
        V_HTML := 'todayButton: new Date(),';
      
        V_HTML := V_HTML ||
                  apex_javascript.add_attribute('clearButton',
                                                v_todayClearButton);
      
      END IF;
    
      if v_language IS NOT NULL THEN
        V_HTML := V_HTML ||
                  apex_javascript.add_attribute('language', v_language);
      end if;
    
      if p_item.element_css_classes IS NOT NULL THEN
        V_HTML := V_HTML ||
                  apex_javascript.add_attribute('classes',
                                                p_item.element_css_classes);
      end if;
    
      --use last parameter combination FALSE (p_omit_null), FALSE (p_add_comma) 
      --so that the last attribute is always generated. This avoids that you 
      --have to check for the other parameters if a trailing comma should be added or not
    
      ---For Simple Date Picker
      --===================================================================
      /*  V_HTML := 'apex.jQuery("#' || P_ITEM.NAME ||
      '").datepicker({language: "' || v_language ||
      '",todayButton: new Date(),clearButton:true,showOtherMonths:true,' ||
      'navTitles:{days:"<h3>Check in date:</h3> MM, yyyy"}});' ||
      ' apex.jQuery("#' || P_ITEM.NAME ||
      '").data("datepicker");';*/
    
      /*  
      2 Date[Range]
      3 Date[Multiple]      
      4 Date[Simple] with Time
      5 Date[Range]  with Time
      5 Date[Multiple] with Time*/
    
      CASE v_date_picker_type
        WHEN 1 THEN
        
          V_HTML := V_HTML ||
                    apex_javascript.add_attribute('autoClose', true);
        
        WHEN 2 THEN
        
          V_HTML := V_HTML || apex_javascript.add_attribute('range', true);
          if v_dateTimeSeparator IS NOT NULL THEN
            V_HTML := V_HTML ||
                      apex_javascript.add_attribute('dateTimeSeparator',
                                                    v_dateTimeSeparator);
          END IF;
        
          -- Get the corresponding date picker's format mask       
          select wwv_flow_utilities.get_javascript_date_format(p_format => nvl(max(format_mask),
                                                                               sys_context('userenv',
                                                                                           'nls_date_format')))
            into v_other_js_date_format_mask
            from apex_application_page_items
           where application_id = v_app_id
             and page_id = v_page_id
             and item_name = upper(v_To_date_item_Name);
        
        WHEN 3 THEN
          V_HTML := V_HTML ||
                    apex_javascript.add_attribute('autoClose', true);
          V_HTML := V_HTML ||
                    apex_javascript.add_attribute('multipleDates', 10);
        
          if v_multipleDatesSeparator IS NOT NULL THEN
            V_HTML := V_HTML ||
                      apex_javascript.add_attribute('multipleDatesSeparator',
                                                    v_multipleDatesSeparator);
          END IF;
          if v_dateTimeSeparator IS NOT NULL THEN
            V_HTML := V_HTML ||
                      apex_javascript.add_attribute('dateTimeSeparator',
                                                    v_dateTimeSeparator);
          END IF;
        WHEN 4 THEN
        
          /* timepicker
          timeFormat
          dateTimeSeparator
          minHours
          maxHours
          minMinutes
          maxMinutes
          hoursStep*/
        
          V_HTML := V_HTML ||
                    apex_javascript.add_attribute('timepicker', true);
          if v_dateTimeSeparator IS NOT NULL THEN
            V_HTML := V_HTML ||
                      apex_javascript.add_attribute('dateTimeSeparator',
                                                    v_dateTimeSeparator);
          END IF;
        WHEN 5 THEN
        
          /* timepicker
          timeFormat
          dateTimeSeparator
          minHours
          maxHours
          minMinutes
          maxMinutes
          hoursStep*/
        
          V_HTML := V_HTML || apex_javascript.add_attribute('range', true);
        
          V_HTML := V_HTML ||
                    apex_javascript.add_attribute('timepicker', true);
        
          if v_multipleDatesSeparator IS NOT NULL THEN
            V_HTML := V_HTML ||
                      apex_javascript.add_attribute('multipleDatesSeparator',
                                                    v_multipleDatesSeparator);
          END IF;
          if v_dateTimeSeparator IS NOT NULL THEN
            V_HTML := V_HTML ||
                      apex_javascript.add_attribute('dateTimeSeparator',
                                                    v_dateTimeSeparator);
          END IF;
        
          -- Get the corresponding date picker's format mask       
          select wwv_flow_utilities.get_javascript_date_format(p_format => nvl(max(format_mask),
                                                                               sys_context('userenv',
                                                                                           'nls_date_format')))
            into v_other_js_date_format_mask
            from apex_application_page_items
           where application_id = v_app_id
             and page_id = v_page_id
             and item_name = upper(v_To_date_item_Name);
        
      END CASE;
    
      V_HTML := V_HTML ||
                apex_javascript.add_attribute('language',
                                              'en',
                                              p_omit_null => FALSE,
                                              p_add_comma => FALSE);
    
      /*V_HTML := 'apex.jQuery("#' || P_ITEM.NAME || '").datepicker({' ||
      V_HTML || '});' || ' apex.jQuery("#' || P_ITEM.NAME ||
      '").data("datepicker");';*/
    
      V_HTML := 'apex.jQuery("#' || P_ITEM.NAME || '").datepicker({' ||
                V_HTML || '}); ';
    
      APEX_JAVASCRIPT.ADD_ONLOAD_CODE(P_CODE => V_HTML);
    
      -- Tell APEX engine that field is navigable, in case
      -- it's the first item on the page, and APEX page is
      -- configured to navigate to first item (by default).
      V_RESULT.IS_NAVIGABLE := TRUE;
    END IF; -- f_render_from_to_datepicker
    RETURN V_RESULT;
  END F_RENDER_DATE;

  FUNCTION f_validate_from_to_datepicker(p_item   IN apex_plugin.t_page_item,
                                         p_plugin IN apex_plugin.t_plugin,
                                         p_value  IN VARCHAR2)
    RETURN apex_plugin.t_page_item_validation_result AS
    -- Variables 
    v_orcl_date_format apex_application_page_items.format_mask%type; -- oracle date format 
    v_date             date;
    -- Other attributes 
    v_other_orcl_date_format apex_application_page_items.format_mask%type;
    v_other_date             date;
    v_other_label            apex_application_page_items.label%type;
    v_other_item_val         varchar2(255);
    -- APEX information 
    v_app_id  apex_applications.application_id%type := v('APP_ID');
    v_page_id apex_application_pages.page_id%type := v('APP_PAGE_ID');
    -- Item Plugin Attributes 
    --==================================
    subtype attr is apex_application_page_items.attribute_01%type;
    v_date_picker_type attr := lower(p_item.attribute_02); -- from/to 
    v_other_item       attr := upper(p_item.attribute_03); -- item               name of other date picker
    -- Return 
    v_result apex_plugin.t_page_item_validation_result;
  BEGIN
    -- Debug information (if app is being run in debug mode) 
    IF apex_application.g_debug THEN
      apex_plugin_util.debug_page_item(p_plugin              => p_plugin,
                                       p_page_item           => p_item,
                                       p_value               => p_value,
                                       p_is_readonly         => FALSE,
                                       p_is_printer_friendly => FALSE);
    END IF;
    -- If no value then nothing to validate 
    --====================================================
    ---since each item has a general APEX attribute called Value Required, which will handle null entries
  
    IF p_value IS NULL THEN
      RETURN v_result;
    END IF;
  
    -- Check that it's a valid date 
    --========================================
    /*  
    *If you do not include this, error message will not include the name of the item. 
    *If error message  displayed in notification area, difficult for user where the error occurred. 
    *set error message location in v_result object by setting the display_location attribute. 
        not set => application’s default display location. 
       set  default location, go to Shared Components  Edit Definition and scroll to the Error Handling region,
    
    */
    SELECT nvl(MAX(format_mask), sys_context('userenv', 'nls_date_format'))
      INTO v_orcl_date_format
      FROM apex_application_page_items
     WHERE item_id = p_item.ID;
  
    IF NOT wwv_flow_utilities.is_date(p_date   => p_value,
                                      p_format => v_orcl_date_format) THEN
      v_result.message := '#LABEL# Invalid date';
      RETURN v_result;
    ELSE
      v_date := to_date(p_value, v_orcl_date_format);
    END IF;
  
    -- Check that from/to date have valid date range 
    -- Only do this for From dates 
    --=========================================================
  
    -- At this point the date exists and is valid. 
    -- Only check for "from" dates so error message appears once 
    IF v_date_picker_type in (2, 5) THEN
      IF LENGTH(v(v_other_item)) > 0 THEN
        SELECT nvl(MAX(format_mask),
                   sys_context('userenv', 'nls_date_format')),
               MAX(label)
          INTO v_other_orcl_date_format, v_other_label
          FROM apex_application_page_items
         WHERE application_id = v_app_id
           AND page_id = v_page_id
           AND item_name = upper(v_other_item);
        v_other_item_val := v(v_other_item);
        IF wwv_flow_utilities.is_date(p_date   => v_other_item_val,
                                      p_format => v_other_orcl_date_format) THEN
          v_other_date := to_date(v_other_item_val,
                                  v_other_orcl_date_format);
        END IF;
      END IF;
      -- If other date is not valid or does not exist, then no stop validation. 
      IF v_other_date IS NULL THEN
        RETURN v_result;
      END IF;
      -- Can now compare min/max range. 
      -- Remember "this" date is the from date. "other" date is the to date 
      IF v_date > v_other_date THEN
        v_result.message          := '#LABEL# must be less than or equal to ' ||
                                     v_other_label;
        v_result.display_location := apex_plugin.c_inline_in_notification; -- Force to display inline only
        RETURN v_result;
      END IF;
    END IF; -- v_date_picker_type = from 
  
    -- No errors 
    RETURN v_result;
  END f_validate_from_to_datepicker;

END PKG_YASIR_PLUGINS;
/
