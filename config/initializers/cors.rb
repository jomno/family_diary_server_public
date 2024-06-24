Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:3000", "http://127.0.0.1:3000", "http://172.30.1.6:3000", "https://family.fivedice.site" # 허용할 도메인 설정
    resource "*",
      headers: :any,
      expose: %w[Authorization],
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
end
