module AppHelper

  def comment_status
    logger.info "Blacklisted words: #{BLACKLISTED_WORDS.to_a}"
    # checking black_listed words
    blacklisted_words = params[:comment_text]&.scan(/\b(?:#{BLACKLISTED_WORDS.join('|')})\b/i)
    blacklisted_words.present? ? 'P' : 'A'
  end

  # Regexp.union(PROFANITY_FILTER) => /Fuck|Fucked|Shit|Piss|Pissed|Dick|Asshole|Bastard|Damn|Cunt|coward/
  # Regexp.union(PROFANITY_FILTER).source => "Fuck|Fucked|Shit|Piss|Pissed|Dick|Asshole|Bastard|Damn|Cunt|coward"
  def highlight_blacklisted_words
    params[:comment_text]&.gsub(/(#{Regexp.union(BLACKLISTED_WORDS).source})/i) { |s| "<<#{s}>>" }
  end

end
