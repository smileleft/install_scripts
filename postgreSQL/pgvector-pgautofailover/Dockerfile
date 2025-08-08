# 1. pgvector의 공식 이미지를 베이스로 사용합니다. (PostgreSQL 17 버전 기준)
FROM pgvector/pgvector:pg17

# 2. root 권한으로 전환합니다.
USER root

# 3. 필요한 패키지 설치 및 PGP 키 추가 (최신 권장 방식 적용)
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    && install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /etc/apt/keyrings/postgresql.gpg \
    # [수정됨] lsb_release 대신 /etc/os-release 파일에서 직접 코드명을 읽어오도록 변경
    && echo "deb [signed-by=/etc/apt/keyrings/postgresql.gpg] http://apt.postgresql.org/pub/repos/apt $(. /etc/os-release && echo $VERSION_CODENAME)-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends pgautofailover-pg17 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 4. 다시 postgres 사용자로 전환합니다.
USER postgres
