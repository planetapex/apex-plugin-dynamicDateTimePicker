CREATE OR REPLACE PACKAGE PKG_YASIR_PLUGINS AS

  FUNCTION F_RENDER_DATE(P_ITEM                IN APEX_PLUGIN.T_PAGE_ITEM,
                         P_PLUGIN              IN APEX_PLUGIN.T_PLUGIN,
                         P_VALUE               IN VARCHAR2,
                         P_IS_READONLY         IN BOOLEAN,
                         P_IS_PRINTER_FRIENDLY IN BOOLEAN)
  
   RETURN APEX_PLUGIN.T_PAGE_ITEM_RENDER_RESULT;

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
  
    -- Application Plugin Attributes
    ---===============================
    v_button_img apex_appl_plugins.attribute_01%type := p_plugin.attribute_01;
  
    -- Item Plugin Attributes
    ---===============================
    -- assign local names to attributes
    -- get the values of the custom item type attributes
    subtype attr is apex_application_page_items.attribute_01%type;
  
    v_language    attr := p_item.attribute_03; -- Name of other date picker item 
    v_startDate   attr := p_item.attribute_03; -- Name of other date picker item 
    v_firstDay    attr := p_item.attribute_13; -- When to show date picker. Options: focus, button, both 
    v_weekends    attr := p_item.attribute_02; -- from or to 
    v_minDate     attr := p_item.attribute_03; -- Name of other date picker item 
    v_maxDate     attr := p_item.attribute_13; -- When to show date picker. Options: focus, button, both 
    v_navTitles   attr := p_item.attribute_02; -- from or to 
    v_todayButton attr := p_item.attribute_13; -- When to show date picker. Options: focus, button, both 
    v_clearButton attr := p_item.attribute_02; -- from or to
  
    v_date_picker_type attr := lower(p_item.attribute_02); -- from or to 
    v_other_item       attr := upper(p_item.attribute_03); -- Name of other date picker item 
  
    -- Other variables 
    -- Oracle date formats different from JS date formats 
    v_orcl_date_format_mask     p_item.format_mask%type; -- Oracle date format: http://www.techonthenet.com/oracle/functions/to_date.php 
    v_js_date_format_mask       p_item.format_mask%type; -- JS date format: http://docs.jquery.com/UI/Datepicker/formatDate 
    v_other_js_date_format_mask apex_application_page_items.format_mask%type; -- This is the other datepicker's JS date format. Required since it may not contain the same format mask as this date picker
  
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
                'maxlength="%MAX_LEN%" ' ||
                COALESCE(P_ITEM.ELEMENT_ATTRIBUTES, 'class="x-form-text"') ||
                ' />';
    
      V_HTML := REPLACE(V_HTML, '%ID%', P_ITEM.NAME);
      V_HTML := REPLACE(V_HTML, '%NAME%', V_PAGE_ITEM_NAME);
      V_HTML := REPLACE(V_HTML, '%VALUE%', V_ESCAPED_VALUE);
      -- V_HTML := REPLACE(V_HTML, '%WIDTH%', P_ITEM.ELEMENT_WIDTH);
      V_HTML := REPLACE(V_HTML, '%WIDTH%', '100');
      V_HTML := REPLACE(V_HTML, '%MAX_LEN%', P_ITEM.ELEMENT_MAX_LENGTH);
    
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
    
      -- SET VALUES 
      -- If no format mask is defined, use the system-level date format 
      v_orcl_date_format_mask := nvl(p_item.format_mask,
                                     sys_context('userenv',
                                                 'nls_date_format'));
      -- Convert the Oracle date format to JS format mask 
      v_js_date_format_mask := wwv_flow_utilities.get_javascript_date_format(p_format => v_orcl_date_format_mask);
    
      -- Get the corresponding date picker's format mask       
      select wwv_flow_utilities.get_javascript_date_format(p_format => nvl(max(format_mask),
                                                                           sys_context('userenv',
                                                                                       'nls_date_format')))
        into v_other_js_date_format_mask
        from apex_application_page_items
       where application_id = v_app_id
         and page_id = v_page_id
         and item_name = upper(v_other_item);
      --this creates a javascript obj {name:"aseel","type":"dog"}
    
      ---Preparing Basic Template DatePicker
      --===================================================================
    
      V_HTML := apex_javascript.add_attribute('language', v_language) ||
                apex_javascript.add_attribute('startDate', v_startDate) ||
                apex_javascript.add_attribute('firstDay', v_firstDay) ||
                apex_javascript.add_attribute('weekends', v_weekends) ||
                apex_javascript.add_attribute('minDate', v_minDate) ||
                apex_javascript.add_attribute('maxDate', v_maxDate) ||
                apex_javascript.add_attribute('navTitles', v_navTitles) ||
                apex_javascript.add_attribute('todayButton', v_todayButton) ||
                apex_javascript.add_attribute('clearButton',
                                              v_clearButton,
                                              p_omit_null   => FALSE,
                                              p_add_comma   => FALSE);
      --- apex_javascript.add_attribute('view', v_language) ||
      --- apex_javascript.add_attribute('minView',
      -- v_language, p_omit_null => FALSE, p_add_comma => FALSE);
    
      ---For Simple Date Picker
      --===================================================================
    
      --use last parameter combination FALSE (p_omit_null), FALSE (p_add_comma) 
      --so that the last attribute is always generated. This avoids that you 
      --have to check for the other parameters if a trailing comma should be added or not
    
      V_HTML := 'apex.jQuery("#' || P_ITEM.NAME ||
                '").datepicker({language: "' || v_language ||
                '",todayButton: new Date(),clearButton:true,showOtherMonths:true,' ||
                'navTitles:{days:"<h3>Check in date:</h3> MM, yyyy"}});' ||
                ' apex.jQuery("#' || P_ITEM.NAME ||
                '").data("datepicker");';
      APEX_JAVASCRIPT.ADD_ONLOAD_CODE(P_CODE => V_HTML);
    
      -- Tell APEX engine that field is navigable, in case
      -- it's the first item on the page, and APEX page is
      -- configured to navigate to first item (by default).
      V_RESULT.IS_NAVIGABLE := TRUE;
    END IF; -- f_render_from_to_datepicker
    RETURN V_RESULT;
  END F_RENDER_DATE;

END PKG_YASIR_PLUGINS;
/
