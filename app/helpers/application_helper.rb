module ApplicationHelper
	class CodeRayify < Redcarpet::Render::HTML
	  def block_code(code, language)
	    CodeRay.scan(code, language).div
	  end
	end

	def markdown(text)
	  coderayified = CodeRayify.new(:filter_html => true, 
	                                :hard_wrap => true)
	  options = {
	    :fenced_code_blocks => true,
	    :no_intra_emphasis => true,
	    :autolink => true,
	    :strikethrough => true,
	    :lax_html_blocks => true,
	    :superscript => true
	  }
	  markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
	  markdown_to_html.render(choose_language('python', text)).html_safe
	end

	def choose_language(language, code)
		labeled_code = String(code)
		return "``` " + language + "\n" + labeled_code + "\n```"
	end

	def get_tags_for_user(user)
		tags = Set.new
		user.posts.each do |post|
		  post.tags.each do |tag|
		  	tags.add(tag.name)
		  end
		end
		return tags
	end
end
