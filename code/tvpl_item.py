import scrapy
import pandas as pd
import logging

logging.getLogger('scrapy.core.scraper').addFilter(
    lambda x: not x.getMessage().startswith('Scraped from'))


class Lawpider(scrapy.Spider):
    name = 'lawspider'
    start_urls = ['https://thuvienphapluat.vn/archive/default.aspx']
    allowed_domains = ['thuvienphapluat.vn']
    custom_settings = {
        "COOKIES_ENABLED": False,
        # "DOWNLOADER_MIDDLEWARES": {
        #     'scrapy.downloadermiddlewares.useragent.UserAgentMiddleware': None,
        #     'scrapy_user_agents.middlewares.RandomUserAgentMiddleware': 400,
        # }
    }

    # url from a file
    def start_requests(self):
        df = pd.read_csv('data/urls.csv')
        for url in df['url']:
            yield scrapy.Request(url=url, callback=self.parse_item)

    def parse_item(self, response):
        id = response.url.replace('.aspx', '').split('-')[-1]
        content = response.xpath('//*[@id="divContentDoc"]/div')[0].extract()

        follow_url = 'https://thuvienphapluat.vn/AjaxLoadData/LoadLuocDo.aspx?LawID={}&IstraiNghiem=True'.format(
            id)
        headers = {
            'referer': response.url,
        }
        data = {
            'content': content,
            'url': response.url,
        }
        yield scrapy.Request(follow_url, headers=headers, callback=self.parse_metadata,
                             meta={
                                 'data': data,
                             })

    def parse_metadata(self, response):
        data = response.meta['data']
        data['metadata'] = response.text
        yield data
