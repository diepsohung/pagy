# See the Pagy documentation: https://ddnexus.github.io/pagy/extras/semantic
# encoding: utf-8
# frozen_string_literal: true

require 'pagy/extras/shared'

class Pagy
  module Frontend

    # Pagination for semantic-ui: it returns the html with the series of links to the pages
    def pagy_semantic_nav(pagy)
      link, p_prev, p_next = pagy_link_proc(pagy, 'class="item"'), pagy.prev, pagy.next

      html = EMPTY + (p_prev ? %(#{link.call p_prev, '<i class="left small chevron icon"></i>', 'aria-label="previous"'})
                             : %(<div class="item disabled"><i class="left small chevron icon"></i></div>))
      pagy.series.each do |item|  # series example: [1, :gap, 7, 8, "9", 10, 11, :gap, 36]
        html << if    item.is_a?(Integer); %(#{link.call item})                      # page link
                elsif item.is_a?(String) ; %(<a class="item active">#{item}</a>)     # current page
                elsif item == :gap       ; %(<div class="disabled item">...</div>)   # page gap
                end
      end
      html << (p_next ? %(#{link.call p_next, '<i class="right small chevron icon"></i>', 'aria-label="next"'})
                      : %(<div class="item disabled"><i class="right small chevron icon"></i></div>))
      %(<div class="pagy-semantic-nav ui pagination menu" aria-label="pager">#{html}</div>)
    end

    # Semantic js pagination: it returns an empty nav, plus the JSON needed for the javascript render
    def pagy_semantic_nav_js(pagy, id=pagy_id)
      link, p_prev, p_next = pagy_link_proc(pagy, 'class="item"'), pagy.prev, pagy.next
      tags = { 'before' => (p_prev ? %(#{link.call(p_prev, '<i class="left small chevron icon"></i>', 'aria-label="previous"')})
                                   : %(<div class="item disabled"><i class="left small chevron icon"></i></div>)),
               'link'   => %(#{link.call(MARKER)}),
               'active' => %(<a class="item active">#{pagy.page}</a>),
               'gap'    => %(<div class="disabled item">#{pagy_t('pagy.nav.gap')}</div>),
               'after'  => (p_next ? %(#{link.call(p_next, '<i class="right small chevron icon"></i>', 'aria-label="next"')})
                                   : %(<div class="item disabled"><i class="right small chevron icon"></i></div>)) }
      %(<div id="#{id}" class="pagy-semantic-nav-js ui pagination menu" role="navigation" aria-label="pager"></div>#{pagy_json_tag(:nav, id, MARKER, tags, pagy.multi_series)})
    end

    # Compact pagination for semantic: it returns the html with the series of links to the pages
    # we use a numeric input tag to set the page and the Pagy.compact javascript to navigate
    def pagy_semantic_compact_nav_js(pagy, id=pagy_id)
      link, p_prev, p_next, p_page, p_pages = pagy_link_proc(pagy, 'class="item"'), pagy.prev, pagy.next, pagy.page, pagy.pages

      html = %(<div id="#{id}" class="pagy-semantic-compact-nav ui compact menu" role="navigation" aria-label="pager">) \
           + link.call(MARKER, '', %(style="display: none;" ))
        (html << link.call(1, '', %(style="display: none;" ))) if defined?(TRIM)
        html << (p_prev ? %(#{link.call p_prev, '<i class="left small chevron icon"></i>', 'aria-label="previous"'})
                        : %(<div class="item disabled"><i class="left small chevron icon"></i></div>))
        input = %(<input type="number" min="1" max="#{p_pages}" value="#{p_page}" style="padding: 0; text-align: center; width: #{p_pages.to_s.length+1}rem; margin: 0 0.3rem">)
        html << %(<div class="pagy-compact-input item">#{pagy_t('pagy.compact', page_input: input, count: p_page, pages: p_pages)}</div> )
        html << (p_next ? %(#{link.call p_next, '<i class="right small chevron icon"></i>', 'aria-label="next"'})
                        : %(<div class="item disabled"><i class="right small chevron icon"></i></div>))
      html << %(</div>#{pagy_json_tag(:compact_nav, id, MARKER, p_page, !!defined?(TRIM))})
    end

  end
end
