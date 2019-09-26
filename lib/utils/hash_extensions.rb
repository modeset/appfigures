  
class Hash
  def to_query_string(include_question_mark = true)
    query_string = ''
    unless empty?
      query_string << '?' if include_question_mark
      query_string << inject([]) do |params, (key, value)| 
        params << "#{key}=#{value}" 
      end.join('&')
    end
    query_string
  end
end
