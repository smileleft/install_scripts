-- 각 행이 저장된 실제 테이블(파티션) 이름 확인
SELECT id, message_id, source_type, title, tableoid::regclass AS stored_in
FROM reports
WHERE message_id IN ('MSG-001', 'MSG-002', 'MSG-003', 'MSG-004')
ORDER BY id;

-- 파티션별 카운트 빠르게 보기
SELECT 'reports_normal' AS tbl, count(*) FROM reports_normal
UNION ALL
SELECT 'reports_crawled' AS tbl, count(*) FROM reports_crawled;
