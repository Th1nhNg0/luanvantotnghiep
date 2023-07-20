import scrapy
from scrapy.spiders import CrawlSpider, Rule
from scrapy.linkextractors import LinkExtractor

import logging

logging.getLogger('scrapy.core.scraper').addFilter(
    lambda x: not x.getMessage().startswith('Scraped from'))


class Lawpider(CrawlSpider):
    name = 'lawspider'
    start_urls = ['https://thuvienphapluat.vn/archive/default.aspx']
    allowed_domains = ['thuvienphapluat.vn']
    rules = (
        Rule(LinkExtractor(allow=('/archive/')),
             callback='parse_links', follow=True),
    )

    def parse_links(self, response):
        links = response.css('a')
        for link in links:
            name = link.css('::text').get()
            if '/van-ban/' in link.attrib['href']:
                yield {
                    'name': name,
                    'url': link.attrib['href'],
                }
