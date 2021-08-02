
module Spree
    module BaseHelper

  def nav_tree(root_taxon, current_taxon, max_level = 1)
    return '' if max_level < 1 || root_taxon.children.empty?
    content_tag :ul, class: 'dropdown-menu' do
      taxons = root_taxon.children.map do |taxon|
        css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'current' : nil
        content_tag :li, class: 'dropdown-item' do
         link_to(taxon.name, seo_url(taxon)) +
           nav_tree(taxon, current_taxon, max_level - 1)
        end
      end
      safe_join(taxons, "\n")
    end
  end
end
end