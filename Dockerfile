# Base image với Node.js 18
FROM node:18.17.0

# Cài đặt Bash, PostgreSQL client, jq, git và các công cụ cần thiết
RUN apt-get update && apt-get install -y \
    bash \
    postgresql-client \
    jq \
    git \
    && apt-get clean

# Đặt Bash làm shell mặc định
SHELL ["/bin/bash", "-c"]

# Cài đặt pnpm
RUN npm install -g pnpm

# Tạo thư mục làm việc
WORKDIR /app

# Copy toàn bộ source code vào container
COPY . .

# Cài đặt dependencies
RUN pnpm install --frozen-lockfile

# Build dự án
RUN make deps && make build

# Cổng cần expose (tuỳ thuộc vào ứng dụng)
EXPOSE 2583 2584 2587 60636 60638

# Command để khởi chạy môi trường dev
CMD ["make", "run-dev-env"]
