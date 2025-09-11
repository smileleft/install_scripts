-- reports_normal 에 직접 insert (source_type 꼭 일치)
INSERT INTO reports_normal (
  source_type, message_id, title, type,
  create_dt, update_dt, create_user_id, last_update_user_id
) VALUES (
  'normal', 'MSG-003', 'Direct insert to NORMAL', 'incident',
  now(), now(), 'u2', 'u2'
);

-- reports_crawled 에 직접 insert (NOT NULL 컬럼: article_url, crawl_dt 필수)
INSERT INTO reports_crawled (
  source_type, message_id, title,
  article_url, crawl_dt, source_site,
  create_dt, update_dt, create_user_id, last_update_user_id
) VALUES (
  'crawled', 'MSG-004', 'Direct insert to CRAWLED',
  'https://example.com/another-article',
  now(), 'Another News',
  now(), now(), 'crawler', 'crawler'
);
