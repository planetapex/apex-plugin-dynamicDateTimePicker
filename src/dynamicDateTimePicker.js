(function($, widget) {
  $.widget('ui.dynamicDateTimePicker', {
    // default options
    options: {
      dateItemID: '',
      dateToItem: null,
      desktopUI: true,
      dateTimeSplit: false,
      readOnly: false,
      showMethod: null,
      todayBtnText: null,
      classes: '',
      inline: false,
      language: 'en',
      firstDay: '',
      weekends: [6, 0],
      dateFormat: '',
      toggleSelected: true,
      keyboardNav: true,
      position: 'bottom left',
      offset: 12,
      view: 'days',
      minView: 'days',
      showOtherMonths: true,
      selectOtherMonths: true,
      moveToOtherMonthsOnSelect: true,
      showOtherYears: true,
      selectOtherYears: true,
      moveToOtherYearsOnSelect: true,
      minDate: '',
      maxDate: '',
      disableNavWhenOutOfRange: true,
      multipleDates: false, // Boolean or Number
      multipleDatesSeparator: ',',
      range: false,
      todayButton: false,
      clearButton: false,
      autoClose: false,
      // navigation      
      navTitles: {
        days: 'MM, <i>yyyy</i>',
        months: 'yyyy',
        years: 'yyyy1 - yyyy2'
      },

      // timepicker
      timepicker: false,
      onlyTimepicker: false,
      dateTimeSeparator: ' ',
      timeFormat: '',
      minHours: 0,
      maxHours: 24,
      minMinutes: 0,
      maxMinutes: 59,
      hoursStep: 1,
      minutesStep: 1,

      // events
      onSelect: '',
      onShow: '',
      onHide: '',
      onChangeMonth: '',
      onChangeYear: '',
      onChangeDecade: '',
      onChangeView: '',
      onRenderCell: ''
    },

    /**
     * Set private widget varables
     */
    _setWidgetVars: function() {


      if (this.options.desktopUI == true) {
        this.apex = {
          item: this.element,
          $elm: $(this.element),
          toItem: $(document.getElementById(this.options.dateToItem)), //$('#'+this.options.dateToItem),
          datepickerButton: this.element.nextAll('button').first(),
          datepickerToButton: $(document.getElementById(this.options.dateToItem)).nextAll('button').first(),
          picker: null,
          toPicker: null
        };
      } else {
        this.apex = {
          item: this.element,
          $elm: $(this.element),
          toItem: $(document.getElementById(this.options.dateToItem)), //$('#'+this.options.dateToItem),
          picker: null,
          toPicker: null
        };
      }



      this.dateTo = {
        item: $(this.options.dateToItem),
        datepickerButton: null
      };

      this._scope = 'ui.dynamicDateTimePicker'; //For debugging


    }, //_setWidgetVars



    /**
     * Init function. This function will be called each time the widget is referenced with no parameters
     */
    _init: function() {

      //For this plug-in there's no code required for this section
      //Left here for demonstration purposes
      apex.debug.log(this._scope, '_init', this);
    }, //_init



    /**
     * Create function: Called the first time widget is associated to the object
     * Does all the required setup etc and binds change event
     */
    _create: function() {

      if (this.options.dateToItem && this.options.readOnly) {
        $('#' + this.options.dateToItem).prop("readonly", true);

      }

      if (this.options.dateToItem != null && this.options.desktopUI  && (this.options.range  || this.options.dateTimeSplit)) {
        $('#' + this.options.dateToItem).after('<button type="button" class="dyndatepicker-trigger a-Button a-Button--calendar">' +
          '<span class="a-Icon icon-calendar"></span></button>');

      }


      this._setWidgetVars();

      var consoleGroupName = this._scope + '_create';

      apex.debug.log('this:', this);

      var
        otherDate,
        minDate = '',
        maxDate = '';


      //Register DatePicker



      apex.debug.log('element:', this.apex.item);

      if (this.options.position == 'right bottom' || this.options.position == 'right top') {
        this.options.offset = 47;
      }


      this.options.onSelect = function(fd, date, o) {

        if (o.opts.dateToItem != null && o.opts.range ) {

          $('#' + o.opts.dateItemID).val(fd.split(o.opts.multipleDatesSeparator)[0]);

          $('#' + o.opts.dateToItem).val(fd.substring(fd.split(o.opts.multipleDatesSeparator)[0].length + 1, fd.length));


        } else if (o.opts.dateToItem != null && o.opts.dateTimeSplit ) {

          $('#' + o.el.id).val(fd.split(o.opts.dateTimeSeparator)[0]);
          $('#' + o.opts.dateToItem).val(fd.substring(fd.split(o.opts.dateTimeSeparator)[0].length + 1, fd.length));


        }

        var extraParams = {
            fd: fd,
            date: date,
            inst: o
          },
          $this = $('#' + o.el.id);
        $this.trigger('onselect', extraParams);
        //apex.event.trigger(document.getElementById(o.el.id), 'onselect',extraParams);
        //$this.trigger('plugineventonselect', extraParams);


      };


      this.options.onShow = function(o, animationCompleted) {

        var extraParams = {
            inst: o,
            animationCompleted: animationCompleted
          },
          $this = $('#' + o.el.id);

        if (animationCompleted) {
          $this.trigger('onshow', extraParams);
          //apex.event.trigger(document.getElementById(o.el.id), 'onshow');
        }

      }
      this.options.onHide = function(o, animationCompleted) {
        var extraParams = {
            inst: o,
            animationCompleted: animationCompleted
          },
          $this = $('#' + o.el.id);


        if (animationCompleted) {
          $this.trigger('onhide', extraParams);
          //apex.event.trigger(document.getElementById(o.el.id), 'onhide');
        }
      }
      this.options.onChangeMonth = function(month, year) {

        var extraParams = {
            month: month,
            year: year,
            inst: this
          },
          $this = $('#' + this.dateItemID);
        $this.trigger('onchangemonth', extraParams);
        //apex.event.trigger(document.getElementById(this.dateItemID), 'onchangemonth');
      }
      this.options.onChangeYear = function(year) {
        var extraParams = {
            year: year,
            inst: this
          },
          $this = $('#' + this.dateItemID);
        $this.trigger('onchangeyear', extraParams);
        //apex.event.trigger(document.getElementById(this.dateItemID), 'onchangeyear');
      }
      this.options.onChangeDecade = function(decade) {
        var extraParams = {
            decade: decade,
            inst: this
          },
          $this = $('#' + this.dateItemID);
        $this.trigger('onchangedecade', extraParams);
        //apex.event.trigger(document.getElementById(this.dateItemID), 'onchangedecade');
      }
      this.options.onChangeView = function(view) {
        var extraParams = {
            view: view,
            inst: this
          },
          $this = $('#' + this.dateItemID);
        $this.trigger('onchangeview', extraParams);
        // apex.event.trigger(document.getElementById(this.dateItemID), 'onchangeview');
      }

      this.options.onRenderCell = function(date, cellType) {
        var extraParams = {
            date: date,
            cellType: cellType,
            inst: this
          },
          $this = $('#' + this.dateItemID);
        $this.trigger('onrendercell', extraParams);
        //apex.event.trigger(document.getElementById(this.dateItemID), 'onrendercell');

      }

      this.options.showEvent = '';

      this.apex.picker = this.apex.item.datepicker(this.options, function(start, end, label) {
        //console.log('---Callback function---');
      }).data('datepicker');



      if (this.options.dateToItem != null && this.options.range && this.options.inline  && this.options.desktopUI ) {
        $('#' + this.options.dateItemID).after('<button type="button" class="dyndatepicker-trigger a-Button a-Button--calendar">' +
          '<span class="a-Icon icon-calendar"></span></button>');
      }

      // event handling
      //==========================================================================================

      if (this.options.showMethod == 'click') {
        this.apex.item.on('click', $.proxy(this._nativeShowPicker, this));
        this.apex.toItem.on('click', $.proxy(this._nativeShowPicker, this));

      } else if (this.options.showMethod == 'icon' && this.options.desktopUI ) {
        this.apex.datepickerButton.on('click', $.proxy(this._nativeShowPicker, this));
        this.apex.datepickerToButton.on('click', $.proxy(this._nativeShowPicker, this));

      } else if (this.options.showMethod == 'clickicon') {
        this.apex.item.on('click', $.proxy(this._nativeShowPicker, this));
        this.apex.toItem.on('click', $.proxy(this._nativeShowPicker, this));

        if (this.options.desktopUI ) {
          this.apex.datepickerButton.on('click', $.proxy(this._nativeShowPicker, this));
          this.apex.datepickerToButton.on('click', $.proxy(this._nativeShowPicker, this));

        }


      } else if (this.options.showMethod == 'focus') {
        this.apex.item.on('focus', $.proxy(this._nativeShowPicker, this));


      } else if (this.options.showMethod == 'mouseenter') {
        this.apex.item.on('mouseenter', $.proxy(this._nativeShowPicker, this));
        this.apex.datepickerButton.on('mouseenter', $.proxy(this._nativeShowPicker, this));
      }



      this._apex_da(this.apex);

    }, //_create



    _nativeShowPicker: function() {
      //console.log('_nativeShowPicker')

      if (this.apex.item.is('.disabled')) {
        return false;
      }
      this.apex.picker.show();
    },

    _nativePickerHide: function() {
      if (this.apex.item.is('.disabled')) {
        return false;
      }
      this.apex.picker.hide();
    },



    _apex_da: function(daElem) {
      //console.log( daElem.attr('id') );
      var
        pName = daElem.item.attr('id'),

        pOptions = {
          enable: function() {
            daElem.item
              .dynamicDateTimePicker('enable') // call native jQuery UI enable
              .removeClass('apex_disabled'); // remove disabled class
          },
          disable: function() {
            /* daElem
               .datepicker('disable') // call native jQuery UI disable
               .dynamicDateTimePicker('disable') // call native jQuery UI disable

             .addClass('apex_disabled');    */

            daElem.item
              .prop('disabled', true)
              .addClass('apex_disabled')
              .addClass('disabled');

            daElem.datepickerButton
              .prop('disabled', true)
              .addClass('disabled');


            console.log(daElem); // add disabled class to ensure value is not POSTed
          },
          afterModify: function() {
            //console.log('afterModify');
            // code to always fire after the item has been modified (value set, enabled, etc.)
          },
          loadingIndicator: function(pLoadingIndicator$) {
            // code to add the loading indicator in the best place for the item
            return pLoadingIndicator$;
          }


        };

      apex.widget.initPageItem(pName, pOptions);
    },


    /**
     * Removes all functionality associated with the oosFromToDatePicker
     * Will remove the change event as well
     * Odds are this will not be called from APEX.
     */
    destroy: function() {

        apex.debug.log(this._scope, 'destroy', this);
        $.Widget.prototype.destroy.apply(this, arguments); // default destroy
        // unregister datepicker
        $(this.element).datepicker('destroy');
      } //destroy
  }); //ui.oosFromToDatePicker

})(apex.jQuery, apex.widget);