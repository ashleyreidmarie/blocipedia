module ApplicationHelper
    def markdown(text)
        renderer = Redcarpet::Render::HTML.new(escape_html: true, with_toc_data: true)
        markdown = Redcarpet::Markdown.new(renderer)
        markdown.render(text).html_safe
    end
    
    def table_of_contents(page_content)
       renderer = Redcarpet::Render::HTML_TOC
       table_of_contents = Redcarpet::Markdown.new(renderer)
       table_of_contents.render(page_content).html_safe
    end
end
