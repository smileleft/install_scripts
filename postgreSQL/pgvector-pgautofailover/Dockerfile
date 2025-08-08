# 1. pgvector의 공식 이미지를 베이스로 사용합니다. (PostgreSQL 17 버전 기준)
FROM pgvector/pgvector:pg17

# 2. root 권한으로 전환합니다.
USER root

# 3. 필요한 패키지 설치 및 PGP 키 추가 (최신 권장 방식 적용)
RUN apt-get update && apt-get install -y --no-install-recommends \
    # ca-certificates를 먼저 설치하여 HTTPS 통신 문제를 해결합니다.
    ca-certificates \
    curl \
    gnupg \
    && install -m 0755 -d /etc/apt/keyrings \
    # curl로 키를 다운로드하여 gpg로 변환 후, 지정된 경로에 저장합니다. (apt-key 대신 사용)
    && curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /etc/apt/keyrings/postgresql.gpg \
    # 새로 추가한 키를 사용하도록 저장소 목록을 생성합니다.
    && echo "deb [signed-by=/etc/apt/keyrings/postgresql.gpg] http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
    # 새 저장소 목록으로 패키지 리스트를 다시 업데이트합니다.
    && apt-get update \
    # pgautofailover를 설치합니다.
    && apt-get install -y --no-install-recommends pgautofailover-pg17 \
    # 설치 후 불필요한 캐시를 정리하여 이미지 용량을 줄입니다.
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 4. 다시 postgres 사용자로 전환합니다.
USER postgres
