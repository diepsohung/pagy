# encoding: utf-8
# frozen_string_literal: true

require_relative '../../test_helper'
require 'pagy/extras/bulma'

SingleCov.covered!(uncovered: 1) unless ENV['SKIP_SINGLECOV'] # undefined TRIM for compact helper, tested in trim_test

describe Pagy::Frontend do

  let(:frontend) { TestView.new }
  let(:pagy_test_id) { 'test-id' }

  describe '#pagy_bulma_nav' do

    it 'renders page 1' do
      pagy = Pagy.new(count: 103, page: 1)
      frontend.pagy_bulma_nav(pagy).must_equal \
        "<nav class=\"pagy-bulma-nav pagination is-centered\" role=\"navigation\" aria-label=\"pagination\"><a class=\"pagination-previous\" disabled>&lsaquo;&nbsp;Prev</a><a href=\"/foo?page=2\"   rel=\"next\" class=\"pagination-next\" aria-label=\"next page\">Next&nbsp;&rsaquo;</a><ul class=\"pagination-list\"><li><a href=\"/foo?page=1\"   class=\"pagination-link is-current\" aria-label=\"page 1\" aria-current=\"page\">1</a></li><li><a href=\"/foo?page=2\"   rel=\"next\" class=\"pagination-link\" aria-label=\"goto page 2\">2</a></li><li><a href=\"/foo?page=3\"   class=\"pagination-link\" aria-label=\"goto page 3\">3</a></li><li><a href=\"/foo?page=4\"   class=\"pagination-link\" aria-label=\"goto page 4\">4</a></li><li><a href=\"/foo?page=5\"   class=\"pagination-link\" aria-label=\"goto page 5\">5</a></li><li><a href=\"/foo?page=6\"   class=\"pagination-link\" aria-label=\"goto page 6\">6</a></li></ul></nav>"
    end

    it 'renders intermediate page' do
      pagy = Pagy.new(count: 103, page: 3)
      frontend.pagy_bulma_nav(pagy).must_equal \
        "<nav class=\"pagy-bulma-nav pagination is-centered\" role=\"navigation\" aria-label=\"pagination\"><a href=\"/foo?page=2\"   rel=\"prev\" class=\"pagination-previous\" aria-label=\"previous page\">&lsaquo;&nbsp;Prev</a><a href=\"/foo?page=4\"   rel=\"next\" class=\"pagination-next\" aria-label=\"next page\">Next&nbsp;&rsaquo;</a><ul class=\"pagination-list\"><li><a href=\"/foo?page=1\"   class=\"pagination-link\" aria-label=\"goto page 1\">1</a></li><li><a href=\"/foo?page=2\"   rel=\"prev\" class=\"pagination-link\" aria-label=\"goto page 2\">2</a></li><li><a href=\"/foo?page=3\"   class=\"pagination-link is-current\" aria-label=\"page 3\" aria-current=\"page\">3</a></li><li><a href=\"/foo?page=4\"   rel=\"next\" class=\"pagination-link\" aria-label=\"goto page 4\">4</a></li><li><a href=\"/foo?page=5\"   class=\"pagination-link\" aria-label=\"goto page 5\">5</a></li><li><a href=\"/foo?page=6\"   class=\"pagination-link\" aria-label=\"goto page 6\">6</a></li></ul></nav>"
    end

    it 'renders last page' do
      pagy = Pagy.new(count: 103, page: 6)
      frontend.pagy_bulma_nav(pagy).must_equal \
        "<nav class=\"pagy-bulma-nav pagination is-centered\" role=\"navigation\" aria-label=\"pagination\"><a href=\"/foo?page=5\"   rel=\"prev\" class=\"pagination-previous\" aria-label=\"previous page\">&lsaquo;&nbsp;Prev</a><a class=\"pagination-next\" disabled>Next&nbsp;&rsaquo;</a><ul class=\"pagination-list\"><li><a href=\"/foo?page=1\"   class=\"pagination-link\" aria-label=\"goto page 1\">1</a></li><li><a href=\"/foo?page=2\"   class=\"pagination-link\" aria-label=\"goto page 2\">2</a></li><li><a href=\"/foo?page=3\"   class=\"pagination-link\" aria-label=\"goto page 3\">3</a></li><li><a href=\"/foo?page=4\"   class=\"pagination-link\" aria-label=\"goto page 4\">4</a></li><li><a href=\"/foo?page=5\"   rel=\"prev\" class=\"pagination-link\" aria-label=\"goto page 5\">5</a></li><li><a href=\"/foo?page=6\"   class=\"pagination-link is-current\" aria-label=\"page 6\" aria-current=\"page\">6</a></li></ul></nav>"
    end

  end

  describe "#pagy_bulma_nav_js" do

    it 'renders first page' do
      pagy = Pagy.new(count: 1000, page: 1)
      html = frontend.pagy_bulma_nav_js(pagy, pagy_test_id)
      html.must_equal \
        "<nav id=\"test-id\" class=\"pagy-bulma-nav-js pagination is-centered\" role=\"navigation\" aria-label=\"pagination\"></nav><script type=\"application/json\" class=\"pagy-json\">[\"nav\",\"test-id\",\"#{Pagy::Frontend::MARKER}\",{\"before\":\"<a class=\\\"pagination-previous\\\" disabled>&lsaquo;&nbsp;Prev</a><a href=\\\"/foo?page=2\\\"   rel=\\\"next\\\" class=\\\"pagination-next\\\" aria-label=\\\"next page\\\">Next&nbsp;&rsaquo;</a><ul class=\\\"pagination-list\\\">\",\"link\":\"<li><a href=\\\"/foo?page=#{Pagy::Frontend::MARKER}\\\"   class=\\\"pagination-link\\\" aria-label=\\\"goto page #{Pagy::Frontend::MARKER}\\\">#{Pagy::Frontend::MARKER}</a></li>\",\"active\":\"<li><a href=\\\"/foo?page=#{Pagy::Frontend::MARKER}\\\"   class=\\\"pagination-link is-current\\\" aria-current=\\\"page\\\" aria-label=\\\"page #{Pagy::Frontend::MARKER}\\\">#{Pagy::Frontend::MARKER}</a></li>\",\"gap\":\"<li><span class=\\\"pagination-ellipsis\\\">&hellip;</span></li>\",\"after\":\"</ul>\"},{\"0\":[\"1\",2,3,4,5,\"gap\",50]}]</script>"
    end

    it 'renders intermediate page' do
      pagy = Pagy.new(count: 1000, page: 20)
      html = frontend.pagy_bulma_nav_js(pagy, pagy_test_id)
      html.must_equal \
        "<nav id=\"test-id\" class=\"pagy-bulma-nav-js pagination is-centered\" role=\"navigation\" aria-label=\"pagination\"></nav><script type=\"application/json\" class=\"pagy-json\">[\"nav\",\"test-id\",\"#{Pagy::Frontend::MARKER}\",{\"before\":\"<a href=\\\"/foo?page=19\\\"   rel=\\\"prev\\\" class=\\\"pagination-previous\\\" aria-label=\\\"previous page\\\">&lsaquo;&nbsp;Prev</a><a href=\\\"/foo?page=21\\\"   rel=\\\"next\\\" class=\\\"pagination-next\\\" aria-label=\\\"next page\\\">Next&nbsp;&rsaquo;</a><ul class=\\\"pagination-list\\\">\",\"link\":\"<li><a href=\\\"/foo?page=#{Pagy::Frontend::MARKER}\\\"   class=\\\"pagination-link\\\" aria-label=\\\"goto page #{Pagy::Frontend::MARKER}\\\">#{Pagy::Frontend::MARKER}</a></li>\",\"active\":\"<li><a href=\\\"/foo?page=#{Pagy::Frontend::MARKER}\\\"   class=\\\"pagination-link is-current\\\" aria-current=\\\"page\\\" aria-label=\\\"page #{Pagy::Frontend::MARKER}\\\">#{Pagy::Frontend::MARKER}</a></li>\",\"gap\":\"<li><span class=\\\"pagination-ellipsis\\\">&hellip;</span></li>\",\"after\":\"</ul>\"},{\"0\":[1,\"gap\",16,17,18,19,\"20\",21,22,23,24,\"gap\",50]}]</script>"
    end

    it 'renders last page' do
      pagy = Pagy.new(count: 1000, page: 50)
      html = frontend.pagy_bulma_nav_js(pagy, pagy_test_id)
      html.must_equal \
        "<nav id=\"test-id\" class=\"pagy-bulma-nav-js pagination is-centered\" role=\"navigation\" aria-label=\"pagination\"></nav><script type=\"application/json\" class=\"pagy-json\">[\"nav\",\"test-id\",\"#{Pagy::Frontend::MARKER}\",{\"before\":\"<a href=\\\"/foo?page=49\\\"   rel=\\\"prev\\\" class=\\\"pagination-previous\\\" aria-label=\\\"previous page\\\">&lsaquo;&nbsp;Prev</a><a class=\\\"pagination-next\\\" disabled>Next&nbsp;&rsaquo;</a><ul class=\\\"pagination-list\\\">\",\"link\":\"<li><a href=\\\"/foo?page=#{Pagy::Frontend::MARKER}\\\"   class=\\\"pagination-link\\\" aria-label=\\\"goto page #{Pagy::Frontend::MARKER}\\\">#{Pagy::Frontend::MARKER}</a></li>\",\"active\":\"<li><a href=\\\"/foo?page=#{Pagy::Frontend::MARKER}\\\"   class=\\\"pagination-link is-current\\\" aria-current=\\\"page\\\" aria-label=\\\"page #{Pagy::Frontend::MARKER}\\\">#{Pagy::Frontend::MARKER}</a></li>\",\"gap\":\"<li><span class=\\\"pagination-ellipsis\\\">&hellip;</span></li>\",\"after\":\"</ul>\"},{\"0\":[1,\"gap\",46,47,48,49,\"50\"]}]</script>"
    end

    it 'renders with :sizes' do
      pagy = Pagy.new(count: 1000, page: 20, sizes: {0 => [1,2,2,1], 500 => [2,3,3,2]})
      html = frontend.pagy_bulma_nav_js(pagy, pagy_test_id)
      html.must_equal \
        "<nav id=\"test-id\" class=\"pagy-bulma-nav-js pagination is-centered\" role=\"navigation\" aria-label=\"pagination\"></nav><script type=\"application/json\" class=\"pagy-json\">[\"nav\",\"test-id\",\"#{Pagy::Frontend::MARKER}\",{\"before\":\"<a href=\\\"/foo?page=19\\\"   rel=\\\"prev\\\" class=\\\"pagination-previous\\\" aria-label=\\\"previous page\\\">&lsaquo;&nbsp;Prev</a><a href=\\\"/foo?page=21\\\"   rel=\\\"next\\\" class=\\\"pagination-next\\\" aria-label=\\\"next page\\\">Next&nbsp;&rsaquo;</a><ul class=\\\"pagination-list\\\">\",\"link\":\"<li><a href=\\\"/foo?page=#{Pagy::Frontend::MARKER}\\\"   class=\\\"pagination-link\\\" aria-label=\\\"goto page #{Pagy::Frontend::MARKER}\\\">#{Pagy::Frontend::MARKER}</a></li>\",\"active\":\"<li><a href=\\\"/foo?page=#{Pagy::Frontend::MARKER}\\\"   class=\\\"pagination-link is-current\\\" aria-current=\\\"page\\\" aria-label=\\\"page #{Pagy::Frontend::MARKER}\\\">#{Pagy::Frontend::MARKER}</a></li>\",\"gap\":\"<li><span class=\\\"pagination-ellipsis\\\">&hellip;</span></li>\",\"after\":\"</ul>\"},{\"0\":[1,\"gap\",18,19,\"20\",21,22,\"gap\",50],\"500\":[1,2,\"gap\",17,18,19,\"20\",21,22,23,\"gap\",49,50]}]</script>"
    end

  end

  describe "#pagy_bulma_compact_nav_js" do

    it 'renders first page' do
      pagy = Pagy.new(count: 103, page: 1)
      html = frontend.pagy_bulma_compact_nav_js(pagy, pagy_test_id)
      html.must_equal \
        "<nav id=\"test-id\" class=\"pagy-bulma-compact-nav\" role=\"navigation\" aria-label=\"pagination\"><a href=\"/foo?page=#{Pagy::Frontend::MARKER}\"   style=\"display: none;\"></a><div class=\"field is-grouped is-grouped-centered\" role=\"group\"><p class=\"control\"><a class=\"button\" disabled>&lsaquo;&nbsp;Prev</a></p><div class=\"pagy-compact-input control level is-mobile\">Page <input class=\"input\" type=\"number\" min=\"1\" max=\"6\" value=\"1\" style=\"padding: 0; text-align: center; width: 2rem; margin:0 0.3rem;\"> of 6</div><p class=\"control\"><a href=\"/foo?page=2\"   rel=\"next\" class=\"button\" aria-label=\"next page\">Next&nbsp;&rsaquo;</a></p></div></nav><script type=\"application/json\" class=\"pagy-json\">[\"compact_nav\",\"test-id\",\"#{Pagy::Frontend::MARKER}\",1,false]</script>"
    end

    it 'renders intermediate page' do
      pagy = Pagy.new(count: 103, page: 3)
      html = frontend.pagy_bulma_compact_nav_js(pagy, pagy_test_id)
      html.must_equal \
        "<nav id=\"test-id\" class=\"pagy-bulma-compact-nav\" role=\"navigation\" aria-label=\"pagination\"><a href=\"/foo?page=#{Pagy::Frontend::MARKER}\"   style=\"display: none;\"></a><div class=\"field is-grouped is-grouped-centered\" role=\"group\"><p class=\"control\"><a href=\"/foo?page=2\"   rel=\"prev\" class=\"button\" aria-label=\"previous page\">&lsaquo;&nbsp;Prev</a></p><div class=\"pagy-compact-input control level is-mobile\">Page <input class=\"input\" type=\"number\" min=\"1\" max=\"6\" value=\"3\" style=\"padding: 0; text-align: center; width: 2rem; margin:0 0.3rem;\"> of 6</div><p class=\"control\"><a href=\"/foo?page=4\"   rel=\"next\" class=\"button\" aria-label=\"next page\">Next&nbsp;&rsaquo;</a></p></div></nav><script type=\"application/json\" class=\"pagy-json\">[\"compact_nav\",\"test-id\",\"#{Pagy::Frontend::MARKER}\",3,false]</script>"
    end

    it 'renders last page' do
      pagy = Pagy.new(count: 103, page: 6)
      html = frontend.pagy_bulma_compact_nav_js(pagy, pagy_test_id)
      html.must_equal \
        "<nav id=\"test-id\" class=\"pagy-bulma-compact-nav\" role=\"navigation\" aria-label=\"pagination\"><a href=\"/foo?page=#{Pagy::Frontend::MARKER}\"   style=\"display: none;\"></a><div class=\"field is-grouped is-grouped-centered\" role=\"group\"><p class=\"control\"><a href=\"/foo?page=5\"   rel=\"prev\" class=\"button\" aria-label=\"previous page\">&lsaquo;&nbsp;Prev</a></p><div class=\"pagy-compact-input control level is-mobile\">Page <input class=\"input\" type=\"number\" min=\"1\" max=\"6\" value=\"6\" style=\"padding: 0; text-align: center; width: 2rem; margin:0 0.3rem;\"> of 6</div><p class=\"control\"><a class=\"button\" disabled>Next&nbsp;&rsaquo;</a></p></div></nav><script type=\"application/json\" class=\"pagy-json\">[\"compact_nav\",\"test-id\",\"#{Pagy::Frontend::MARKER}\",6,false]</script>"
    end

  end

end
