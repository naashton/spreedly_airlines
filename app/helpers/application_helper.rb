module ApplicationHelper
    def format_amount(amount)
        if amount
            ActiveSupport::NumberHelper.number_to_currency(
                amount/100.0
            )
        else
            "0.00"
        end
    end
end
