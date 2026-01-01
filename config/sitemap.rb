SitemapGenerator::Sitemap.default_host = "https://www.gallery-core.com"
SitemapGenerator::Sitemap.public_path = 'public/'
SitemapGenerator::Sitemap.create_index = false

SitemapGenerator::Sitemap.create do
  add '/', changefreq: 'weekly', priority: 1.0
  add '/bg', changefreq: 'weekly', priority: 1.0
  add '/en', changefreq: 'weekly', priority: 1.0

  Category.authorised.find_each do |category|
    add "/bg/categories/#{category.id}", changefreq: 'monthly'
    add "/en/categories/#{category.id}", changefreq: 'monthly'
  end
end
