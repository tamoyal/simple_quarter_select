module ActionView::Helpers
  class DateTimeSelector
     def select_month_with_simple_quarter_select
        return select_month_without_simple_quarter_select unless @options[:simple_quarter_select].eql? true
        # Although this is a datetime select, we only care about the time. Assume that the date will
        # be set by some other control, and the date represented here will be overriden      
        # val_month = @datetime.kind_of?(Date) ? @datetime.month : @datetime
        val_month =@datetime.month
        
        @options[:time_separator] = ""
        
        # Default is 3 month intervals (1 Quarter)        
        month_interval = @options[:month_interval] ? @options[:month_interval] : 3

        # @options[:start_month] should be specified in month numbers
        # i.e. 1-12
        start_month = @options[:start_month] ? @options[:start_month] : 1
        
        # @options[:end_month] should be specified in month numbers
        # i.e. 1-12
        end_month = @options[:end_month] ? @options[:end_month] : 12
        
        if @options[:discard_year]
          build_hidden(:year, Time.now.year)
        end
        if @options[:discard_day]
          build_hidden(:day, 1)
        end
        interval_names = @options[:interval_names] ? @options[:interval_names] : ["Q1","Q2","Q3","Q4"]
        
        month_options = []
        interval_iter = 0
        start_month.upto(end_month) do |m|
          if m%month_interval == 1
            val = m
            month_options << ((val_month == m) ?
              %(<option value="#{val}" selected="selected">#{interval_names[interval_iter]}</option>\n) :
              %(<option value="#{val}">#{interval_names[interval_iter]}</option>\n)
            )
            puts "month_options = #{month_options}"
            interval_iter += 1              
          end
        end
        build_select(:month, month_options)
      end
      alias_method_chain :select_month, :simple_quarter_select
  end
end