module UsersHelper
    def user_error_messages(field, errors)
        messages = ""
        errors.each do |e|
           messages << "#{field.capitalize} #{e}. " 
        end
        messages
    end
    
end