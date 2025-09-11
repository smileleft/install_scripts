-- normal 케이스 (reports_normal로 들어가야 함)
INSERT INTO reports (
  source_type, message_id, title, type,
  create_dt, update_dt, create_user_id, last_update_user_id,
  category, security_level, identification_details
) VALUES (
  'normal', 'MSG-001', 'Normal report title', 'daily',
  now(), now(), 'u1', 'u1',
  'ops', 'internal', 'N/A'
);

-- crawled 케이스 (reports_crawled로 들어가야 함)
INSERT INTO reports (
  source_type, message_id, title,
  article_url, crawl_dt, source_site, raw_html,
  create_dt, update_dt, create_user_id, last_update_user_id,
  category, security_level
) VALUES (
  'crawled', 'MSG-002', 'Crawled: Example News',
  'https://example.com/article-123',
  now() - interval '2 hours',
  'Example News', '<html>original payload...</html>',
  now(), now(), 'crawler', 'crawler',
  'news', 'public'
);
