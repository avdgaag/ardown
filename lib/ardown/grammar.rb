module Ardown
  module Grammar
    STRONG          = /(?<=\b|\s|^)(\*\*|__)([^\*_]+?)\1/.freeze
    EM              = /(?<=\b|\s|^)(\*|_)([^\*_]+?)\1/.freeze
    IMG             = /!\[([^\]]+?)\]\(([^)]+?)\)/.freeze
    ANCHOR_INLINE   = /\[([^\]]+?)\]\((\S+?)(?: "([^"]+?)")?\)/.freeze
    ANCHOR_REF      = /\[([^\]]+?)\]\[([^)]+?)?\]/.freeze
    HEADING         = /^(\#{1,6}) (.+)$/.freeze
    UL_LI           = /^\* /.freeze
    UL_LI_LINE      = /^(\*| ) /.freeze
    OL_LI_LINE      = /^(\d{1,2}\.|  ) /.freeze
    OL_LI           = /^\d{1,2}\. /.freeze
    REFERENCE       = /^\[([^\]]+?)\]: (\S+)(?: "([^"]+?)")?/.freeze
    BLOCKQUOTE_LINE = /^> ?/.freeze
    PRE_LINE        = /^ {4}/.freeze
    BLOCKQUOTE      = ->(s) { TextHelpers.all_lines_match?(s, BLOCKQUOTE_LINE) }
    PRE             = ->(s) { TextHelpers.all_lines_match?(s, PRE_LINE) }
    BLOCK_OL_LI     = ->(s) { s.lines.first =~ OL_LI && TextHelpers.all_lines_start_with?(s.lines.drop(1).join, '  ') }
    BLOCK_UL_LI     = ->(s) { s.lines.first =~ UL_LI && TextHelpers.all_lines_start_with?(s.lines.drop(1).join, '  ') }
    SUB_BLOCK       = ->(s) { TextHelpers.all_lines_match?(s, /^  \S/)  }
  end
end
