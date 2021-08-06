
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

  def link_to_cart(text = nil)
    text = text ? h(text) : t('spree.cart')
    css_class = nil

    if current_order.nil? || current_order.item_count.zero?
      text = "#{text}: (#{t('spree.empty')})"
      css_class = 'empty'
    else
      text = "#{text}: (#{current_order.item_count})  <span class='amount'>#{current_order.display_total.to_html}</span>"
      css_class = 'full'
    end

    link_to text.html_safe, spree.cart_path, class: "nav-link cart-info #{css_class}"
  end


  def taxons_tree(root_taxon, current_taxon, max_level = 1)
    return '' if max_level < 1 || root_taxon.children.empty?
    content_tag :ul, class: 'taxons-list btn-toggle-nav list-unstyled fw-normal pb-1 small' do
      taxons = root_taxon.children.map do |taxon|
        css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'current' : nil
        content_tag :li, class: css_class do
         link_to(taxon.name, seo_url(taxon)) +
           taxons_tree(taxon, current_taxon, max_level - 1)
        end
      end
      safe_join(taxons, "\n")
    end
  end
end
end